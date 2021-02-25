class Movie < ActiveRecord::Base
    def self.with_ratings(ratings_list, sort_by)
        # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
        if !ratings_list.empty?
            if sort_by.empty?
                return self.where(rating: ratings_list)
            else
                return self.where(rating: ratings_list).order(sort_by)
            end
        #  movies with those ratings
        # if ratings_list is nil, retrieve ALL movies
        else
            if sort_by.empty?
                return self.all
            else
                return self.all.order(sort_by)
            end
        end
    end
    
    def self.all_ratings
        return ['G','PG','PG-13','R'] 
    end
end
