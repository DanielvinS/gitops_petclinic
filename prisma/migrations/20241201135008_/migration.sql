-- AlterTable
ALTER TABLE "PersonalSchedule" ADD COLUMN "professorId" INTEGER;

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_StudyRoomTime" (
    "reservationTime" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "dateId" DATETIME NOT NULL,
    "roomId" INTEGER NOT NULL,
    "scheduleID" INTEGER NOT NULL,
    "startTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    CONSTRAINT "StudyRoomTime_dateId_fkey" FOREIGN KEY ("dateId") REFERENCES "StudyRoomDate" ("date") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "StudyRoomTime_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "StudyRoom" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_StudyRoomTime" ("dateId", "endTime", "reservationTime", "roomId", "scheduleID", "startTime") SELECT "dateId", "endTime", "reservationTime", "roomId", "scheduleID", "startTime" FROM "StudyRoomTime";
DROP TABLE "StudyRoomTime";
ALTER TABLE "new_StudyRoomTime" RENAME TO "StudyRoomTime";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
