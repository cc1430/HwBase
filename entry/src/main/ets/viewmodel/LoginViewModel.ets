import { tempLogin } from '../http/apiService'
import { BaseViewModel, ResultCallback } from './BaseViewModel'

export class LoginViewModel extends BaseViewModel{

  doLogin(phone: string, resultCallback?: ResultCallback) {
    tempLogin(phone).then(result=> resultCallback?.(result))
  }
}


export default new LoginViewModel()