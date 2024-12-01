import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// 새로운 일정 생성
export const createCalendar = async (data: {
     name: string;
     isHidden: boolean;
     viewOptions: string;
     color: string;
}) => {
     return await prisma.calendar.create({
          data,
     });
};

// 모든 일정 조회, 가져오기
export const getAllCalendars = async () => {
     return await prisma.calendar.findMany();
};

// ID으로 일정 조회
export const getCalendarById = async (id: number) => {
     return await prisma.calendar.findUnique({
          where: { id },
     });
};

// 일정 갱신
export const updateCalendar = async (id: number, data: Partial<{
     name: string;
     isHidden: boolean;
     viewOptions: string;
     color: string;
}>) => {
     return await prisma.calendar.update({
          where: { id },
     data,
     });
};

// 일정 삭제
export const deleteCalendar = async (id: number) => {
     return await prisma.calendar.delete({
          where: { id },
     });
};
