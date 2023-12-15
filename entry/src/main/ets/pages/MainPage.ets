import CommonConstants from '../common/CommonConstants'
import { DeviceListPage } from './DeviceListPage'
import { Index } from './Index'
import { PersonPage } from './PersonPage'
import { StudyPage } from './StudyPage'

@Entry
@Component
export struct MainPage {
  @State selectIndex: number = 0
  tabItems: TabItem[] = [
    {
      index: 0,
      title: "首页",
      imageNormal: $r('app.media.home_normal'),
      imagePush: $r('app.media.home_push'),
      titleColorNormal: $r('app.color.black_2C2C2C'),
      titleColorPush: $r('app.color.blue_007DFF')
    },
    {
      index: 1,
      title: "设备",
      imageNormal: $r('app.media.device_normal'),
      imagePush: $r('app.media.device_push'),
      titleColorNormal: $r('app.color.black_2C2C2C'),
      titleColorPush: $r('app.color.blue_007DFF')
    },
    {
      index: 2,
      title: "学习",
      imageNormal: $r('app.media.study_normal'),
      imagePush: $r('app.media.study_push'),
      titleColorNormal: $r('app.color.black_2C2C2C'),
      titleColorPush: $r('app.color.blue_007DFF')
    },
    {
      index: 3,
      title: "个人",
      imageNormal: $r('app.media.person_normal'),
      imagePush: $r('app.media.person_push'),
      titleColorNormal: $r('app.color.black_2C2C2C'),
      titleColorPush: $r('app.color.blue_007DFF')
    }
  ]

  aboutToAppear() {

  }

  build() {
    Column() {
      Tabs({ index: this.selectIndex, barPosition: BarPosition.End }) {
        TabContent() {
          Index()
        }
        .tabBar(this.TabButton(this.tabItems[0], 0))

        TabContent() {
          DeviceListPage()
        }
        .tabBar(this.TabButton(this.tabItems[1], 1))

        TabContent() {
          StudyPage()
        }
        .tabBar(this.TabButton(this.tabItems[2], 2))

        TabContent() {
          PersonPage()
        }
        .tabBar(this.TabButton(this.tabItems[3], 3))
      }
      .barWidth(CommonConstants.FULL_LENGTH)
      .barHeight(70)
      .barMode(BarMode.Fixed)
      .scrollable(false)
      .onChange((index) => {
        this.selectIndex = index
      })
    }
  }

  @Builder TabButton(tabItem: TabItem, index: number) {
    Column() {
      Image(this.selectIndex == index? tabItem.imagePush : tabItem.imageNormal)
        .width(30)
        .height(30)
        .margin(5)

      Text(tabItem.title)
        .fontColor(this.selectIndex == index? tabItem.titleColorPush: tabItem.titleColorNormal)
        .fontSize(16)
        .margin(2)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.Center)
  }
}

class TabItem {
  index: number
  title: string
  imageNormal: Resource
  imagePush: Resource
  titleColorNormal: Resource
  titleColorPush: Resource
}