import { Controller, Get, HttpCode, HttpStatus } from '@nestjs/common';

@Controller('/')
export class HealthController {
  @HttpCode(HttpStatus.OK)
  @Get()
  getStatus() {
    return 'OK';
  }

  @HttpCode(HttpStatus.OK)
  @Get('/health')
  getHealth() {
    return 'OK';
  }
}
