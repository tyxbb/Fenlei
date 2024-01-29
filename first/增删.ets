import router from '@ohos.router'
@Entry
@Component
struct Index {
 onPageShow(){
   setTimeout(()=>{
     router.pushUrl({url:"pages/Home"})
   },3000)
 }

  build() {
    Flex({
      direction:FlexDirection.Column,
      alignItems:ItemAlign.Center,
      justifyContent:FlexAlign.Center
      }){
      Image($r(`icon`))
        .width(100)
        .height(100)
        .margin(20)

      Text(`欢迎来到 食物分类APP`)
        .fontSize(20)
        .fontColor(Color.White)
        .margin({bottom:10})

      Text(`食物分类App时刻管理你的健康`)
        .fontSize(16)
        .fontColor(Color.White)
    }
    .width(`100%`)
    .height(`100%`)
    .backgroundColor(Color.Green)
  }
}