import router from '@ohos.router';
import { FoodInfo } from '../model/DataModels';
@Entry
@Component
struct Home {
  @State cTabIndex:number=0;

  build() {
    Tabs() {
      TabContent() {
        Foods()
      }
      .tabBar(this.bar(`首页`,$r('app.media.icon'),0))

      TabContent() {
        Text(`此功能开发中···`).fontSize(20).fontColor(Color.Green)
      }
      .tabBar(this.bar(`我的`,$r('app.media.icon'),0))
    }
    .barPosition(BarPosition.End)
    .onChange((index)=>{
      this.cTabIndex=index
    })
  }

  @Builder bar(name: string, icon: Resource, index: number) {//导航栏
    Flex({
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.Center
    }) {
      Image($r('app.media.icon'))
        .width(26)
        .height(20)
        .margin(10)

      Text(name).fontSize(14).fontColor(Color.Green)
    }
  }
}

@Component
struct Foods{
  @State cIndex:number=0
//分类
  private categories: Array<{id:number,name:string}> = [
  {id:1,name:'菠菜'},{id:2,name:'水果'},{id:3,name:'坚果'},{id:4,name:'海鲜'}
]

  private foods:Array<FoodInfo> = [
    {
      id:0,
      name:'番茄',
      kk:15,
      category:1,
      img:$r('app.media.fanqie'),
      rl:0,
      yy:0,
      zf:0
    },
    {
      id:1,
      name:'苹果',
      kk:66,
      category:1,
      img:$r('app.media.img_5'),
      rl:0,
      yy:0,
      zf:0
    }
  ]
  build(){
    Tabs(){
      TabContent(){
        Grid(){
          ForEach(this.foods,(item,index)=>{
            GridItem(){
              FoodItem({food:item})

            }
          })
        }
        .columnsTemplate(`1fr 1fr`)
        .columnsGap(10)
        .rowsGap(10)
      }
    }
  }
}
//每一个Item的具体样式
@Component
struct FoodItem{
  private food:FoodInfo

  build(){
    Column(){
      Image(this.food.img).width(`95%`).height(152).backgroundColor(`#f1f3f5`).objectFit(ImageFit.Contain)
      Row(){
        Text(this.food.name).fontSize(16).fontColor(0x3E3E3E)
        Blank()
        Text(this.food.kk+`千卡`).fontColor(0x3E3E3E).fontSize(16)
      }
      .width(`100%`)
      .height(32)
      .backgroundColor(`#e5e5e5`)
      .padding({left:12,right:12})
    }
    .clip(new Rect({width:`100%`,height:`100%`,radius:6}))
    .onClick(()=>{
      console.log(JSON.stringify(this.food))
      router.pushUrl({
        url:`pages/Detail`,
        params:{
          foodInfo:this.food
        }
      })
    })
  }
}