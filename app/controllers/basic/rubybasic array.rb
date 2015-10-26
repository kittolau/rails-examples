class ActiveRecordExampleController < ActionController::Base
  def index
    #array basic op
      arr = [:cool, "freezing", -10, Object.new]
      arr = []
      arr[2]
      arr[-1]
      (1..100).to_a

    #include?
      arr.include? "value"

    #any and all
      arr.any?{ |obj| block } # → true or false
      arr.all?{ |obj| block } # → true or false

    #map
      a = [ "a", "b", "c", "d" ]
      a.map { |x| x + "!" }        #=> ["a!", "b!", "c!", "d!"]
      a.map.with_index{ |x, i| x * i } #=> ["", "b", "cc", "ddd"]
      a                                #=> ["a", "b", "c", "d"]

      h = {a: 1,b:2}
      h.map{ |hashObj| hashObj } # =>  [[:a,1],[:b,2]]
      h.map{ |key, values| key } # =>  [:a,:b]
    #each
      a = [ "a", "b", "c" ]
      a.each {|x|  x+"," } # => [ "a,", "b,", "c," ]
      a.each_with_index {|x,i| x+i } # => [ "a1", "b2", "c3" ]
    #clear
      a = [ "a", "b", "c", "d", "e" ]
      a.clear    #=> [ ]

    #join
      [ "a", "b", "c" ].join        #=> "abc"
      [ "a", "b", "c" ].join("-")   #=> "a-b-c"

    #concat array
      [ "a", "b" ].concat( ["c", "d"] ) #=> [ "a", "b", "c", "d" ]
      a = [ 1, 2, 3 ]
      a.concat( [ 4, 5 ] )
      a                                 #=> [ 1, 2, 3, 4, 5 ]

    #max_by and min_by
      a = %w(albatross dog horse)
      a.min_by {|x| x.length }   #=> "dog"

      a = %w(albatross dog horse)
      a.max_by {|x| x.length }   #=> "albatross"

    #find_all and reject
      (1..10).find_all {|i|  i % 3 == 0 }   #=> [3, 6, 9]

      (1..10).reject {|i|  i % 3 == 0 }   #=> [1, 2, 4, 5, 7, 8, 10]

    #find
      #Returns the first for which block is not false
      (1..10).find  {|i| i % 5 == 0 and i % 7 == 0 }   #=> nil
      (1..100).find {|i| i % 5 == 0 and i % 7 == 0 }   #=> 35

    #max and min
      a = %w(albatross dog horse)
      a.max                                  #=> "horse"
      a.max {|a,b| a.length <=> b.length }   #=> "albatross"

      a = %w(albatross dog horse)
      a.min                                  #=> "albatross"
      a.min {|a,b| a.length <=> b.length }   #=> "dog"

    #flat_map
      [[1,2],[3,4]].flat_map {|i| i }   #=> [1, 2, 3, 4]

    #reduce
      # Sum some numbers
      (5..10).reduce(:+)                            #=> 45
      # Same using a block and inject
      (5..10).reduce {|sum, n| sum + n }            #=> 45
      # Multiply some numbers
      (5..10).reduce(1, :*)                         #=> 151200
      # Same using a block
      (5..10).reduce(1) {|product, n| product * n } #=> 151200
      # find the longest word
      longest = %w{ cat sheep bear }.inject do |memo,word|
         memo.length > word.length ? memo : word
      end
      longest                                       #=> "sheep"

    #count
      ary = [1, 2, 4, 2]
      ary.count                  #=> 4
      ary.count(2)               #=> 2
      ary.count { |x| x%2 == 0 } #=> 3

    #first and last
      a = [ "q", "r", "s", "t" ]
      a.first     #=> "q"
      a.first(2)  #=> ["q", "r"]

      a = [ "w", "x", "y", "z" ]
      a.last     #=> "z"
      a.last(2)  #=> ["y", "z"]

    #zip
      a = [ 4, 5, 6 ]
      b = [ 7, 8, 9 ]
      [1, 2, 3].zip(a, b)   #=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
      [1, 2].zip(a, b)      #=> [[1, 4, 7], [2, 5, 8]]
      a.zip([1, 2], [8])    #=> [[4, 1, 8], [5, 2, nil], [6, nil, nil]]

    #uniq
      a = [ "a", "a", "b", "b", "c" ]
      a.uniq   # => ["a", "b", "c"]

      b = [["student","sam"], ["student","george"], ["teacher","matz"]]
      b.uniq { |s| s.first } # => [["student", "sam"], ["teacher", "matz"]]

    #take_while
      a = [1, 2, 3, 4, 5, 0]
      a.take_while { |i| i < 3 }  #=> [1, 2]

    #product
      [1,2,3].product([4,5])     #=> [[1,4],[1,5],[2,4],[2,5],[3,4],[3,5]]
      [1,2].product([1,2])       #=> [[1,1],[1,2],[2,1],[2,2]]
      [1,2].product([3,4],[5,6]) #=> [[1,3,5],[1,3,6],[1,4,5],[1,4,6],
                                 #     [2,3,5],[2,3,6],[2,4,5],[2,4,6]]
      [1,2].product()            #=> [[1],[2]]
      [1,2].product([])          #=> []

    #push
      a = [ "a", "b", "c" ]
      a.push("d", "e", "f")
              #=> ["a", "b", "c", "d", "e", "f"]
      [1, 2, 3,].push(4).push(5)
              #=> [1, 2, 3, 4, 5]

    #sort
      a = [ "d", "a", "e", "c", "b" ]
      a.sort                    #=> ["a", "b", "c", "d", "e"]
      a.sort { |x,y| y <=> x }  #=> ["e", "d", "c", "b", "a"]

    #sort_by
      %w{ apple pear fig }.sort_by {|word| word.length}
              #=> ["fig", "pear", "apple"]

      #sort by multiple values
      a.sort_by {|x| [x.game_date, x.team] }

    #flatten
      s = [ 1, 2, 3 ]           #=> [1, 2, 3]
      t = [ 4, 5, 6, [7, 8] ]   #=> [4, 5, 6, [7, 8]]
      a = [ s, t, 9, 10 ]       #=> [[1, 2, 3], [4, 5, 6, [7, 8]], 9, 10]
      a.flatten                 #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      a = [ 1, 2, [3, [4, 5] ] ]
      a.flatten(1)              #=> [1, 2, 3, [4, 5]]

    #group by
    arr.group_by(&:key).each do |key, values|
      p "#{key} -> #{values.map(&:class).join(', ')}"
    end

  end
end
