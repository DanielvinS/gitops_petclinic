import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// 학생 정보 생성
export const createStudent = async (data: {
     name: string;
     department?: string;
     email: string;
     academicScheduleSubscription: boolean;
     calendarId: number;
     ProfessorId: number;
}) => {
     return await prisma.student.create({
          data,
     });
};

// 학생 정보 조회, 가져오기
export const getAllStudents = async () => {
     return await prisma.student.findMany();
};

// ID으로 학생정보 조회
export const getStudentById = async (id: number) => {
     return await prisma.student.findUnique({
     where: { id },
     });
};

// 학생정보 갱신
export const updateStudent = async (id: number, data: Partial<{
     name: string;
     department?: string;
     email: string;
     contact: string;

     academicScheduleSubscription: boolean;
}>) => {
     return await prisma.student.update({
          where: { id },
     data,
     });
};

// 학생정보 삭제
export const deleteStudent = async (id: number) => {
     return await prisma.student.delete({
          where: { id },
     });
};
