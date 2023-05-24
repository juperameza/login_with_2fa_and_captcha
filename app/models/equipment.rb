class Equipment < ApplicationRecord

  enum status: [:disponible, :fuera_de_servicio, :mantenimiento]
  after_initialize :set_default_status, :if => :new_record?

    def set_default_status
      self.status ||= :disponible
    end

    def self.search(search)
      if search
        where('name LIKE ?', "%#{search}%")
      else
        all
      end
    end
end
