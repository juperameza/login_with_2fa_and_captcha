class Client < ApplicationRecord
    def age
        now = Time.now.utc.to_date
        now.year - self.birthdate.year - (self.birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
      end
end
