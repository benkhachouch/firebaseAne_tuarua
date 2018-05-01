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

package com.tuarua.firebase {
import com.tuarua.firebase.firestore.CollectionReference;
import com.tuarua.firebase.firestore.DocumentReference;
import com.tuarua.firebase.firestore.FirestoreSettings;
import com.tuarua.firebase.firestore.WriteBatch;
import com.tuarua.fre.ANEError;

import flash.events.EventDispatcher;

public final class FirestoreANE extends EventDispatcher {
    private static var _firestore:FirestoreANE;
    private static var _loggingEnabled:Boolean = false;
    private static var _settings:FirestoreSettings = null;
    public static const INIT_ERROR_MESSAGE:String = "FirestoreANE not initialised... use .firestore";

    public function FirestoreANE() {
        if (_firestore) throw new Error(INIT_ERROR_MESSAGE);
        if (FirestoreANEContext.context) {
            var theRet:* = FirestoreANEContext.context.call("init", _loggingEnabled, _settings);
            if (theRet is ANEError) throw theRet as ANEError;
        }
        _firestore = this;
    }

    public static function get firestore():FirestoreANE {
        if (!_firestore) {
            new FirestoreANE();
        }
        return _firestore;
    }

    public function batch():WriteBatch {
        if (!_firestore) throw new Error(INIT_ERROR_MESSAGE);
        var theRet:* = FirestoreANEContext.context.call("startBatch");
        if (theRet is ANEError) throw theRet as ANEError;
        return new WriteBatch();
    }

    public function get settings():FirestoreSettings {
        if (!_firestore) throw new Error(INIT_ERROR_MESSAGE);
        var theRet:* = FirestoreANEContext.context.call("getFirestoreSettings");
        if (theRet is ANEError) throw theRet as ANEError;
        return theRet as FirestoreSettings;
    }

    public function collection(collectionPath:String):CollectionReference {
        if (!_firestore) throw new Error(INIT_ERROR_MESSAGE);
        return new CollectionReference(collectionPath);
    }

    public function document(documentPath:String = null):DocumentReference {
        if (!_firestore) throw new Error(INIT_ERROR_MESSAGE);
        return new DocumentReference(documentPath);
    }

    public static function get loggingEnabled():Boolean {
        return _loggingEnabled;
    }

    public static function set loggingEnabled(value:Boolean):void {
        _loggingEnabled = value;
    }

    public function enableNetwork(listener:Function = null):void {
        if (!_firestore) throw new Error(INIT_ERROR_MESSAGE);
        var eventId:String;
        if (listener) {
            eventId = FirestoreANEContext.context.call("createGUID") as String;
            FirestoreANEContext.closures[eventId] = listener;
        }
        var theRet:* = FirestoreANEContext.context.call("enableNetwork", eventId);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    public function disableNetwork(listener:Function = null):void {
        if (!_firestore) throw new Error(INIT_ERROR_MESSAGE);
        var eventId:String;
        if (listener) {
            eventId = FirestoreANEContext.context.call("createGUID") as String;
            FirestoreANEContext.closures[eventId] = listener;
        }
        var theRet:* = FirestoreANEContext.context.call("disableNetwork", eventId);
        if (theRet is ANEError) throw theRet as ANEError;
    }

    public static function set settings(value:FirestoreSettings):void {
        _settings = value;
    }

    public static function dispose():void {
        if (FirestoreANEContext.context) {
            FirestoreANEContext.dispose();
        }
    }
}
}
