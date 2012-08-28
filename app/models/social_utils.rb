module SocialUtils

  def self.included( base ) 
    base.extend ClassMethods
    base.class_eval { include InstanceMethods }
  end
    
  module ClassMethods

    def linkedin_username(auth)
      return unless auth.provider == 'linkedin'
      if url = auth.info.urls.public_profile
        url[url.rindex('/')+1..-1]
      end
    end

  end

  module InstanceMethods
  end

end
