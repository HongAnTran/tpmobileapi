import { Module } from "@nestjs/common";
import { ProductModule } from "../product/product.module";
import { CategoryProductModule } from "../category-product/category-product.module";
import { UsersModule } from "../users/users.module";
import { SpecificationsModule } from "../specifications/specifications.module";
import { ArticleModule } from "../article/article.module";
import { CategoryArticleModule } from "../category-article/category-article.module";
import { ProductVariantModule } from "../product-variant/product-variant.module";
import { OrdersModule } from "../orders/orders.module";
import { PagesModule } from "../pages/pages.module";
import { SettingsModule } from "../settings/settings.module";
import { CartsModule } from "../carts/carts.module";
import { LocationModule } from "../location/location.module";
import { CustomerModule } from "../customer/customer.module";
import { StoreModule } from "../store/store.module";
import { RatingModule } from "../rating/rating.module";
import { QuestionModule } from "../question/question.module";
import { BrandModule } from "../brand/brand.module";
import { TagsModule } from "../tags/tags.module";
import { ProductImageModule } from "../product-image/product-image.module";
import { AttributesModule } from "../attributes/attributes.module";
import { AttributesValueModule } from "../attributes-value/attributes-value.module";
import { ProductAttributesModule } from "../product-attributes/product-attributes.module";
import { StaticModule } from "../static/static.module";
import { CloudinaryModule } from "../cloudinary/cloudinary.module";
import { AuthModule } from "../auth/auth.module";
import { AccountModule } from "../account/account.module";
import { RoleModule } from "../role/role.module";
import { ReportModule } from "../report/report.module";
import { ProductConsultationModule } from "../product-consultation/product-consultation.module";
import { AuthGuard } from "src/auth/jwt.guard";
@Module({
  imports: [
    ProductModule,
    CategoryProductModule,
    UsersModule,
    SpecificationsModule,
    ArticleModule,
    CategoryArticleModule,
    ProductVariantModule,
    OrdersModule,
    PagesModule,
    SettingsModule,
    CartsModule,
    LocationModule,
    CustomerModule,
    StoreModule,
    RatingModule,
    QuestionModule,
    BrandModule,
    TagsModule,
    ProductImageModule,
    AttributesModule,
    AttributesValueModule,
    ProductAttributesModule,
    StaticModule,
    CloudinaryModule,
    AuthModule,
    AccountModule,
    RoleModule,
    ReportModule,
    ProductConsultationModule,
  ],
  providers: [AuthGuard],
})
export class PrivateModule {}
