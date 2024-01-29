let MyID = `derry.com.id.test`//所有的CheckBox与CheckBoxGroup的ID一直，就可以实现全选功能

//任务类
@Observed//第一步：标记对象可以被对象嵌套，也能实现ui刷新机制
class Task{
  static id: number = 1//所有地方公用一个静态成员
  //任务名称
  name: string=`目标${Task.id++}`
  //任务状态:是否完成
  finished: boolean = false//复选框,勾选就是ture
}
//统一的卡片样式
@Styles function card(){
 .width('95%')
 .padding(20)
 .backgroundColor(Color.White)
 .borderRadius(15)
 .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})
}
  //任务统计信息
  class StatInfo {
    totalTask: number = 0
    finishTask: number = 0
/*
    constructor(totalTask:number,finishTask:number) {
      this.totalTask = totalTask
      this.finishTask = finishTask
  }*/
  }

@Entry
@Component
struct DemoPage {
  @Provide stateInfo: StatInfo = new StatInfo()//统计信息

  build() {
    Column({space:10}){
       //显示待完成目标项目卡片
      TaskStatistics()
      //任务列表区域
      TaskList()
    }
    .width(`100%`)
    .height(`100%`)
    .backgroundColor(Color.Pink)
  }
}

@Component
struct TaskStatistics {
  @Consume stateInfo : StatInfo//输入传递
  build(){
    Row(){
      Text(`待完成的目标项：`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Orange)

      Row(){
        Progress({
          value:this.stateInfo.finishTask,
          total:this.stateInfo.totalTask,
          type:ProgressType.Capsule
        })
          .width(100)
          .backgroundColor(Color.Orange)
          .color(Color.Green)
          .margin({right:16})

          Row(){
           Text(this.stateInfo.finishTask.toString())
             .fontColor(Color.Green)
             .fontSize(24)
          Text(`/`+this.stateInfo.totalTask.toString())
            .fontColor(Color.Orange)
            .fontSize(24)
          }
      }


    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({top:20,bottom:10})
  }
}

@Component
struct TaskList{

  @Consume stateInfo:StatInfo//总数量、目标完成数等信息

  @State tasks:Task[] =[]//目标合集数组
  handTaskChange(){
  //更新目标数量
  this.stateInfo.totalTask = this.tasks.length //总数量更新
  this.stateInfo.finishTask = this.tasks.filter(item => item.finished).length//完成数量更新

  }
  build() {
    Column() {
      //新增目标按钮
      Button(`定下你的目标`)
        .width(`90%`)
        .margin({ bottom: 10 })
        .onClick(() => {
          this.tasks.push(new Task()) //增加任务数据
          this.handTaskChange()
        })
        .backgroundColor(Color.Orange)

      List({ space: 10 }) { //新增目标列表
        ForEach(
          this.tasks,
          (item: Task, index) => {
            ListItem() {
              TaskItem({ item: item, onTaskChange: this.handTaskChange.bind(this) })
            }
            .swipeAction({end:this.DeleteItemAction(index), start:this.DeleteItemAction(index)})
          }
        )
      }
      .width(`100%`)
      .height(`60%`)
      .alignListItem(ListItemAlign.Center)//List组间特殊情况，手动调节居中

      //对底部的操作
      if(this.tasks.length>0){
        Row(){
          Row(){
            Text(`全选`).fontColor(Color.White)
            CheckboxGroup()
              .id(MyID)
              //.selectAll(this.selectAll)
          }
          .borderRadius(15)
          .width(80)
          .height(40)
          .backgroundColor(Color.Gray)
          .justifyContent(FlexAlign.Center)

          Button(`删除`).backgroundColor(Color.Red)
            .onClick(()=>{
             /* ForEach(
                this.tasks,
                (item:Task,index:number)=>{
                  if(item.finished){
                    this.tasks.splice(index,1)*/
              this.tasks.map((value:Task,index:number)=>{
                if(value.finished){
                  this.tasks.splice(index,1)
                  this.handTaskChange()
                  }
                }
              )
            })
        }
        .width(`90%`)
        .justifyContent(FlexAlign.SpaceAround)
        .backgroundColor(`#fffa9898`)
        .borderRadius(15)
      }
    }
  }
   @Builder DeleteItemAction(index:number){
    Button(){
      Image($r("app.media.laji"))
      .fillColor(Color.White)
      .width(20)
    }
     .width(40)
     .height(40)
     .backgroundColor(Color.Red)
     .margin(6)
     .onClick(()=>{
       this.tasks.splice(index,1)
       this.handTaskChange()
     })
   }
}

@Component
struct  TaskItem{
  @ObjectLink item :Task
  onTaskChange:()=>void
  build(){
    Row(){
      if(this.item.finished){//打钩的
        TextInput({text:this.item.name,placeholder:`请输入你的目标`})
          .width(200)
          .fontColor(Color.Gray)
          .opacity(0.3)
        }else{//不勾的
        TextInput({text:this.item.name,placeholder:`请输入你的目标`})
          .width(200)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }
      Checkbox()
        .id(MyID)
        .select(this.item.finished)
        .onChange(value=>{
          this.item.finished = value//更新当前任务状态
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }

}
