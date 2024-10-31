import { Injectable } from "@nestjs/common";
import { PaginationDto } from "../dtos/pagination.dto";
import { ResponseList } from "../types/Common.type";
import { CONFIG_APP } from "../config";

@Injectable()
export class PaginationService {
  getPaginationOptions(paginationDto: PaginationDto) {
    const {
      page = 1,
      limit = CONFIG_APP.MAX_SIZE_LIMIT,
      sortBy,
      sortType = "asc",
      include,
    } = paginationDto;
    const take =
      limit <= CONFIG_APP.MAX_SIZE_LIMIT ? limit : CONFIG_APP.MAX_SIZE_LIMIT;
    const skip = (page - 1) * limit;

    const orderBy = sortBy ? { [sortBy]: sortType } : undefined;

    const includeParams = include ? include.split(",") : [];
    let includeQuery = includeParams.reduce((pre, item) => {
      pre[item] = true;
      return pre;
    }, {});
    return { skip, take, orderBy, include: includeQuery };
  }

  async paginate<T, D extends { findMany: Function; count: Function }>(
    model: D,
    paginationDto: PaginationDto,
    where: T = {} as T
  ): Promise<ResponseList<any>> {
    const { skip, take, orderBy, include } =
      this.getPaginationOptions(paginationDto);
    const datas = await model.findMany({
      where,
      skip,
      take,
      orderBy,
      include,
    });
    const total = await model.count({ where });
    return {
      datas,
      total,
    };
  }
}
