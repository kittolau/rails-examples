If:
  if "sam" == "cat"
    puts "sam equals cat"
  elsif "matt" == "matt"
    puts "matt equals matt"
  else
    puts "whatever"
  end

Loop:
  while 3 > 15
    puts "This is the end"
  end

  ["fat", "bat", "rat"].each do |word|
    puts word + "-land"
  end

  h = {}
  a.each_with_index do |number, index|
    h[number] = b[index]
  end


String:
  "i am not shouting".upcase()
  puts "unicorn".reverse()
  "sUp DuDe".swapcase()
  "This is a sentence, kinda".split()
  "Hello #{name}"

  Use a one-liner to find the longest word in the array: arr = %w{what is the longest word in this arrrrrray}
  arr.inject { |longest_word, word| word.length > longest_word.length ? word : longest_word}

Array:
  ["uno", "dos", "tres"].length()
  [:a, :b, :c].include?(:a)
  ["Too", "Weird", "To", "Live,", "Too", "Rare", "To", "Die"].join(" ")
  ["where's", "wallace", "at"].join("***")

  [2, 4, 6, 8].map { |number| number ** 2 }

  a.zip(b)
  a.zip(b).m­ap{ |a| a[0].­to_s+a[1]}

  c.flatten  Convert c = [[1, "a"], [2, "b"], [3, "c"]] to [1, "a", 2, "b", 3, "c"]

  Array.new(3) {Array.new(3) {""}} => [["", "", ""], ["", "", ""], ["", "", ""]]

  (0..2).cycle(3) { |x| puts x }

  [5, 6, 7, 8].inject{ |l,r| l+r}  inject(initial value)
  a.inject([]) {|memo, (word, t)| t.times {memo << word}; memo}

  a = [[:a, :b, :c]]
  (x, y), z = [:a, :b, :c]
  #=> x == :a, y == nil, z == :b
  (x, y) = [:a, :b, :c]
  #=> x == :a, y == :b

  a[0..2]

  a.delete_if {|x| x <= 2 }
  a.keep_if {|x| x > 2}

  a.select {|x| x > 2}

  #ome_objects.each { |obj| obj.foo }
  #is the same as
  some_objects.each(&:foo)


  #a = [1, 2, 3, 4] Add the string "nice" to the beginning of the array.
  a.unshift("nice")

  #{false=>[1, 3, 5, 7, 9, 11, 13, 15, 17, 19], true=>[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]}
  (1..20).group_by { |x| x.even? }

  Array.new(5).map{ rand(0..10) }

  #a = [1, 2, 3, 4] Attempt to retrieve an element at the 5th position and if no element is found, return "cats".
  a.fetch(4, "cats")

  #Convert a = [[1, 2], [3, 4]] and b = [[5,6]] to [[1, 2], [3, 4], [5, 6]]
  a + b

  a.flat_map {|i| i }

Hash:
  warty_newt = { "type" => "Amphibian", "diet" => "Carnivore", "life_span" => "25 years" }
  warty_newt.fetch("type")

  snowy_owl = { "type"=>"Bird", "diet"=>"Carnivore", "life_span"=>"10 years" }
  snowy_owl.keys()

  snowy_owl = { "type"=>"Bird", "diet"=>"Carnivore", "life_span"=>"10 years" }
  snowy_owl.values()

  Hash[1,2,3,4]

  h1 = {surfing: "fun"}
  h2 = {rock_climbing: "scary"}
  Use h1 and h2 to construct the following hash: {:surfing => "fun", :rock_climbing => "scary"}
  h1.merge(h2)

  boring_hash.empty?

Class:
  class Fish
    def self.general_overview()
    return("Fish are animals that live in the sea")
    end
    def initialize(name)
    @name = name
    end
  end

  nemo = Fish.new
  puts nemo.general_overview() # doesn't work

Function:
  def square_of_number(number)
    return(number * number)
  end
