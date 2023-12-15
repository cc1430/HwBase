
import { SystemBean } from './SystemBean'
export class RequestBaseBean<T> {
  system: SystemBean
  params: T
}