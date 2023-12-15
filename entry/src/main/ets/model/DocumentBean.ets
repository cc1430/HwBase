/**
 * DocumentBean
 */
import App from '@system.app'
import promptAction from '@ohos.promptAction'
export class DocumentBean{
  constructor(docName:string, category: string, number?:number) {
    this.docName = docName
    this.category = category
    this.number = number
  }

  docName: string

  category: string

  number: number;

  getBackgroundColor(): Resource {
    if (this.category == "1") {
      return $r('app.color.blue_007DFF')
    } else if (this.category == "2") {
      return $r('app.color.orange_E09449')
    }
  }
}