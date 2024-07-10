export class CreateMailDto {

  to: string // list of receivers
  from: string // sender address
  subject: string // Subject line
  text: string // plaintext body
  html: string // HTML body content

}
