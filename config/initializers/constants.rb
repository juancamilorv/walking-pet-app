require 'soda/client'

client = SODA::Client.new({ domain: 'www.datos.gov.co', app_token: 'cGFDfF0LO9ZIpvYAf64fE6wfA' })

results = client.get('xdk5-pm3f')
colombia = {}
regions = []
cities = []

results.read_body.each do |location|
  if colombia.key?(location.departamento)
    colombia[location.departamento] << location.municipio
  else
    colombia[location.departamento] = [location.municipio]
    regions << location.departamento
  end
  cities << location.municipio
end

COLOMBIA = colombia.freeze
REGIONS = regions.freeze
CITIES = cities.freeze

IMAGES = ["https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173641/DALL_E_2022-10-07_15.06.13_-_office_photo_portrait_of_one_white_man_rtwdof.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173642/DALL_E_2022-10-07_15.06.15_-_office_photo_portrait_of_one_white_man_ifctny.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173640/DALL_E_2022-10-07_15.06.09_-_office_photo_portrait_of_one_white_man_chrr8o.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173639/DALL_E_2022-10-07_15.07.41_-_office_photo_portrait_of_one_white_teen_nyznip.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173639/DALL_E_2022-10-07_15.06.52_-_office_photo_portrait_of_one_white_woman_fzkbbs.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173639/DALL_E_2022-10-07_15.07.37_-_office_photo_portrait_of_one_white_teen_oixyva.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173638/DALL_E_2022-10-07_15.06.21_-_office_photo_portrait_of_one_white_man_udidxo.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173637/DALL_E_2022-10-07_15.06.58_-_office_photo_portrait_of_one_white_woman_xb9kkr.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173636/DALL_E_2022-10-07_15.06.48_-_office_photo_portrait_of_one_white_woman_vrr9td.png",
"https://res.cloudinary.com/dpcj8gyeu/image/upload/v1665173635/DALL_E_2022-10-07_15.06.55_-_office_photo_portrait_of_one_white_woman_c44beo.png"]
