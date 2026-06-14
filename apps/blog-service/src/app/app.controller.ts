import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { test } from '@test-workspace/my-nest-lib'

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getData() {
    console.log(test)
    return test
  }
}
