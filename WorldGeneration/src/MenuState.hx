package ;
import flash.Lib;
import sexual_tengine.ST_Game;
import sexual_tengine.ST_State;
import sexual_tengine.ui.ST_UiButton;
import sexual_tengine.ui.ST_UiLabel;
import sexual_tengine.ui.ST_UiLayoutUtil;
import sexual_tengine.ui.ST_UiLinearLayout;
import sexual_tengine.ui.ST_UiPanel;

/**
 * ...
 * @author ryan
 */
class MenuState extends ST_State
{
	var mainPanel:ST_UiPanel;
	var title:ST_UiLabel;
	var buttonLayout:ST_UiLinearLayout;
	var playButton:ST_UiButton;
	var optionsButton:ST_UiButton;
	var i = 100;
	public function new(_game:ST_Game) 
	{
		super(_game);
		mainPanel = new ST_UiPanel(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		mainPanel.setBackgroundColour(0xFFFFFF, 1);
		
		while (i > 0) {
			var t = new ST_UiPanel((mainPanel.displayWidth / 100) * i, (mainPanel.displayHeight / 100) * i);
			mainPanel.addComponent(Std.string(i) , t, (mainPanel.displayWidth / 100) * i, (mainPanel.displayHeight / 100) * i);
			t.setBackgroundColour(grayscale(Std.random(0xFF)), 1);
			ST_UiLayoutUtil.center(mainPanel, [t]);
			i--;
		}

		title = new ST_UiLabel(525, 60);
		title.text.format.size = 50;
		title.text.setFont("font/PTC55F.ttf");
		title.text.text = "Face Space Ship Face";
		title.setBackgroundColour(0xFFFFFF, 0.9);
		
		buttonLayout = new ST_UiLinearLayout(0, 0, VERTICAL);
		
		playButton = new ST_UiButton(250, 40);
		playButton.label.format.size = 20;
		playButton.label.setFont("font/PTC55F.ttf");
		playButton.label.text = "Play";
		playButton.marginBottom = 30;
		
		trace(_game);
		playButton.setButtonClickCallback(function() {
			game.setCurrentState(new PlayState(_game));
		});
		
		optionsButton = new ST_UiButton(250,40);
		optionsButton.label.format.size = 20;
		optionsButton.label.setFont("font/PTC55F.ttf");
		optionsButton.label.text = "Options";
		
		buttonLayout.addChildren([playButton, optionsButton]);
		
		mainPanel.addComponent("title", title, 0, 30);
		mainPanel.addComponent("buttons", buttonLayout, 0, 0);
		
		ST_UiLayoutUtil.centerHorizontal(mainPanel, [title, buttonLayout]);
		ST_UiLayoutUtil.layoutBelow(title, [buttonLayout], 100);
		
		addChild(mainPanel);	

	}
	
	public override function update() {
		super.update();
		mainPanel.update();
		title.update();
		buttonLayout.update();
		playButton.update();
		optionsButton.update();
		for(j in 0...17){
			i--;
			if (i <= 1) {
				i = 100;
			}
			mainPanel.components.get(Std.string(i)).setBackgroundColour(grayscale(Std.random(0xFF)) , 1);
		}
	}
	
	private function grayscale ( tint:Int):Int{
		if (tint < 0) { tint = 0; }
		if (tint > 255) { tint = 255; }
		return (tint << 16) | (tint << 8) | tint;
	}

	public override function draw() {
		super.draw();
		mainPanel.draw();
		title.draw();
		buttonLayout.draw();
		playButton.draw();
		optionsButton.draw();
	}
	
}