package views.examples {
import com.tuarua.firebase.AuthANE;
import com.tuarua.firebase.auth.AuthError;
import com.tuarua.firebase.auth.FirebaseUser;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.Align;

import views.SimpleButton;

public class AuthExample extends Sprite implements IExample {
    private var stageWidth:Number;
    private var isInited:Boolean;
    private var auth:AuthANE;
    private var btnSignInAnon:SimpleButton = new SimpleButton("Login Anonymously");
    private var btnSignInEmailPassword:SimpleButton = new SimpleButton("Sign in w/ Email + Password");
    private var btnSignOut:SimpleButton = new SimpleButton("Sign out");
    private var btnUpdateProfile:SimpleButton = new SimpleButton("Update Profile");
    private var btnCreateNewUser:SimpleButton = new SimpleButton("Create New User");
    private var statusLabel:TextField;

    public function AuthExample(stageWidth:Number) {
        super();
        this.stageWidth = stageWidth;
        initMenu();
    }

    public function initANE():void {
        if (isInited) return;
        auth = AuthANE.auth;
        isInited = true;
    }

    private function initMenu():void {
        btnUpdateProfile.x = btnCreateNewUser.x = btnSignInAnon.x = btnSignInEmailPassword.x = btnSignOut.x = (stageWidth - 200) * 0.5;
        btnSignInAnon.y = StarlingRoot.GAP;
        btnSignInAnon.addEventListener(TouchEvent.TOUCH, onSignInAnonClick);
        addChild(btnSignInAnon);

        btnSignInEmailPassword.y = btnSignInAnon.y + StarlingRoot.GAP;
        btnSignInEmailPassword.addEventListener(TouchEvent.TOUCH, onSignInEmailPasswordClick);
        addChild(btnSignInEmailPassword);

        btnSignOut.y = btnSignInEmailPassword.y + StarlingRoot.GAP;
        btnSignOut.addEventListener(TouchEvent.TOUCH, onSignOutClick);
        addChild(btnSignOut);

        btnCreateNewUser.y = btnSignOut.y + StarlingRoot.GAP;
        btnCreateNewUser.addEventListener(TouchEvent.TOUCH, onCreateNewUserClick);
        addChild(btnCreateNewUser);

        btnUpdateProfile.y = btnCreateNewUser.y + StarlingRoot.GAP;
        btnUpdateProfile.addEventListener(TouchEvent.TOUCH, onUpdateProfileClick);
        addChild(btnUpdateProfile);

        statusLabel = new TextField(stageWidth, 1400, "");
        statusLabel.format.setTo(Fonts.NAME, 13, 0x222222, Align.CENTER, Align.TOP);
        statusLabel.touchable = false;
        statusLabel.y = btnUpdateProfile.y + (StarlingRoot.GAP * 1.25);
        addChild(statusLabel);
    }

    private function onCreateNewUserClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnCreateNewUser);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            auth.createUserWithEmailAndPassword("test@test.com", "password", onNewUser);
            statusLabel.text = "Creating new user";
        }
    }

    private function onUpdateProfileClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnUpdateProfile);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            auth.currentUser.updateProfile("FireAceOfBase",
                    "https://cdn0.iconfinder.com/data/icons/user-pictures/100/matureman1-512.png",
                    function (error:AuthError):void {
                        if (error) {
                            statusLabel.text = "onSignedIn error: " + error.errorID + " : " + error.message;
                            return;
                        }
                        statusLabel.text = "Profile Updated";
                        var user:FirebaseUser = auth.currentUser;
                        statusLabel.text = "Signed In" + "\n" +
                                "isAnonymous: " + user.isAnonymous + "\n" +
                                "displayName: " + user.displayName + "\n" +
                                "email: " + user.email + "\n" +
                                "isEmailVerified: " + user.isEmailVerified + "\n" +
                                "photoUrl: " + user.photoUrl + "\n";
                    });
            statusLabel.text = "Updating Profile";
        }
    }

    private function onNewUser(error:AuthError):void {
        if (error) {
            statusLabel.text = "onSignedIn error: " + error.errorID + " : " + error.message;
            return;
        }
        statusLabel.text = "New user created";
    }

    private function onSignOutClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnSignOut);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            auth.signOut();
            statusLabel.text = "Signed Out";
        }
    }

    private function onSignInEmailPasswordClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnSignInEmailPassword);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            auth.signInWithEmailAndPassword("test@test.com", "passwor", onSignedIn);
        }
    }

    private function onSignInAnonClick(event:TouchEvent):void {
        var touch:Touch = event.getTouch(btnSignInAnon);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            auth.signInAnonymously();
        }
    }

    private function onSignedIn(error:AuthError):void {
        if (error) {
            statusLabel.text = "onSignedIn error: " + error.errorID + " : " + error.message;
            return;
        }
        var user:FirebaseUser = auth.currentUser;
        statusLabel.text = "Signed In" + "\n" +
                "isAnonymous: " + user.isAnonymous + "\n" +
                "displayName: " + user.displayName + "\n" +
                "email: " + user.email + "\n" +
                "isEmailVerified: " + user.isEmailVerified + "\n" +
                "photoUrl: " + user.photoUrl + "\n";
        user.getIdToken(true, function (token:String):void {
            statusLabel.text += "token: " + token.substr(0,10) + "...";
        });
    }

}
}
