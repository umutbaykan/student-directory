def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(names)
  i = 0
  while i < names.length
    puts "#{i+1} #{names[i][:name]} (#{names[i][:cohort]} cohort) (hobbies #{names[i][:hobbies]})"
    i += 1
  end
  
  # names.each.with_index(1) do |student, index| 
  #   if student[:name].length < 12
  #     puts "#{index} #{student[:name]} (#{student[:cohort]} cohort)"
  #   end
  # end
end

def print_footer(names)
  puts "Overall, we have #{names.length} great students"
end

def input_students
  puts "Please enter the names of the students, followed by hobbies"
  puts "To finish, just hit return twice"
  ## empty array where students info will be pushed to
  students = []
  # get the name
  name = gets.chomp
  hobbies = gets.chomp
  while name != "" do
    students << {name: name, cohort: :november, hobbies: hobbies}
    puts "Now we have #{students.count} students"
    ## gets another name, until the loop ends
    name = gets.chomp
    hobbies = gets.chomp
  end
  ## returns the array of students
  students
end


students = input_students
print_header
print(students)
print_footer(students)