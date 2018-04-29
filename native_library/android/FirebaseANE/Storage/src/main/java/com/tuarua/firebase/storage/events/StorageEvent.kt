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

package com.tuarua.firebase.storage.events

class StorageEvent(val eventId: String, val data: Map<String, Any>? = null, val error: Map<String, Any>? = null) {
    companion object {
        const val GET_DOWNLOAD_URL: String = "StorageEvent.GetDownloadUrl"
        const val GET_METADATA: String = "StorageEvent.GetMetadata"
        const val UPDATE_METADATA: String = "StorageEvent.UpdateMetadata"
        const val TASK_COMPLETE: String = "StorageEvent.TaskComplete"
        const val DELETED: String = "StorageEvent.Deleted"
    }
}

