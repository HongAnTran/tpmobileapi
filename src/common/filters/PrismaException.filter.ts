import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpStatus,
  HttpException,
} from "@nestjs/common";
import { Prisma } from "@prisma/client";

@Catch(Prisma.PrismaClientKnownRequestError)
export class PrismaExceptionFilter implements ExceptionFilter {
  catch(exception: Prisma.PrismaClientKnownRequestError, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();

    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message = "Internal server error";
    switch (exception.code) {
      case "P2002":
        status = HttpStatus.CONFLICT;
        message = "Unique constraint failed";
        break;
      case "P2003":
        status = HttpStatus.BAD_REQUEST;
        message = "Foreign key constraint failed";
        break;
      case "P2025":
        status = HttpStatus.NOT_FOUND;
        message = "Record to update not found";
        break;
      default:
        message = exception.message;
    }
    console.log({
      statusCode: status,
      message: message,
      error: exception.meta,
    });
    response.status(status).json({
      statusCode: status,
      message: message,
      error: exception.meta,
    });
  }
}
