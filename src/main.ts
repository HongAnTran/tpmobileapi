import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { ValidationPipe } from "@nestjs/common";
import { SwaggerModule, DocumentBuilder } from "@nestjs/swagger";
import { PrismaExceptionFilter } from "./common/filters/PrismaException.filter";
import { JwtService } from "@nestjs/jwt";
import { Reflector } from "@nestjs/core";
import { AuthGuard } from "./auth/jwt.guard";
import "./instrument";
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const config = new DocumentBuilder()
    .setTitle("TP Mobile API")
    .setDescription("The TP Mobile API description")
    .setVersion("0.1")
    .build();

  const reflector = app.get(Reflector);
  const jwtService = app.get(JwtService);
  app.useGlobalGuards(new AuthGuard(jwtService, reflector));
  app.useGlobalFilters(new PrismaExceptionFilter());
  app.useGlobalPipes(new ValidationPipe());
  app.setGlobalPrefix("v1");
  app.enableCors();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup("api/docs", app, document);
  await app.listen(4000);
}
bootstrap();
