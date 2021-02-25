class Movie < ActiveRecord::Base
    def self.with_ratings(ratings_list)
        # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
        if !ratings_list.empty?
            ratings_list.each do |rating|
               where("rating = '#{rating}'") 
            end
        #  movies with those ratings
        # if ratings_list is nil, retrieve ALL movies
        else
            return self.all
        end
    end
    
end
