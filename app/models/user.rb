class User < ApplicationRecord
  enum role: { male: 0, female: 1, none: 2 }
end
