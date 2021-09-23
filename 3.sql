create database Task_3;

create table student (
    student_id varchar(15) primary key,
    full_name varchar(50) not null,
    age int not null check ( age > 10),
    birth_date date not null check ( birth_date > date '2011-01-01'),
    gender char(1) not null check (gender = 'm' or gender = 'f'),
    need_for_dormitory boolean,
    info_about_yourself text
);
create table instructors (
    instructor_id varchar(15) primary key,
    full_name varchar(50) not null,
    speaking_language varchar(40),
    work_experience integer not null check ( work_experience > 0 ),
    able_to_have_remote_lessons boolean not null
);

create table lesson (
    lesson_title varchar(50) not null ,
    teaching_instructor varchar(50),
    foreign key (teaching_instructor) references instructors(full_name),
    study_student varchar(50),
    foreign key(study_student) references student(full_name),
    room_number integer not null check ( room_number > 0 )

);