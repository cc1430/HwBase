@Entry
@Component
export struct VideoPage {
  @State videoSrc: string = "https://vd4.bdstatic.com/mda-pgj1vsjrki3yx9dv/720p/h264/1689816023069362244/mda-pgj1vsjrki3yx9dv.mp4?v_from_s=hkapp-haokan-suzhou&auth_key=1702621031-0-0-6b7479f2c99014d8dded8701b3039500&bcevod_channel=searchbox_feed&cr=2&cd=0&pd=1&pt=3&logid=1031443211&vid=8030975999338035335&klogid=1031443211&abtest=114675_1"
  @State previewUri: Resource = $r('app.media.video_preview')
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State isAutoPlay: boolean = false
  @State showControls: boolean = true
  controller: VideoController = new VideoController()

  build() {
    Column() {
      Video({
        src: this.videoSrc,
        previewUri: this.previewUri,
        currentProgressRate: this.curRate,
        controller: this.controller
      })
        .width('100%')
        .height(280)
        .autoPlay(this.isAutoPlay)
        .controls(this.showControls)
        .onStart(() => {
          console.info('onStart')
        })
        .onPause(() => {
          console.info('onPause')
        })
        .onFinish(() => {
          console.info('onFinish')
        })
        .onError(() => {
          console.info('onError')
        })
        .onPrepared((e) => {
          console.info('onPrepared is ' + e.duration)
        })
        .onSeeking((e) => {
          console.info('onSeeking is ' + e.time)
        })
        .onSeeked((e) => {
          console.info('onSeeked is ' + e.time)
        })
        .onUpdate((e) => {
          console.info('onUpdate is ' + e.time)
        })

      // Row() {
      //   Button('src').onClick(() => {
      //     this.videoSrc = "" // 切换视频源
      //   }).margin(5)
      //   Button('previewUri').onClick(() => {
      //     this.previewUri = $r('app.media.video_preview_2') // 切换视频预览海报
      //   }).margin(5)
      //   Button('controls').onClick(() => {
      //     this.showControls = !this.showControls // 切换是否显示视频控制栏
      //   }).margin(5)
      // }
      //
      // Row() {
      //   Button('start').onClick(() => {
      //     this.controller.start() // 开始播放
      //   }).margin(5)
      //   Button('pause').onClick(() => {
      //     this.controller.pause() // 暂停播放
      //   }).margin(5)
      //   Button('stop').onClick(() => {
      //     this.controller.stop() // 结束播放
      //   }).margin(5)
      //   Button('setTime').onClick(() => {
      //     this.controller.setCurrentTime(10, SeekMode.Accurate) // 精准跳转到视频的10s位置
      //   }).margin(5)
      // }

      Row() {
        Button('rate 0.75').onClick(() => {
          this.curRate = PlaybackSpeed.Speed_Forward_0_75_X // 0.75倍速播放
        }).margin(5)
        Button('rate 1').onClick(() => {
          this.curRate = PlaybackSpeed.Speed_Forward_1_00_X // 原倍速播放
        }).margin(5)
        Button('rate 2').onClick(() => {
          this.curRate = PlaybackSpeed.Speed_Forward_2_00_X // 2倍速播放
        }).margin(5)
      }
    }
  }
}