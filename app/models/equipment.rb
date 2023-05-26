class Equipment < ApplicationRecord

  enum status: ["Disponible", "Fuera de servicio", "En mantenimiento"]


    def self.search(search)
      if search
        where({name: search})
      else
        all
      end
    end
end
