package stage;

import controller.LoginController;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

import java.io.IOException;

public class Login extends Pane {

    public Login(Stage stage) throws IOException {
        try {
            FXMLLoader fxmlloader = new FXMLLoader(getClass().getResource("../view/login.fxml"));
            this.getChildren().add(fxmlloader.load());
            ((LoginController)fxmlloader.getController()).setOldStage(stage);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}