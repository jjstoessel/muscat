module Statistic
  class Person
    def self.libraries(people)
      res = ActiveSupport::OrderedHash.new
      people.each do |person|
        s = Sunspot.search(Source) do
          with(:composer_order, person.full_name)
          facet(:lib_siglum_order)
        end
        line = ActiveSupport::OrderedHash.new
        s.facet(:lib_siglum_order).rows[0..4].each do |f|
          if f.value.blank?
            line['Print'] = f.count
          else
            line[f.value] = f.count
          end
          res[person] = line
        end
        return res
      end
    end
  end
end
