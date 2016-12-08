@students = [] # an empty array accessible to all methods (global variable)

# INTERACTIVE MENU --------------------------------------------------------------

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end
end

def process(selection)
    case selection
    when "1"
        input_students
    when "2"
        if !students.empty?
            show_students
        else 
            puts "There are currently no students in the system to display."
        end
        # can also use an unless statement: print(students) unless students.empty?
    when "3"
        save_students
    when "4"
        load_students
    when "9"
        exit # this will cause the program to terminate
    else
        puts "I don't know what you mean. Try again!"
    end
end

# WORKING WITH CSV --------------------------------------------------------------

def save_students
    # open the file for writing
    file = File.open("students.csv", "w")
    # iterate over the array of students
    @students.each do |student|
        student_data = [student[:firstname], student[:surname], student[:birthplace], student[:cohort]]
        csv_line = student_data.join(",")
        file.puts csv_line
    end
    file.close
end

def load_students(filename = "students.csv")
    if filename.nil?
        file = File.open("students.csv", "r")
    else
        file = File.open(filename, "r")
    end
    file.readlines.each do |line|
        firstname, lastname, birthplace, cohort = line.chomp.split(',')
        push_to_array(firstname: firstname, surname: lastname, birthplace: birthplace, cohort: cohort.to_sym)
    end
    file.close
end

def try_load_students
    filename = ARGV.first # first argument from the command line
    if filename.nil?
        load_students(filename)
        puts "No file was given on startup so loaded \"students.csv\" by default."
    elsif File.exists?(filename) # if it exists
        load_students(filename)
        puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist
        puts "Sorry, #{filename} doesn't exist."
        exit # quit the programe
    end
end

# USER DATA ENTRY ---------------------------------------------------------------

def user_data_entry
    details = {
        firstname: "--",
        surname: "--",
        birthplace: "--",
        cohort: :unknown
    }
    
    spellcheck = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    puts "Please enter the first name, last name, birthplace and cohort of each student.\n"
            
    puts "Enter first name:"
    name = STDIN.gets.gsub("\n", "")
    if !name.empty? then details[:firstname] = name end
    
    puts "Enter surname:"
    family = STDIN.gets.gsub("\n", "")
    if !family.empty? then details[:surname] = family end
    
    puts "Enter birthplace:"
    place = STDIN.gets.gsub("\n", "")
    if !place.empty? then details[:birthplace] = place end
    
    puts "Enter cohort:"
    month = STDIN.gets.gsub("\n", "")
    if !month.empty? 
        spellcheck.each do |x|
            if month[0..2].downcase == x[0..2].downcase then details[:cohort] = x.downcase.to_sym end
        end
    end
    
    return details
end

def push_to_array(args = {})
    defaults = {
        firstname: "--",
        surname: "--",
        birthplace: "--",
        cohort: :unknown
    }
    args = defaults.merge(args)
    @students << args
end

def prompt(output)
    if output.length < 1
        puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
        enter = STDIN.gets.gsub("\n", "")
        
        if !enter.empty? # if user has not hit enter, repeat user data entry prompt sequence
            details = user_data_entry
        else
            details = Hash.new
        end
    else
        details = user_data_entry
    end
    
    return details
end

def input_students
    # create an empty array
    details = prompt(@students)
    
    # add student hash to the array
    if !details.empty?
        push_to_array(details)
        puts @students.count == 1 ? "Now we have #{@students.count} student." : "Now we have #{@students.count} students."
        puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
        enter = STDIN.gets.gsub("\n", "")
        
        while !enter.empty?
            # continuing adding the student hashes to the array
            details = prompt(@students)
            push_to_array(details)
            puts @students.count == 1 ? "Now we have #{@students.count} student." : "Now we have #{@students.count} students."
            puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
            enter = STDIN.gets.gsub("\n", "")
        end
    end
    
    # return the array of students
    @students
end

# PRINTING THE DATA -------------------------------------------------------------

def show_students
    print_header
    print_students_list
    print_footer
end

def print_header
    puts "\nThe students of Villains Academy"
    puts "-------------"
end

def print_students_list
    @students.each_with_index do |student, index|
        puts "#{index + 1}. #{student[:firstname]} (#{student[:cohort]} cohort)"
    end
end

def print_footer
    puts "Overall, we have #{@students.count} great students.\n"
end

try_load_students

interactive_menu

# CUSTOM PRINTING METHODS -------------------------------------------------------

def print_all(students)
    students.each do |student|
        puts "#{student[:firstname]} #{student[:surname]} | #{student[:birthplace]} | Cohort: #{student[:cohort]}"
    end
end

def print_beginwitha(students)
    puts "Register of students (with names beginning in \"A\"):"
    students.each do |student|
        if student[:firstname][0] == "a" || student[:firstname][0] == "A"
            puts "\t#{student[:firstname]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_lessthan12(students)
    puts "Register of students (with names less than 12 characters):"
    students.each do |student|
        if student[:firstname].length < 12
            puts "\t#{student[:firstname]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_usingwhile(students)
    count = 0
    while count < students.length
        puts "#{students[count][:firstname]} (#{students[count][:cohort]} cohort)"
        count += 1
    end
end

def print_centered(students)
    puts "Here is our nicely formatted graduation attendee poster:".center(70).upcase
    students.each do |student|
        puts "#{student[:firstname]}".center(70, "-")
        puts "(#{student[:cohort]} cohort)".center(70)
    end
end

def existing_cohorts(students)
    cohorts = []
    students.each do |x|
        if cohorts.empty?
            cohorts << x[:cohort]
        elsif cohorts.include? x[:cohort]
            next
        else
            cohorts << x[:cohort]
        end
    end
    return cohorts
end

def print_bycohort(students)
    cohort_list = existing_cohorts(students)
    cohort_list.each do |month|
        puts "\nHere are the students from the #{month} cohort:"
        students.each do |x| 
            if x[:cohort] == month
                puts "#{x[:firstname]} #{x[:surname]}"
            else
                next
            end
        end
    end
end

# EXAMPLE CALLS FOR CUSTOM PRINTING METHODS -------------------------------------

# nothing happens until we call the methods
# uncomment out the methods to test
# commented here to make output more readable for current exercise

# students = input_students
# print_header
# print(students)
# print_beginwitha(students)
# print_lessthan12(students)
# print_usingwhile(students)
# print_centered(students)
# print_all(students)
# print_bycohort(students)
# print_footer(students)