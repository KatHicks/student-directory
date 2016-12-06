def prompt
    # setting default values
    details = {
        firstname: "--",
        surname: "--",
        birthplace: "--",
        cohort: :unknown
    }
    
    spellcheck = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    puts "Please enter the first name, last name, birthplace and cohort of each student.\n"
    puts "Hit enter at the end to finish or \"-\" to enter another student.\n"
    
    puts "Enter first name:"
    name = gets.chomp
    if !name.empty? then details[:firstname] = name end
    
    puts "Enter surname:"
    family = gets.chomp
    if !family.empty? then details[:surname] = family end
    
    puts "Enter birthplace:"
    place = gets.chomp
    if !place.empty? then details[:birthplace] = place end
    
    puts "Enter cohort:"
    month = gets.chomp
    if !month.empty? 
        spellcheck.each do |x|
            if month[0..2].downcase == x[0..2].downcase then details[:cohort] = x.downcase.to_sym end
        end
    end
    
    return details
end

def input_students
    # create an empty array
    students = []
    
    # add student hash to the array
    details = prompt
    students << details
    puts students.count == 1 ? "Now we have #{students.count} student." : "Now we have #{students.count} students."
    enter = gets.chomp
    
    while !enter.empty?
        # continuing adding the student hashes to the array
        details = prompt
        students << details
        puts students.count == 1 ? "Now we have #{students.count} student." : "Now we have #{students.count} students."
        enter = gets.chomp
    end
    
    # return the array of students
    students
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print(students)
    students.each_with_index do |student, index|
        puts "#{index + 1}. #{student[:firstname]} (#{student[:cohort]} cohort)"
    end
end

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

def print_footer(students)
    puts "Overall, we have #{students.count} great students"
end

# nothing happens until we call the methods
students = input_students
print_header
#print(students)
#puts
#print_beginwitha(students)
#puts
#print_lessthan12(students)
#puts
#print_usingwhile(students)
#puts
#print_centered(students)
#puts
#print_all(students)
#puts
print_bycohort(students)
puts
print_footer(students)