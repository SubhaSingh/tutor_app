Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 's3.amazonaws.com'

Mime::Type.unregister(:pdf)
Mime::Type.register "application/force-download", :pdf, [], %w(pdf)