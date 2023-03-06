@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  # students = []
  # get the first name
  name = gets.chomp
  while name != ""
    if name != ""
      # add the student hash to the array
      @students << {name: name, cohort: :november}
      puts "Now we have #{@students.count} students"
      # get another name from the user
      name = gets.chomp
    end
  end
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print_students
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students
  print_footer
end

def process(selection)
  case selection
   when "1"
      input_students
    when "2" 
      show_students
    when "9"
      exit
    else
      puts "This is not amongst menu items, please try again"
  end
end


def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end


interactive_menu
