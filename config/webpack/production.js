process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

// CompressionPlugin 6 treats [path] as the directory, so retain each asset's base name.
environment.plugins.get('Compression').options.filename = '[path][base].gz'
if ('brotli' in process.versions) {
  environment.plugins.get('Compression Brotli').options.filename = '[path][base].br'
}

module.exports = environment.toWebpackConfig()
