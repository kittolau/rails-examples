#不會變的資料可以用常數在Rails啟動時就放到記憶體。
#注意在development mode中不會作用，要在production mode才有快取效果。

class Rating < ActiveRecord::Base
  G  = Rating.find_by_name('G')
  PG = Rating.find_by_name('PG')
  R  = Rating.find_by_name('R')
  #....
end

Rating::G
Rating::PG
Rating::R
