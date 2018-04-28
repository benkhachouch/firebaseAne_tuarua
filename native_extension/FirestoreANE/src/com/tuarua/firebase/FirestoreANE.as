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
    private static const INIT_ERROR_MESSAGE:String = "FirestoreANE... use .firestore";

    public function FirestoreANE() {
        if (_firestore) {
            throw new Error(INIT_ERROR_MESSAGE);
        }
        if (FirestoreANEContext.context) {
            var theRet:* = FirestoreANEContext.context.call("init", _loggingEnabled, _settings);
            if (theRet is ANEError) {
                throw theRet as ANEError;
            }
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
        if (theRet is ANEError) {
            throw theRet as ANEError;
        }
        return new WriteBatch();
    }

    public function get settings():FirestoreSettings {
        if (!_firestore) throw new Error(INIT_ERROR_MESSAGE);
        var theRet:* = FirestoreANEContext.context.call("getFirestoreSettings");
        if (theRet is ANEError) {
            throw theRet as ANEError;
        }
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

    public static function dispose():void {
        if (FirestoreANEContext.context) {
            FirestoreANEContext.dispose();
        }
    }


    public static function set settings(value:FirestoreSettings):void {
        _settings = value;
    }
}
}
