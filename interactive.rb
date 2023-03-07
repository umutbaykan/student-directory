@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  # students = []
  # get the first name
  name = STDIN.gets.chomp
  while name != ""
    if name != ""
      # add the student hash to the array
      @students << {name: name, cohort: :november}
      puts "Now we have #{@students.count} students"
      # get another name from the user
      name = STDIN.gets.chomp
    end
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    csv_line = "#{student[:name]}, #{student[:cohort]}"
    file.puts csv_line
  end
  file.close
end

def load_students(filename="students.csv")
  file = File.open(filename, "r")
  ### resets the array so we dont duplicate student data if we load more than once
  @students = []
  file.readlines.each do |student|
    name, cohort = student.chomp.split(", ")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end


def try_load_students
  filename = ARGV.first
  filename = 'students.csv' if filename.nil?
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Filename #{filename} does not exist."
    puts "Would you like to continue anyway? Y/N"
    input = STDIN.gets.chomp
    while input != "Y" || input != "N"
      if input == "Y"
        return
      elsif input == "N"
        exit
      else
        input = STDIN.gets.chomp
      end
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
  puts "3. Save students into a CSV file"
  puts "4. Load the list of students from CSV file"
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
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "This is not amongst menu items, please try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
