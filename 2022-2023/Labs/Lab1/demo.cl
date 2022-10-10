(*
    Links:
        Similar with case: https://docs.oracle.com/en/java/javase/17/language/pattern-matching-switch-expressions-and-statements.html
        Online debugger: https://dijkstra.eecs.umich.edu/eecs483/cool-debugger/
        Adrian Stratulat: https://www.high-level.wiki/
*)

class Person {
    name : String;
    age : Int;
    io : IO <- new IO;

    init(n : String, a : Int) : SELF_TYPE {
        {
            name <- n;
            age <- a;
            self;
        }
    };

    print() : IO {
        io.out_string("Person(")
            .out_string(name)
            .out_string(", ")
            .out_int(age)
            .out_string(")\n")
    };
};

class Student inherits Person {
    grade: Int;

    setGrade(g : Int) : SELF_TYPE {
        {
            if g < 0 then
                grade <- 0
            else
                if not g <= 10 then
                    grade <- 10
                else
                    grade <- g
                fi
            fi;
            self;
        }
    };

    print() : IO {
        io.out_string("Student(")
            .out_string(name)
            .out_string(", ")
            .out_int(age)
            .out_string(", ")
            .out_int(grade)
            .out_string(")\n")
        -- self@Person.print()
    };
};

class Main {
    main() : Object {
        let person0 : Person,
            person1 : Person <- new Person,
            person2 : Person <- new Person.init("A", 50),
            person3 : Person <- new Student.init("B", 18).setGrade(10),
            person4 : Student <- new Student.init("C", 19) in {
            -- person0.print();
            person1.print();
            person2.print();
            person3.print();
            -- person3.setGrade(10).print();
            person4.print();
            -- person4.setGrade(10).print();
            person4@Person.print();
        }
    };
};
