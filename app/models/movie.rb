class Movie < ActiveRecord::Base
    def self.with_ratings(ratings_list, sort_by)
        # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
        if !ratings_list.empty?
            return self.where(rating: ratings_list)
        #  movies with those ratings
        # if ratings_list is nil, retrieve ALL movies
        else
            return self.all
        end
    end
    
    def self.all_ratings
        return ['G','PG','PG-13','R'] 
    end
end
