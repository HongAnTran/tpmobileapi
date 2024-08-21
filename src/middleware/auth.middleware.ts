// // src/middleware/auth.middleware.ts
// import { Request, Response, NextFunction } from 'express';
// import { verify } from 'jsonwebtoken';
// import { PrismaService } from 'src/prisma.service';
// import { Injectable, UnauthorizedException } from '@nestjs/common';

// @Injectable()
// export class AuthMiddleware {
//   constructor(private readonly prisma: PrismaService) {}

//   async use(req: Request, res: Response, next: NextFunction) {
//     const token = req.headers.authorization?.split(' ')[1];
//     if (!token) {
//       throw new UnauthorizedException('No token provided');
//     }

//     try {
//       const decoded = verify(token, process.env.JWT_SECRET) as { userId: number };
//       const user = await this.prisma.customer.findUnique({ where: { id: decoded.userId } });
//       if (!user) {
//         throw new UnauthorizedException('Invalid token');
//       }
//       req.user = user;
//       next();
//     } catch (err) {
//       throw new UnauthorizedException('Invalid token');
//     }
//   }
// }
