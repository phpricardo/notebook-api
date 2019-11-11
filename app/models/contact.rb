class Contact < ApplicationRecord
  belongs_to :kind #, optional: true
  has_many :phones
  has_one :address

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phones, allow_destroy: true

  def as_json(options={})
    h = super(options)
    h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
    h
  end

  # def birthdate_br
  #   I18n.l(self.birthdate) unless self.birthdate.blank?
  # end

  # def to_br
  #   { 
  #     name:  self.name,
  #     email: self.email,
  #     borthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?) 
  #    }
  # end

  # def author
  #   "Ricardo Lima"
  # end
  
  # def kind_description
  #   self.kind.description
  # end

  # # sobrescreve o as_json
  # def as_json(options={})
  #   super(
  #     methods: [:kind_description, :author], 
  #     root: true,
  #     # include: { kind: { only: :description } }
  #   )
  # end
end
