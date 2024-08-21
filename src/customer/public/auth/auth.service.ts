import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from 'src/prisma.service';
import { LoginCustomerDto } from './dtos/auth.dto';
import { RegisterCustomerDto } from './dtos/auth.dto';

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService, private jwtService: JwtService) {}

  async login(dto: LoginCustomerDto): Promise<{ access_token: string }> {
    const { email, password } = dto;
    const customer = await this.prisma.customer.findUnique({ where: { email } });
    if (!customer || !(await bcrypt.compare(password, customer.password))) {
      throw new NotFoundException('Invalid credentials');
    }
    // Generate JWT token
    const payload = { email: customer.email, sub: customer.id };
    const access_token = this.jwtService.sign(payload);
    return { access_token };
  }

  async register(dto: RegisterCustomerDto): Promise<{ access_token: string }> {
    const { email, password, name, phone , provider } = dto;

    // Check if user already exists
    const existingCustomer = await this.prisma.customer.findUnique({ where: { email } });
    if (existingCustomer) {
      throw new ConflictException('Email already in use');
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create new user
    const newCustomer = await this.prisma.customer.create({
      data: {
        email,
        password: hashedPassword,
        name,
        phone,
        provider
      },
    });

    // Generate JWT token
    const payload = { email: newCustomer.email, sub: newCustomer.id };
    const access_token = this.jwtService.sign(payload);
    return { access_token };
  }

  async refreshToken(userId: number): Promise<{ access_token: string }> {
    // Find the customer by ID
    const customer = await this.prisma.customer.findUnique({ where: { id: userId } });
    if (!customer) {
      throw new NotFoundException('User not found');
    }

    // Generate new JWT token
    const payload = { email: customer.email, sub: customer.id };
    const access_token = this.jwtService.sign(payload);
    return { access_token };
  }
}
