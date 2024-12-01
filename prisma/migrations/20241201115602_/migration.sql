/*
  Warnings:

  - Added the required column `contact` to the `Student` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Student" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "calendarId" INTEGER NOT NULL,
    "ProfessorId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "contact" TEXT NOT NULL,
    "department" TEXT,
    "email" TEXT NOT NULL,
    "academicScheduleSubscription" BOOLEAN NOT NULL,
    CONSTRAINT "Student_calendarId_fkey" FOREIGN KEY ("calendarId") REFERENCES "Calendar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Student_ProfessorId_fkey" FOREIGN KEY ("ProfessorId") REFERENCES "Professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Student" ("ProfessorId", "academicScheduleSubscription", "calendarId", "department", "email", "id", "name") SELECT "ProfessorId", "academicScheduleSubscription", "calendarId", "department", "email", "id", "name" FROM "Student";
DROP TABLE "Student";
ALTER TABLE "new_Student" RENAME TO "Student";
CREATE UNIQUE INDEX "Student_calendarId_key" ON "Student"("calendarId");
CREATE UNIQUE INDEX "Student_ProfessorId_key" ON "Student"("ProfessorId");
CREATE UNIQUE INDEX "Student_email_key" ON "Student"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
