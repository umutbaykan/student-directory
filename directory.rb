# Arraying the students
# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(names)
  names.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)"}
end

def print_footer(names)
  puts "Overall, we have #{names.length} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  ## empty array where students info will be pushed to
  students = []
  # get the name
  name = gets.chomp
  while name != "" do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    ## gets another name, until the loop ends
    name = gets.chomp
  end
  ## returns the array of students
  students
end


students = input_students
print_header
print(students)
print_footer(students)