-- CreateTable
CREATE TABLE "Student" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "calendarId" INTEGER NOT NULL,
    "ProfessorId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "department" TEXT,
    "email" TEXT NOT NULL,
    "academicScheduleSubscription" BOOLEAN NOT NULL,
    CONSTRAINT "Student_calendarId_fkey" FOREIGN KEY ("calendarId") REFERENCES "Calendar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Student_ProfessorId_fkey" FOREIGN KEY ("ProfessorId") REFERENCES "Professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Calendar" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "isHidden" BOOLEAN NOT NULL,
    "viewOptions" TEXT NOT NULL,
    "color" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "PersonalSchedule" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "calenderId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL,
    "isPublic" BOOLEAN NOT NULL,
    "priority" INTEGER NOT NULL,
    CONSTRAINT "PersonalSchedule_calenderId_fkey" FOREIGN KEY ("calenderId") REFERENCES "Calendar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Program" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "startTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    "applicationStartTime" DATETIME NOT NULL,
    "applicationEndTime" DATETIME NOT NULL,
    "programManager" TEXT NOT NULL,
    "target" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "ProgramApplication" (
    "studentId" INTEGER NOT NULL,
    "programId" INTEGER NOT NULL,
    "applicationType" TEXT NOT NULL,
    "applicationDate" DATETIME NOT NULL,
    "applicationStatus" TEXT NOT NULL,

    PRIMARY KEY ("studentId", "programId"),
    CONSTRAINT "ProgramApplication_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ProgramApplication_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PersonalizedRecommendation" (
    "studentId" INTEGER NOT NULL,
    "programId" INTEGER NOT NULL,
    "application" BOOLEAN NOT NULL,
    "inquiry" BOOLEAN NOT NULL,
    "applicationStartDate" DATETIME NOT NULL,
    "applicationEndDate" DATETIME NOT NULL,

    PRIMARY KEY ("studentId", "programId"),
    CONSTRAINT "PersonalizedRecommendation_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PersonalizedRecommendation_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Professor" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "calendarId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "contact" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    CONSTRAINT "Professor_calendarId_fkey" FOREIGN KEY ("calendarId") REFERENCES "Calendar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ProfessorRecommendation" (
    "professorId" INTEGER NOT NULL,
    "programId" INTEGER NOT NULL,
    "recommendationTime" DATETIME NOT NULL,
    "recommendationType" TEXT NOT NULL,
    CONSTRAINT "ProfessorRecommendation_professorId_fkey" FOREIGN KEY ("professorId") REFERENCES "Professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ProfessorRecommendation_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ReferralProgramInquiry" (
    "programId" INTEGER NOT NULL,
    "professorId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "application" INTEGER NOT NULL,
    "inquiry" INTEGER NOT NULL,
    "refuse" TEXT NOT NULL,
    "inquiryTime" DATETIME NOT NULL,
    "applicationStartDate" DATETIME NOT NULL,
    "applicationEndDate" DATETIME NOT NULL,
    CONSTRAINT "ReferralProgramInquiry_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ReferralProgramInquiry_professorId_fkey" FOREIGN KEY ("professorId") REFERENCES "Professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ReferralProgramInquiry_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Team" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "leaderId" INTEGER NOT NULL,
    "teamCalendarId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "creationDate" DATETIME NOT NULL,
    "status" TEXT NOT NULL,
    "memberCount" INTEGER NOT NULL,
    "meetingCount" INTEGER NOT NULL,
    CONSTRAINT "Team_leaderId_fkey" FOREIGN KEY ("leaderId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Team_teamCalendarId_fkey" FOREIGN KEY ("teamCalendarId") REFERENCES "TeamCalendar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TeamMember" (
    "teamId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "absenceCount" INTEGER NOT NULL,

    PRIMARY KEY ("teamId", "studentId"),
    CONSTRAINT "TeamMember_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeamMember_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TeamCalendar" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "isHidden" BOOLEAN NOT NULL,
    "viewOptions" TEXT NOT NULL,
    "color" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "TeamMeetingSchedule" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "teamCalendarId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL,
    "location" TEXT NOT NULL,
    "notificationStartTime" DATETIME NOT NULL,
    "activityTime" INTEGER NOT NULL,
    "activityContent" TEXT NOT NULL,
    "feedback" TEXT NOT NULL,
    "representativePhoto" TEXT NOT NULL,
    "notificationStartSettings" TEXT NOT NULL,
    "notificationContent" TEXT NOT NULL,
    CONSTRAINT "TeamMeetingSchedule_teamCalendarId_fkey" FOREIGN KEY ("teamCalendarId") REFERENCES "TeamCalendar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TeamMeetingAttendance" (
    "scheduleId" INTEGER NOT NULL,
    "teamId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "attendanceStatus" BOOLEAN NOT NULL,
    "absenceReason" TEXT NOT NULL,

    PRIMARY KEY ("scheduleId", "teamId", "studentId"),
    CONSTRAINT "TeamMeetingAttendance_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "TeamMeetingSchedule" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeamMeetingAttendance_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeamMeetingAttendance_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TeamNotification" (
    "meetingScheduleId" INTEGER NOT NULL,
    "teamId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "receptionStatus" BOOLEAN NOT NULL,
    "transmissionTime" DATETIME NOT NULL,
    "receptionTime" DATETIME,
    "notificationContent" TEXT NOT NULL,

    PRIMARY KEY ("meetingScheduleId", "teamId", "studentId"),
    CONSTRAINT "TeamNotification_meetingScheduleId_fkey" FOREIGN KEY ("meetingScheduleId") REFERENCES "TeamMeetingSchedule" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeamNotification_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeamNotification_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "StudyRoom" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "StudyRoomDate" (
    "date" DATETIME NOT NULL PRIMARY KEY,
    "roomId" INTEGER NOT NULL,
    "isAvailable" BOOLEAN NOT NULL,
    CONSTRAINT "StudyRoomDate_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "StudyRoom" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "StudyRoomTime" (
    "reservationTime" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "dateId" DATETIME NOT NULL,
    "roomId" INTEGER NOT NULL,
    "scheduleID" INTEGER NOT NULL,
    "startTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    CONSTRAINT "StudyRoomTime_dateId_fkey" FOREIGN KEY ("dateId") REFERENCES "StudyRoomDate" ("date") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Student_calendarId_key" ON "Student"("calendarId");

-- CreateIndex
CREATE UNIQUE INDEX "Student_ProfessorId_key" ON "Student"("ProfessorId");

-- CreateIndex
CREATE UNIQUE INDEX "Student_email_key" ON "Student"("email");

-- CreateIndex
CREATE UNIQUE INDEX "PersonalSchedule_calenderId_key" ON "PersonalSchedule"("calenderId");

-- CreateIndex
CREATE UNIQUE INDEX "ProfessorRecommendation_programId_key" ON "ProfessorRecommendation"("programId");

-- CreateIndex
CREATE UNIQUE INDEX "ReferralProgramInquiry_programId_key" ON "ReferralProgramInquiry"("programId");

-- CreateIndex
CREATE UNIQUE INDEX "ReferralProgramInquiry_professorId_key" ON "ReferralProgramInquiry"("professorId");

-- CreateIndex
CREATE UNIQUE INDEX "ReferralProgramInquiry_studentId_key" ON "ReferralProgramInquiry"("studentId");
