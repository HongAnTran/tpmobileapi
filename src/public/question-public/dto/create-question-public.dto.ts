import { IsInt,  IsNotEmpty,  IsOptional,  IsString,  } from "class-validator";

export class CreateQuestionPublicDto {
 
    @IsNotEmpty()
    @IsString()
    content: string;


    @IsNotEmpty()
    @IsInt()
    product_id: number;

    @IsOptional()
    @IsInt()
    customer_id?: number;

    @IsOptional()
    @IsString()
    email?: string;

    @IsOptional()
    @IsString()
    phone?: string;

    @IsOptional()
    @IsString()
    full_name?: string;

}
