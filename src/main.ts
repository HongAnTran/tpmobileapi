import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { PrismaService } from "./prisma.service";
import { ValidationPipe } from "@nestjs/common";
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const config = new DocumentBuilder()
    .setTitle('TP Mobile API')
    .setDescription('The TP Mobile API description')
    .setVersion('0.1')
    .build();


  app.useGlobalPipes(new ValidationPipe());
  app.setGlobalPrefix("v1");
  app.enableCors();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);
  const prismaService = app.get(PrismaService);
  await prismaService.$connect();
  await app.listen(3001);
}
bootstrap();
