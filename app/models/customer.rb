class Customer < ApplicationRecord
	mount_uploader :attachement, AttachmentUploader 
end
