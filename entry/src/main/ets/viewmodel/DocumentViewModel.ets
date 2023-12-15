import { DocumentBean } from '../model/DocumentBean'

export class DocumentViewModel{

  private dataList: Array<DocumentBean>

  getData(): Array<DocumentBean> {
    this.dataList = new Array
    let a = new DocumentBean("星期一", "1", 0)
    this.dataList.push(a)
    a = new DocumentBean("星期二", "1", 0)
    this.dataList.push(a)
    a = new DocumentBean("星期三", "1", 0)
    this.dataList.push(a)
    a = new DocumentBean("星期四", "1", 0)
    this.dataList.push(a)
    a = new DocumentBean("星期五", "1", 0)
    this.dataList.push(a)
    a = new DocumentBean("星期六", "1", 0)
    this.dataList.push(a)
    a = new DocumentBean("星期日", "1", 0)
    this.dataList.push(a)
    a = new DocumentBean("星期一", "2", 1)
    this.dataList.push(a)
    a = new DocumentBean("星期二", "2", 1)
    this.dataList.push(a)
    a = new DocumentBean("星期三", "2", 1)
    this.dataList.push(a)
    a = new DocumentBean("星期四", "2", 1)
    this.dataList.push(a)
    a = new DocumentBean("星期五", "2", 1)
    this.dataList.push(a)
    a = new DocumentBean("星期六", "2", 1)
    this.dataList.push(a)
    a = new DocumentBean("星期日", "2", 1)
    this.dataList.push(a)


    return this.dataList
  }

}

export default new DocumentViewModel();
