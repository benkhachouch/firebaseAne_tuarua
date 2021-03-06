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

#import "FreMacros.h"
#import "PerformanceANE_oc.h"

#define FRE_OBJC_BRIDGE TRFIRPF_FlashRuntimeExtensionsBridge // use unique prefix throughout to prevent clashes with other ANEs
@interface FRE_OBJC_BRIDGE : NSObject<FreSwiftBridgeProtocol>
@end
@implementation FRE_OBJC_BRIDGE {
}
FRE_OBJC_BRIDGE_FUNCS
@end

@implementation PerformanceANE_LIB
SWIFT_DECL(TRFIRPF) // use unique prefix throughout to prevent clashes with other ANEs
CONTEXT_INIT(TRFIRPF) {
    SWIFT_INITS(TRFIRPF)
    
    /**************************************************************************/
    /******* MAKE SURE TO ADD FUNCTIONS HERE THE SAME AS SWIFT CONTROLLER *****/
    /**************************************************************************/
    
    static FRENamedFunction extensionFunctions[] =
    {
         MAP_FUNCTION(TRFIRPF, init)
        ,MAP_FUNCTION(TRFIRPF, startTrace)
        ,MAP_FUNCTION(TRFIRPF, stopTrace)
        ,MAP_FUNCTION(TRFIRPF, incrementCounter)
        ,MAP_FUNCTION(TRFIRPF, setIsDataCollectionEnabled)
        ,MAP_FUNCTION(TRFIRPF, setIsInstrumentationEnabled)
    };
    
    /**************************************************************************/
    /**************************************************************************/
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRFIRPF) {
    [TRFIRPF_swft dispose];
    TRFIRPF_swft = nil;
    TRFIRPF_freBridge = nil;
    TRFIRPF_swftBridge = nil;
    TRFIRPF_funcArray = nil;
}
EXTENSION_INIT(TRFIRPF)
EXTENSION_FIN(TRFIRPF)
@end
