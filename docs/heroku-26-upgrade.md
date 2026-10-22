# Ruby and Heroku stack upgrade

Target: Ruby 3.4.11, Node.js 24.x, Yarn 1.22.22, and Heroku-26.
The existing app is `othwholesale`, currently on Heroku-22 with
`heroku/nodejs` followed by `heroku/ruby`. Keep that buildpack order.

## Local setup on macOS

If rbenv and ruby-build were installed with Homebrew:

```sh
brew update
brew upgrade ruby-build
rbenv install -s 3.4.11
```

Check out the upgrade branch, then verify `ruby -v` reports 3.4.11.
Install the Bundler version recorded under `BUNDLED WITH` in `Gemfile.lock`,
then run `bundle install`. Use Node 24 and Yarn 1.22.22, and run
`yarn install --frozen-lockfile`.

The repository pins the Rails 6.1 release line to keep this runtime upgrade
separate from a Rails migration. Avoid an unrestricted `bundle update`.
The older Rails and Shopify libraries will still need their own maintenance work.

The Yarn resolution for `compression-webpack-plugin` is intentional: Webpacker's
4.x compression dependency calls OpenSSL's removed MD4 implementation. Version
6.1.2 supports Webpack 4 and uses Webpack's hashing implementation. Yarn will
warn about the overridden version range. Keep this override until replacing
Webpacker; no `--openssl-legacy-provider` setting is required.
The production Webpack configuration also uses the plugin's new filename
placeholders so each JavaScript file keeps its own gzip and Brotli output.

## Validate before production

Test on an isolated staging app with its own database and test credentials.
Do not copy production integration credentials into a test app. Customer status
changes can create Shopify customers, send invitations or mail, and push to
NetSuite through Supersync. Mock those services or use their sandbox accounts
when exercising customer updates.

Verify bundle installation, production asset compilation, application boot,
login, application forms, customer views, CSV exports, uploads, and customer
updates. The app does not require a database migration for this upgrade.

First validate the runtime changes on Heroku-22, then rebuild the same source
on Heroku-26. Review notes for both Heroku-24 and Heroku-26 when moving from 22.
A local check on Ubuntu 24.04 is not a substitute for a Heroku-26 staging build.

## Production deployment after validation

Record the current release and confirm the deployed commit before deploying:

```sh
heroku releases --app othwholesale
git status --short --branch
git log -1 --oneline
```

Deploy the reviewed runtime commit on the existing stack through the app's
normal deployment method. Verify that release before changing the stack.

For a Heroku Git deployment, after the runtime release has passed checks:

```sh
heroku stack:set heroku-26 --app othwholesale
git commit --allow-empty -m "Rebuild on Heroku-26"
git push heroku HEAD:master
heroku stack --app othwholesale
heroku ps --app othwholesale
heroku logs --num 100 --app othwholesale
heroku run ruby -v --app othwholesale
```

Run the push only from the reviewed deployment branch. If the app deploys from
GitHub or a pipeline, trigger the build through that workflow instead. Setting
the stack alone does not upgrade an existing release; a new build is required.
Keep the GitHub deployment branch synchronized with any deployment-only commit.

## Rollback

Use the known-good release recorded immediately before the failed change:

```sh
heroku rollback vNN --app othwholesale
```

Replace `vNN` with the recorded release number. Check the active and next-build
stack with `heroku stack --app othwholesale`. If rolling back the stack change,
set the next-build stack back to `heroku-22` before another deploy. A release
rollback does not undo database writes or external integration actions.

References:
- https://devcenter.heroku.com/articles/ruby-support-reference
- https://devcenter.heroku.com/articles/upgrading-to-the-latest-stack
- https://devcenter.heroku.com/articles/heroku-24-stack
- https://devcenter.heroku.com/articles/heroku-26-stack
