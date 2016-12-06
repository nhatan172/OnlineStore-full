class AddressList < ApplicationRecord
  belongs_to :ward
  belongs_to :user

  def to_string
  	w = Ward.find_by_id(self.ward_id)
  	d = District.find_by_id(w.district_id)
  	r = Province.find_by_id(d.province_id)
  	s = self.address + ', ' + w.unit + ' ' + w.name + ', ' + d.unit + ' ' + d.name + ', ' + r.unit + ' ' + r.name
  end
end
