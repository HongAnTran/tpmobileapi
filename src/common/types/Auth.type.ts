import { Request } from "express";
interface AuthenticatedRequest extends Request {
  user: {
    id: number;
    email: string;
  };
}

export type { AuthenticatedRequest };
