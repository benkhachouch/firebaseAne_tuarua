/*
 *  Copyright 2018 Tua Rua Ltd.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package com.tuarua.google {
import com.tuarua.fre.ANEError;

import flash.events.EventDispatcher;

public final class GoogleSignInANE extends EventDispatcher {
    private static var _googleSignIn:GoogleSignInANE;

    /** @private */
    public function GoogleSignInANE() {
        if (GoogleSignInANEContext.context) {
            var theRet:* = GoogleSignInANEContext.context.call("init");
            if (theRet is ANEError) throw theRet as ANEError;
        }
        _googleSignIn = this;
    }

    /** The ANE instance. */
    public static function get googleSignIn():GoogleSignInANE {
        if (!_googleSignIn) {
            new GoogleSignInANE();
        }
        return _googleSignIn;
    }

    /** Starts the sign-in process. Note that this method should not be called when the app is starting up.*/
    public function signIn():void {
        GoogleSignInANEContext.validate();
        var theRet:* = GoogleSignInANEContext.context.call("signIn");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Attempts to sign in a previously authenticated user without interaction. */
    public function signInSilently():void {
        GoogleSignInANEContext.validate();
        var theRet:* = GoogleSignInANEContext.context.call("signInSilently");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Signs out the current signed-in user if any. It also clears the account previously selected by the user
     * and a future sign in attempt will require the user pick an account again. */
    public function signOut():void {
        GoogleSignInANEContext.validate();
        var theRet:* = GoogleSignInANEContext.context.call("signOut");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Revokes access given to the current application. Future sign-in attempts will require the user to re-consent
     * to all requested scopes. Applications are required to provide users that are signed in with Google the
     * ability to disconnect their Google account from the app. If the user deletes their account, you must
     * delete the information that your app obtained from the Google APIs. */
    public function revokeAccess():void {
        GoogleSignInANEContext.validate();
        var theRet:* = GoogleSignInANEContext.context.call("revokeAccess");
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** */
    public function handle(url:String, sourceApplication:String):void {
        GoogleSignInANEContext.validate();
        var theRet:* = GoogleSignInANEContext.context.call("handle", url, sourceApplication);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    /** Disposes the ANE */
    public static function dispose():void {
        if (GoogleSignInANEContext.context) {
            GoogleSignInANEContext.dispose();
        }
    }

}
}
