module Top
    extend ActiveSupport::Concern

    def top(n)
        sorted_by_rating_in_desc_order = self.all.sort_by{ |b| -(b.avg_rating || 0) }[0..n-1]
    end
end
