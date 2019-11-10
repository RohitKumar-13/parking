# README

* Ruby version
**2.6.3**

* Rails Version
**6.0.0**

* System dependencies
**MySQL**

* Database creation and updating with CSV and Availability

    `rake db:setup`

    `rake db:migrate`

    `rake parking:load:csv`

    `rake parking:load:availability`

* How to run server

    `rails s`
    
* How to run the test suite

    `rspec spec`

## Models

####1. Car Parking
Columns
- car_park_no
- address
- x_coord
- y_coord
- car_park_type
- type_of_parking_system
- short_term_parking
- free_parking
- night_parking
- car_park_decks
- gantry_height
- car_park_basement

```ruby
class CarParking < ApplicationRecord
  has_many :parking_lots, primary_key: :car_park_no, foreign_key: :carpark_number
  
  scope :order_by_nearest_to, ->(lat, lng) {
    # logic to order by distance
  }
  
  scope :available, -> {
    # logic to return only available car parking
  }
end
```

####2. Parking Lot 
Columns
- carpark_number,
- total_lots
- lot_type
- lots_available

```ruby
class ParkingLot < ApplicationRecord
  belongs_to :car_parking, foreign_key: :carpark_number, primary_key: :car_park_no
end
````


### Filter

#### CarParkingFilter
This filter is responsible for giving Car Parking based on filter params passed to this class
```ruby
class CarParkingFilter
  attr_accessor :car_parkings, :params
 
  def filter
    order_by_nearest
    paginate
    self
  end
 
  private
 
  # private methods here
end
```


## Sample API
**Request**

GET `http://localhost:3000/carparks/nearest?latitude=1.37326&longitude=103.897&page=1&per_page=3`

**Response**
```json
[
  {
    "address": "BLK 464-468 HOUGANG AVENUE 10",
    "latitude": 1.37326,
    "longitude": 103.897,
    "distance": 0.003888770877809203,
    "total_slots": 433,
    "available_slots": 257
  },
  {
    "address": "BLK 401-413, 460-463 HOUGANG AVENUE 10",
    "latitude": 1.37429,
    "longitude": 103.896,
    "distance": 0.17427588611215808,
    "total_slots": 705,
    "available_slots": 288
  },
  {
    "address": "BLK 351-357 HOUGANG AVENUE 7",
    "latitude": 1.37234,
    "longitude": 103.899,
    "distance": 0.2525726395966405,
    "total_slots": 249,
    "available_slots": 41
  }
]
```


