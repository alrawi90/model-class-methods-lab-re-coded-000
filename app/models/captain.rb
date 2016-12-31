class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications
  def self.catamaran_operators
  	Captain.distinct("captains.id").joins(:classifications).where("classifications.name = ?","Catamaran")
  end
  def self.sailors
  	  Captain.distinct("captains.id").joins(:classifications).where("classifications.name = ?","Sailboat")
  end
    def self.motorboaters
  	  Captain.distinct("captains.id").joins(:classifications).where("classifications.name = ?","Motorboat")
  end
  def self.talented_seamen
     target_ids= self.sailors & self.motorboaters
  	Captain.where("id in (?)", target_ids)
  end
  def self.non_sailors
      target_ids= self.sailors.pluck(:id) 
  	  Captain.where("id not in (?)", target_ids)
  end
end


