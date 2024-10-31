import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  catch(exception: any, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    const request = ctx.getRequest();
    const status =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    const message =
      exception instanceof HttpException
        ? exception.message
        : 'Internal server error';

    const error =
      exception instanceof HttpException
        ? exception.getResponse()
        : 'Internal Server Error';

    const details =
      exception instanceof HttpException && typeof error === 'object'
        ? error['details'] || []
        : [];

    response.status(status).json({
      statusCode: status,
      message: message,
      error: typeof error === 'string' ? error : error['error'] || 'Error',
      details,
    });
  }
}
