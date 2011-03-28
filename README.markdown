# simple_versioning for ActiveRecord

Simple versioning is a plain vanilla versioning support. It simply tracks all your attributes in a polymorphically associated model.

## Installation

In the Gemfile:  

    gem 'simple_versioning'

Next, generate a simple migration, call it anything you like, the content needs to be (I'll add a generator in a couple of days):  

    def self.up
      create_table :versions do |t|
        t.belongs_to :versioned, :polymorphic => true
        t.text    :yaml
        t.integer :number
        t.timestamps
      end
    
      change_table :versions do |t|
        t.index [:versioned_id, :versioned_type]
        t.index :number
        t.index :created_at
      end
    end
    
    def self.down
      drop_table :versions
    end


## Example

To version an ActiveRecord model, simply add `track` to your class like so:

    class User < ActiveRecord::Base
      track
  
      validates_presence_of :first_name, :last_name
  
      def name
        "#{first_name} #{last_name}"
      end
    end
  
Thats it!

    >> u = User.create(:first_name => "Yukihiro", :last_name => "Matsumoto")
    => #<User first_name: "Yukihiro", last_name: "Matsumoto">
    >> u.version_number
    => 1
    >> u.update_attribute(:last_name, "Matz")
    => true
    >> u.name
    => "Yukihiro Matz"
    >> u.version_number
    => 2
    >> u.revert_to(1)
    => 1
    >> u.name
    => "Yukihiro Matsumoto"
    >> u.version_number
    => 1
    >> u.save
    => true
    >> u.version_number
    => 3
    >> u.update_attribute(:last_name, "Matsumoto II")
    => true
    >> u.name
    => "Yukihiro Matsumoto II"
    >> u.version_number
    => 4


### What is coming in 0.0.2

- Save without versioning
- Mutator methods


== Thanks!

Thanks to laserlemon[http://github.com/laserlemon] and his `vestal_versions` gem
