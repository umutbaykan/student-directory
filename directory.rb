def print_header
  puts "The students of Villains Academy"
  puts "".center(30, "-")
end

def print(names)
  return puts "There are no students currently enrolled." if names.length == 0
  ### returns all members of the array sorted by cohort
  # names.sort_by! {|element| element[:cohort]}.reverse
  
  ### returns the students from a specific cohort only###
  # puts "Please specify which cohort you would like to print"
  # cohort = gets.chomp.downcase
  # names.each { |name| puts "#{name[:name]} - (#{name[:cohort]} cohort) - Hobbies: #{name[:hobbies]}" if name[:cohort] == cohort.to_sym }

  ### This section utilizes a while loop to print through names
  # i = 0
  # while i < names.length
  #   puts "#{i+1} #{names[i][:name]} (#{names[i][:cohort]} cohort) (hobbies #{names[i][:hobbies]})"
  #   i += 1
  # end
  
  ## This section prints them based on the sequence they were input 
  ## as well as requires the student name to be >12 to print
  names.each.with_index(1) do |student, index| 
    if student[:name].length < 12
      puts "#{index} #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  return "" if names.length == 0
  names.length > 1 ? s = "s" : s = ""
  puts "Overall, we have #{names.length} great student#{s}"
end

def input_students()
  puts "Please enter the names of the students, followed by cohort, and hobbies"
  puts "To finish, just hit return twice"
  ## empty array where students info will be pushed to
  students = []
  cohorts = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
  # get the name
  name = gets.gsub("\n","")
  while name != "" do
    cohort = gets.chomp
    while cohorts.include?(cohort.downcase) == false
      puts "You have made a typo, please type again giving the full name of the month"
      cohort = gets.chomp
    end
    hobbies = gets.chomp
    students << {name: name, cohort: cohort.to_sym, hobbies: hobbies}
    if students.length > 1
      puts "Now we have #{students.count} students"
    else
      puts "Now we have #{students.count} student"
    end
    ## gets another name, until the loop ends
    name = gets.chomp
    break if name == ""
  end
  ## returns the array of students
  students
end

students = input_students
print_header
print(students)
print_footer(students)