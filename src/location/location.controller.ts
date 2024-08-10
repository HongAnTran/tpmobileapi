import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { LocationService } from './location.service';
import { LocationTypeCode, Prisma } from '@prisma/client';

@Controller('location')
export class LocationController {
  constructor(private readonly locationService: LocationService) { }

  @Post()
  create(@Body() createLocationDto: Prisma.LocationCreateInput) {
    return this.locationService.create(createLocationDto);
  }

  @Get()
  findAll(@Query() query: {
    type?: LocationTypeCode
    parent_code?: string
  }) {
    return this.locationService.findAll({ type: query.type, parent_code: query.parent_code });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.locationService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateLocationDto: Prisma.LocationUpdateInput) {
    return this.locationService.update(+id, updateLocationDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.locationService.remove(+id);
  }
}
