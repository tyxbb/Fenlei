import lottie from '@ohos/lottie'
@Entry
@Component
struct Index {
  private renderingSettings:RenderingContextSettings = new RenderingContextSettings(true);
  private renderingContext:CanvasRenderingContext2D= new CanvasRenderingContext2D(this.renderingSettings);
  //private controller:RenderingContext=new RenderingContext();
  private animateName:string="animation";
  private animatePath:string = "common/lottie/光照.json";
 /* private onPageHide(): void{
    lottie.destroy();
  }*/
  build() {
      Column(){
        //Animator(`_lottie_ets`)
        Canvas(this.renderingContext)
          .width(`30%`)
          .backgroundColor(Color.Green)
         .onAppear(()=>{
            let animate =lottie.loadAnimation({
              container:this.renderingContext,
              renderer:`canvas`,
              loop:true,
              autoplay:true,
              name:this.animateName,
              path:this.animatePath
            })
            })
        Button("加载动画")
          .width("70%")
          .onClick(()=>{
             lottie.togglePause(this.animateName);
            })
          }
          .width(`100%`)
          .height(`100%`)
    }
  }
