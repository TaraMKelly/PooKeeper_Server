class Animal < ActiveRecord::Base
    has_many :animal_logs, dependent: :destroy
    has_many :zookeepers, through: :animal_logs

    def age
        DateTime.now.year - self.birthdate.slice(-4,4).to_i
    end

    def self.oldest
        self.all.max_by{|a| a.age}
    end

    def self.alphabetical
        self.all.sort{|a, b| a.name <=> b.name}
    end

end
