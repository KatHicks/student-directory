def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    # create an empty array
    students = []
    # get the first name
    name = gets.chomp
    # while the name is not empty, repeat this code
    while !name.empty? do
        # add the student hash to the array
        students << {name: name, cohort: :november}
        puts "Now we have #{students.count} students"
        # get another name from the user
        name = gets.chomp
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
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
end

def print_beginwitha(students)
    puts "Register of students (with names beginning in \"A\"):"
    students.each do |student|
        if student[:name][0] == "a" || student[:name][0] == "A"
            puts "\t#{student[:name]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_lessthan12(students)
    puts "Register of students (with names less than 12 characters):"
    students.each do |student|
        if student[:name].length < 12
            puts "\t#{student[:name]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_usingwhile(students)
    count = 0
    while count < students.length
        puts "#{students[count][:name]} (#{students[count][:cohort]} cohort)"
        count += 1
    end
end

def print_footer(students)
    puts "Overall, we have #{students.count} great students"
end

# nothing happens until we call the methods
students = input_students
print_header
print(students)
puts
print_beginwitha(students)
puts
print_lessthan12(students)
puts
print_usingwhile(students)
puts
print_footer(students)