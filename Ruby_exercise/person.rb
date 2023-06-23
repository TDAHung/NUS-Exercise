class Person
  @@count = 0
  def initialize (name, age)
    @@count += 1
    @name = name
    @age = age
  end

  def name=(name)
    @name = name
  end

  def name
    @name
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end

  def introduce
    puts "My name is #{@name}. I'm #{@age} years old"
  end

  def self.total_count
    puts "Total number of people is #{@@count}"
  end

  def instance_error_catch
    begin
      puts self.total_count
      raise NoMethodError
      rescue Exception => error
        puts error.inspect
    end
  end
end

# 7. Dùng hàm 'times' tạo 1 mảng 'people' gồm 20 person với name là 'Person 1' cho đến 'Person 20', age của mỗi Person random từ 10 -> 90
people = []
20.times do |index|
  name = "Person #{index + 1}"
  age = rand(10..90)
  people << Person.new(name, age)
end

# 8. Với mảng 'people' lọc ra những Person có tuổi nhỏ hơn 18
puts "8. Với mảng 'people' lọc ra những Person có tuổi nhỏ hơn 18"
new_people = people.select{|person| person.age.to_i < 18}
new_people.each{|person| person.introduce}
puts puts

# 9. Với mảng 'people' xóa những Person có tuổi nhỏ hơn 18
puts "# 9. Với mảng 'people' xóa những Person có tuổi nhỏ hơn 18"
new_people = people.reject{|person| person.age.to_i < 18}
new_people.each{|person| person.introduce}
puts puts

# 10. Sort mảng 'people' theo tuổi tăng dần.
puts "# 10. Sort mảng 'people' theo tuổi tăng dần."
people = people.sort_by { |person| person.age }
people.each{|person| person.introduce}
puts puts

# 11. Sort mảng 'people' theo tuổi giảm dần.
puts "# 11. Sort mảng 'people' theo tuổi giảm dần."
people = people.sort_by { |person| -person.age }
people.each{|person| person.introduce}
puts puts

#12 Delete 1 phần tử ở vị trí xác định trong mảng 'people'
puts "# 12 .Delete 1 phần tử ở vị trí xác định trong mảng people"
people.each{|person| person.introduce}
print "Input index: "
index = gets
print "Delete person "
people[index.to_i].introduce
people.delete_at(index.to_i)
puts "After delete"
people.each{|person| person.introduce}
puts puts

#13 Xem phần module enumerable của Ruby: https://ruby-doc.org/core-2.5.1/Enumerable.html (Array và Hash trong Ruby có include module này) để tìm ra Person lớn tuổi nhất, Person nhỏ tuổi nhất.
puts "# 13. Tìm ra Person lớn tuổi nhất, Person nhỏ tuổi nhất."
max_person = people.max_by{|person| person.age}
max_person.introduce
puts "Person nhỏ tuổi nhất"
min_person = people.min_by{|person| person.age}
min_person.introduce
puts puts

#14 Dùng CÁC vòng lặp trong Ruby và CÁC hàm (khả thi) của Array để tăng tuổi của từng Person trong mảng 'people' lên 1.
puts "# 14. Dùng CÁC vòng lặp trong Ruby và CÁC hàm (khả thi) của Array để tăng tuổi của từng Person trong mảng 'people' lên 1."
people.each{|person| person.introduce}
puts "Sau khi tăng 1"
people.each {|person| person.age += 1}
people.each{|person| person.introduce}
puts "Sau khi tăng 1"
people.map {|person| person.age += 1}
people.each{|person| person.introduce}
puts puts

#15 Không dùng vòng lặp (dùng CÁC hàm của Array) lấy ra tất cả các 'age' của các Person trong mảng 'person'
puts "# 15 Không dùng vòng lặp (dùng CÁC hàm của Array) lấy ra tất cả các 'age' của các Person trong mảng 'person'"
ages = people.map(&:age)
ages.each{|age| puts age}
puts puts

#16 Tạo 1 mảng 'people_2' tương tự câu 7, nối mảng 'people_2' vào 'people'
puts "# 16 Tạo 1 mảng 'people_2' tương tự câu 7, nối mảng 'people_2' vào 'people'"
people_2 = []
20.times do |index|
  name = "Person #{index + 1}"
  age = rand(10..90)
  people_2 << Person.new(name, age)
end
people_2 = people_2 + people
people_2.each{|person| person.introduce}
puts puts

# 17 Viết 1 instance method bất kì, raise Exception (với message bất kì) trong method đó, sau đó catch exception và in ra message của Exception đó.
puts "# 17 Viết 1 instance method bất kì, raise Exception (với message bất kì) trong method đó, sau đó catch exception và in ra message của Exception đó."
people_3 = Person.new("Cau 17",17)
people_3.instance_error_catch
