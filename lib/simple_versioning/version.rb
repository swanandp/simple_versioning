require 'active_record'

module SimpleVersioning
  VERSION = "0.0.1.2"

  class Version < ActiveRecord::Base
    validates_numericality_of :number, :only_integer => true, :greater_than => 0
    serialize :yaml, Hash
  end
end
