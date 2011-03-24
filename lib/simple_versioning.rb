require 'simple_versioning/version'

module SimpleVersioning
  module ClassMethods
    def track(options = {}, &block)
      options.merge!(
        :as => :versioned,
        :class_name => 'SimpleVersioning::Version'
      )
      has_many :versions, options, &block
      before_save :prepare_version
    end
  end

  module InstanceMethods
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    def prepare_version
      return false unless changed?
      self.versions.build :yaml => attributes, :number => version_number
    end

    def version_number
      self.versions.maximum(:number).to_i + 1
    end

    def revert_to(revision)
      @revert_to = self.versions.find_by_number revision
      return false unless @revert_to.present?
      @revert_to.yaml.each do |attribute_name, value|
        write_attribute(attribute_name, value)
      end
      @revert_to.number
    end
  end
end
