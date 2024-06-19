	CREATE DATABASE IF NOT EXISTS `dental_clinic`;
	USE `dental_clinic`;

	-- Create table Clinics
	CREATE TABLE Clinics (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  name VARCHAR(255) NOT NULL,
	  address VARCHAR(255) NOT NULL,
	  phone VARCHAR(255) NOT NULL,
	  introductionHTML TEXT,
	  introductionMarkdown TEXT,
	  description TEXT,
	  image VARCHAR(255),
	  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  deletedAt DATETIME
	);

	-- Create table Doctors
	CREATE TABLE Doctors (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  name VARCHAR(255) NOT NULL,
	  email VARCHAR(255) UNIQUE NOT NULL,
	  password VARCHAR(255) NOT NULL,
	  phone VARCHAR(255) NOT NULL,
	  avatar VARCHAR(255),
	  gender VARCHAR(255) DEFAULT 'male',
	  description TEXT,
	  clinicId INT,
	  isActive TINYINT DEFAULT 1,
	  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  deletedAt DATETIME,
	  FOREIGN KEY (clinicId) REFERENCES Clinics(id) ON DELETE CASCADE
	);

	-- Create table Specializations
	CREATE TABLE Specializations (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  name VARCHAR(255) NOT NULL,
	  description TEXT,
	  image VARCHAR(255),
	  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  deletedAt DATETIME
	);

	-- Create table DoctorSpecializations
	CREATE TABLE DoctorSpecializations (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  doctorId INT,
	  specializationId INT,
	  FOREIGN KEY (doctorId) REFERENCES Doctors(id) ON DELETE CASCADE,
	  FOREIGN KEY (specializationId) REFERENCES Specializations(id) ON DELETE CASCADE
	);

	-- Create table Schedules
	CREATE TABLE Schedules (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  doctorId INT,
	  date DATE NOT NULL,
	  startTime TIME NOT NULL,
	  endTime TIME NOT NULL,
	  maxBooking INT NOT NULL DEFAULT 1,
	  sumBooking INT NOT NULL DEFAULT 0,
	  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  deletedAt DATETIME,
	  FOREIGN KEY (doctorId) REFERENCES Doctors(id) ON DELETE CASCADE
	);

	-- Create table Patients
	CREATE TABLE Patients (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  name VARCHAR(255) NOT NULL,
	  email VARCHAR(255) UNIQUE NOT NULL,
	  phone VARCHAR(255) NOT NULL,
	  address TEXT,
	  gender VARCHAR(255) DEFAULT 'male',
	  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  deletedAt DATETIME
	);

	-- Create table Appointments
	CREATE TABLE Appointments (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  patientId INT,
	  scheduleId INT,
	  status ENUM('PENDING', 'CONFIRMED', 'CANCELED') DEFAULT 'PENDING',
	  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  deletedAt DATETIME,
	  FOREIGN KEY (patientId) REFERENCES Patients(id) ON DELETE CASCADE,
	  FOREIGN KEY (scheduleId) REFERENCES Schedules(id) ON DELETE CASCADE
	);

	-- Create table Users
	CREATE TABLE Users (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  username VARCHAR(255) UNIQUE NOT NULL,
	  password VARCHAR(255) NOT NULL,
	  role ENUM('GUEST', 'CUSTOMER', 'DOCTOR', 'CLINIC_OWNER', 'SYSTEM_ADMIN') NOT NULL,
	  patientId INT,
	  doctorId INT,
	  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
	  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  deletedAt DATETIME,
	  FOREIGN KEY (patientId) REFERENCES Patients(id) ON DELETE SET NULL,
	  FOREIGN KEY (doctorId) REFERENCES Doctors(id) ON DELETE SET NULL
	);
    
    
    -- INSERT DATA FOR CLINICS
INSERT INTO Clinics (name, address, phone, introductionHTML, introductionMarkdown, description, image) VALUES
('Dental Care Center', '123 Main Street, Cityville', '123-456-7890', '<p>Welcome to Dental Care Center!</p>', 'Welcome to Dental Care Center!', 'We offer a wide range of dental services.', 'dental-clinic.jpg'),
('Smile Bright Clinic', '456 Oak Avenue, Townville', '987-654-3210', '<p>Smile Bright Clinic for all your dental needs.</p>', 'Smile Bright Clinic for all your dental needs.', 'We provide excellent dental care in a friendly environment.', 'smile-clinic.jpg'),
('Family Dental', '789 Elm Street, Villageville', '555-123-4567', '<p>Family Dental - Your trusted dental provider.</p>', 'Family Dental - Your trusted dental provider.', 'We cater to the whole family with personalized dental care.', 'family-dental.jpg'),
('Advanced Dental', '1011 Pine Street, Cityville', '111-222-3333', '<p>Advanced Dental - State-of-the-art dental care.</p>', 'Advanced Dental - State-of-the-art dental care.', 'We use the latest technology and techniques to provide exceptional dental care.', 'advanced-dental.jpg'),
('Dental Health Center', '1213 Maple Street, Townville', '444-555-6666', '<p>Dental Health Center - Committed to your oral health.</p>', 'Dental Health Center - Committed to your oral health.', 'We offer a comprehensive range of dental services to maintain your oral health.', 'dental-health-center.jpg'),
('Premier Dental', '1415 Birch Street, Villageville', '777-888-9999', '<p>Premier Dental - Your premier dental destination.</p>', 'Premier Dental - Your premier dental destination.', 'We are dedicated to providing the highest quality dental care.', 'premier-dental.jpg'),
('Sunshine Dental', '1617 Willow Street, Cityville', '222-333-4444', '<p>Sunshine Dental - Brightening your smile.</p>', 'Sunshine Dental - Brightening your smile.', 'We create a positive and relaxing experience for our patients.', 'sunshine-dental.jpg'),
('Dental Wellness Center', '1819 Oak Street, Townville', '555-666-7777', '<p>Dental Wellness Center - Promoting overall wellness.</p>', 'Dental Wellness Center - Promoting overall wellness.', 'We believe in holistic oral health care.', 'dental-wellness-center.jpg'),
('Gentle Dental', '2021 Elm Street, Villageville', '888-999-0000', '<p>Gentle Dental - Providing gentle and caring dental care.</p>', 'Gentle Dental - Providing gentle and caring dental care.', 'We understand that some patients may have dental anxiety, and we strive to make your experience as comfortable as possible.', 'gentle-dental.jpg'),
('Modern Dental', '2223 Pine Street, Cityville', '111-222-3333', '<p>Modern Dental - Modern techniques, exceptional care.</p>', 'Modern Dental - Modern techniques, exceptional care.', 'We are committed to providing the most advanced dental care.', 'modern-dental.jpg'),
('Dental Solutions', '2425 Maple Street, Townville', '444-555-6666', '<p>Dental Solutions - Finding the right solution for you.</p>', 'Dental Solutions - Finding the right solution for you.', 'We offer a wide range of solutions to address your individual dental needs.', 'dental-solutions.jpg'),
('Elite Dental', '2627 Birch Street, Villageville', '777-888-9999', '<p>Elite Dental - Excellence in dental care.</p>', 'Elite Dental - Excellence in dental care.', 'We provide elite dental services to meet the highest standards.', 'elite-dental.jpg'),
('Dental Care Plus', '2829 Willow Street, Cityville', '222-333-4444', '<p>Dental Care Plus - Your complete dental solution.</p>', 'Dental Care Plus - Your complete dental solution.', 'We offer a comprehensive range of dental services to cater to all your needs.', 'dental-care-plus.jpg'),
('Oral Health Specialists', '3031 Oak Street, Townville', '555-666-7777', '<p>Oral Health Specialists - Experts in oral health.</p>', 'Oral Health Specialists - Experts in oral health.', 'We specialize in a variety of oral health services.', 'oral-health-specialists.jpg'),
('Healthy Smiles Dental', '3233 Elm Street, Villageville', '888-999-0000', '<p>Healthy Smiles Dental - Helping you achieve a healthy smile.</p>', 'Healthy Smiles Dental - Helping you achieve a healthy smile.', 'We are passionate about helping you achieve a beautiful and healthy smile.', 'healthy-smiles-dental.jpg'),
('Dental Excellence', '3435 Pine Street, Cityville', '111-222-3333', '<p>Dental Excellence - Striving for excellence in dental care.</p>', 'Dental Excellence - Striving for excellence in dental care.', 'We are dedicated to providing the highest quality dental care.', 'dental-excellence.jpg'),
('Smile Care Clinic', '3637 Maple Street, Townville', '444-555-6666', '<p>Smile Care Clinic - Taking care of your smile.</p>', 'Smile Care Clinic - Taking care of your smile.', 'We offer a variety of dental services to help you maintain a beautiful smile.', 'smile-care-clinic.jpg'),
('Dental Innovations', '3839 Birch Street, Villageville', '777-888-9999', '<p>Dental Innovations - Bringing innovation to dental care.</p>', 'Dental Innovations - Bringing innovation to dental care.', 'We use the latest technology and techniques to provide innovative dental solutions.', 'dental-innovations.jpg');

-- INSERT DATA FOR DOCTORS
INSERT INTO Doctors (name, email, password, phone, avatar, gender, description, clinicId, isActive) VALUES
('Dr. John Smith', 'john.smith@dentalcare.com', '$2a$10$d7t4R/2jM628wGqV.Z.ZveU0O4o3.K1F/5y/sGq/cI0w4hR4V5C', '555-123-4567', 'dr-john-smith.jpg', 'male', 'General Dentist', 1, 1),
('Dr. Emily Jones', 'emily.jones@smilebright.com', '$2a$10$k6h2Q3/p.4Q8uKz7qT.0buB5Q.d.b.o1b/0gM7Z/5U6wV.e4Z0', '987-654-3210', 'dr-emily-jones.jpg', 'female', 'Cosmetic Dentist', 2, 1),
('Dr. David Lee', 'david.lee@familydental.com', '$2a$10$w.K92g8R.b/oH91q7Y.1Su4j.t/L/t6t/b/9M/8T.k4wV.c69', '555-123-4567', 'dr-david-lee.jpg', 'male', 'Pediatric Dentist', 3, 1),
('Dr. Sarah Kim', 'sarah.kim@advanceddental.com', '$2a$10$y.H7/5B/h/oP.Q8b.Z.z.6b/l.K/j.9.0.2/8B/8V.m.s6.T6', '111-222-3333', 'dr-sarah-kim.jpg', 'female', 'Endodontist', 4, 1),
('Dr. Michael Brown', 'michael.brown@dentalhealthcenter.com', '$2a$10$G.59.1/a.Q/oK.3g.K.u.f5Q.m.Q.R.0.3/h.V.r.W.o.m.06', '444-555-6666', 'dr-michael-brown.jpg', 'male', 'Periodontist', 5, 1),
('Dr. Jessica Wilson', 'jessica.wilson@premierdental.com', '$2a$10$t/R/9.o/d/b.l.Z.9/b/t.m.4/q.9.9.q.0/a/u.G.S.0.k', '777-888-9999', 'dr-jessica-wilson.jpg', 'female', 'Orthodontist', 6, 1),
('Dr. Christopher Garcia', 'christopher.garcia@sunshinedental.com', '$2a$10$K.0.4/q/5/b/5.w/o.a.o.Q/0.B.5/g/9.r/r.d.a.8.M', '222-333-4444', 'dr-christopher-garcia.jpg', 'male', 'Prosthodontist', 7, 1),
('Dr. Ashley Rodriguez', 'ashley.rodriguez@dentalwellnesscenter.com', '$2a$10$K.4/s/h.T.T/1.s/a.o.8.a/4.d/o.m.2/p.h.d.b.e', '555-666-7777', 'dr-ashley-rodriguez.jpg', 'female', 'Oral Surgeon', 8, 1),
('Dr. Brandon Martinez', 'brandon.martinez@gentledental.com', '$2a$10$C.9/2.6/7/a.P.Z/t.p/2.Z.U/c.T/0.k/0.v.9/2.x.Z.m', '888-999-0000', 'dr-brandon-martinez.jpg', 'male', 'General Dentist', 9, 1),
('Dr. Jennifer Davis', 'jennifer.davis@moderndental.com', '$2a$10$9.3/r.W.e/a.W.4/5.p/4.M.o/5.K/b/b.L.v.t/9.L.Q', '111-222-3333', 'dr-jennifer-davis.jpg', 'female', 'Cosmetic Dentist', 10, 1),
('Dr. Ryan Miller', 'ryan.miller@dentalsolutions.com', '$2a$10$G.6.Q/u.N.s/9.H/4.r/9.b.N.0/s.v/0.7/v.x.8.L.9', '444-555-6666', 'dr-ryan-miller.jpg', 'male', 'Pediatric Dentist', 11, 1),
('Dr. Elizabeth Garcia', 'elizabeth.garcia@elitedental.com', '$2a$10$y.H.K/9.l/o.K.o.q/r.r.P.4.4/r.l/a.k/k.T.k.1.L', '777-888-9999', 'dr-elizabeth-garcia.jpg', 'female', 'Endodontist', 12, 1),
('Dr. Matthew Jones', 'matthew.jones@dentalcareplus.com', '$2a$10$H.T/1.4/o.K.7.s/p.1.d.m/v.Z.n/d/g.s.0.3/s.C.b', '222-333-4444', 'dr-matthew-jones.jpg', 'male', 'Periodontist', 13, 1),
('Dr. Jessica Rodriguez', 'jessica.rodriguez@oralhealthspecialists.com', '$2a$10$V.9.Q/8.L/t.e.z/c.b.M.f.q/6.1/0.i/8.q.d.u.y', '555-666-7777', 'dr-jessica-rodriguez.jpg', 'female', 'Orthodontist', 14, 1),
('Dr. Daniel Garcia', 'daniel.garcia@healthysmilesdental.com', '$2a$10$6.T/o.m.7/s.6.2/6.u.T.0.g/o.K.v/9.M.o.k.S.g', '888-999-0000', 'dr-daniel-garcia.jpg', 'male', 'Prosthodontist', 15, 1),
('Dr. Amanda Wilson', 'amanda.wilson@dentalexcellence.com', '$2a$10$T.L/9.i.T/c.f.0.1.r.A.r.8.m/3.p.1.q.4.s.j', '111-222-3333', 'dr-amanda-wilson.jpg', 'female', 'Oral Surgeon', 16, 1),
('Dr. Christopher Davis', 'christopher.davis@smilecareclinic.com', '$2a$10$U.4/4.b/c.P.8.f.p/k.m.J.s/v.9.s/7.3.n.L.i', '444-555-6666', 'dr-christopher-davis.jpg', 'male', 'General Dentist', 17, 1),
('Dr. Emily Garcia', 'emily.garcia@dentalinnovations.com', '$2a$10$H.0.m/8.s.6.S.e.2.L.M.8.P/4.q.0.4.3.r.g', '777-888-9999', 'dr-emily-garcia.jpg', 'female', 'Cosmetic Dentist', 18, 1);

-- INSERT DATA FOR SPECIALIZATIONS
INSERT INTO Specializations (name, description, image) VALUES
('General Dentistry', 'Provides comprehensive dental care for patients of all ages.', 'general-dentistry.jpg'),
('Cosmetic Dentistry', 'Focuses on improving the aesthetics of the smile.', 'cosmetic-dentistry.jpg'),
('Pediatric Dentistry', 'Specializes in dental care for children.', 'pediatric-dentistry.jpg'),
('Endodontics', 'Deals with the pulp of the tooth and root canal treatment.', 'endodontics.jpg'),
('Periodontics', 'Concerned with the gums and tissues surrounding the teeth.', 'periodontics.jpg'),
('Orthodontics', 'Corrects misaligned teeth and bites.', 'orthodontics.jpg'),
('Prosthodontics', 'Replaces missing teeth with dentures, bridges, or implants.', 'prosthodontics.jpg'),
('Oral Surgery', 'Performs surgical procedures on the mouth, teeth, and jaw.', 'oral-surgery.jpg');

-- INSERT DATA FOR DOCTORSPECIALIZATIONS
INSERT INTO DoctorSpecializations (doctorId, specializationId) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8);

-- INSERT DATA FOR SCHEDULES
INSERT INTO Schedules (doctorId, date, startTime, endTime, maxBooking, sumBooking) VALUES
(1, '2023-11-15', '08:00:00', '12:00:00', 5, 0),
(2, '2023-11-16', '09:00:00', '13:00:00', 4, 0),
(3, '2023-11-17', '10:00:00', '14:00:00', 3, 0),
(4, '2023-11-18', '11:00:00', '15:00:00', 5, 0),
(5, '2023-11-19', '12:00:00', '16:00:00', 4, 0),
(6, '2023-11-20', '08:00:00', '12:00:00', 5, 0),
(7, '2023-11-21', '09:00:00', '13:00:00', 4, 0),
(8, '2023-11-22', '10:00:00', '14:00:00', 3, 0);

-- INSERT DATA FOR PATIENTS
INSERT INTO Patients (name, email, phone, address, gender) VALUES
('Alice Johnson', 'alice.johnson@example.com', '111-222-3333', '123 Main Street, Cityville', 'female'),
('Bob Smith', 'bob.smith@example.com', '444-555-6666', '456 Oak Avenue, Townville', 'male'),
('Carol Brown', 'carol.brown@example.com', '777-888-9999', '789 Elm Street, Villageville', 'female'),
('David Wilson', 'david.wilson@example.com', '111-222-3333', '1011 Pine Street, Cityville', 'male'),
('Emily Garcia', 'emily.garcia@example.com', '444-555-6666', '1213 Maple Street, Townville', 'female'),
('Frank Rodriguez', 'frank.rodriguez@example.com', '777-888-9999', '1415 Birch Street, Villageville', 'male'),
('Grace Martinez', 'grace.martinez@example.com', '111-222-3333', '1617 Willow Street, Cityville', 'female'),
('Henry Davis', 'henry.davis@example.com', '444-555-6666', '1819 Oak Street, Townville', 'male'),
('Isabella Miller', 'isabella.miller@example.com', '777-888-9999', '2021 Elm Street, Villageville', 'female'),
('Jacob Garcia', 'jacob.garcia@example.com', '111-222-3333', '2223 Pine Street, Cityville', 'male'),
('Katherine Jones', 'katherine.jones@example.com', '444-555-6666', '2425 Maple Street, Townville', 'female'),
('Liam Rodriguez', 'liam.rodriguez@example.com', '777-888-9999', '2627 Birch Street, Villageville', 'male'),
('Mia Wilson', 'mia.wilson@example.com', '111-222-3333', '2829 Willow Street, Cityville', 'female'),
('Noah Garcia', 'noah.garcia@example.com', '444-555-6666', '3031 Oak Street, Townville', 'male'),
('Olivia Miller', 'olivia.miller@example.com', '777-888-9999', '3233 Elm Street, Villageville', 'female'),
('Peter Jones', 'peter.jones@example.com', '111-222-3333', '3435 Pine Street, Cityville', 'male'),
('Quinn Rodriguez', 'quinn.rodriguez@example.com', '444-555-6666', '3637 Maple Street, Townville', 'female'),
('Ryan Wilson', 'ryan.wilson@example.com', '777-888-9999', '3839 Birch Street, Villageville', 'male');

-- INSERT DATA FOR APPOINTMENTS
INSERT INTO Appointments (patientId, scheduleId, status) VALUES
(1, 1, 'PENDING'),
(2, 2, 'CONFIRMED'),
(3, 3, 'CANCELED'),
(4, 4, 'PENDING'),
(5, 5, 'CONFIRMED'),
(6, 6, 'PENDING'),
(7, 7, 'CONFIRMED'),
(8, 8, 'CANCELED'),
(9, 1, 'PENDING'),
(10, 2, 'CONFIRMED'),
(11, 3, 'CANCELED'),
(12, 4, 'PENDING'),
(13, 5, 'CONFIRMED'),
(14, 6, 'PENDING'),
(15, 7, 'CONFIRMED'),
(16, 8, 'CANCELED'),
(17, 1, 'PENDING'),
(18, 2, 'CONFIRMED');

-- INSERT DATA FOR USERS
INSERT INTO Users (username, password, role, patientId, doctorId) VALUES
('johnsmith', 'password123', 'DOCTOR', NULL, 1),
('emjones', 'pass456', 'DOCTOR', NULL, 2),
('davi', 'pass789', 'DOCTOR', NULL, 3),
('sara', 'pass101', 'DOCTOR', NULL, 4),
('michael', 'pass111', 'DOCTOR', NULL, 5),
('jessic', 'pass222', 'DOCTOR', NULL, 6),
('chris', 'pass333', 'DOCTOR', NULL, 7),
('ashley', 'pass444', 'DOCTOR', NULL, 8),
('alicej', 'pass555', 'CUSTOMER', 1, NULL),
('bobs', 'pass666', 'CUSTOMER', 2, NULL),
('carolb', 'pass777', 'CUSTOMER', 3, NULL),
('dav', 'pass888', 'CUSTOMER', 4, NULL),
('emilyg', 'pass999', 'CUSTOMER', 5, NULL),
('frankr', 'pass1234', 'CUSTOMER', 6, NULL),
('gracem', 'pass1235', 'CUSTOMER', 7, NULL),
('henryd', 'pass1236', 'CUSTOMER', 8, NULL),
('isabell', 'pass1237', 'CUSTOMER', 9, NULL),
('jacob', 'pass1238', 'CUSTOMER', 10, NULL),
('kather', 'pass1239', 'CUSTOMER', 11, NULL),
('liamr', 'pass1240', 'CUSTOMER', 12, NULL),
('miaw', 'pass1241', 'CUSTOMER', 13, NULL),
('noahg', 'pass1242', 'CUSTOMER', 14, NULL),
('oliviam', 'pass1243', 'CUSTOMER', 15, NULL),
('peterj', 'pass1244', 'CUSTOMER', 16, NULL),
('quinnr', 'pass1245', 'CUSTOMER', 17, NULL),
('ryanw', 'pass1246', 'CUSTOMER', 18, NULL),
('admin', 'admin123', 'SYSTEM_ADMIN', NULL, NULL);