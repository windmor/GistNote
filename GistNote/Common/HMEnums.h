
//
//  HMEnums.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#ifndef GistNotes_HMEnums_h
#define GistNotes_HMEnums_h

//=================
// gists tbl type
//=================

typedef NS_ENUM(NSInteger, kGistTblType) {
    kGistTblTypeAll,
    kGistTblTypeGists,
    kGistTblTypeNotes
};


//====================================================================================
// For all projects
//====================================================================================

//==============
// Log level
//==============

typedef NS_ENUM(NSInteger, kLogLevel) {
    kLogLevelEmergency,
    kLogLevelAlert,
    kLogLevelCritical,
    kLogLevelError,
    kLogLevelWarning,
    kLogLevelNotice,
    kLogLevelInfo,
    kLogLevelDebug
};

//==============
// Module's ids
//==============

typedef NS_ENUM(NSInteger, kModuleCode) {
    kModuleServerAPI,
    kModuleStorageAPI,
    kModuleApp,
};

//=================
// exception code
//=================

typedef NS_ENUM(NSInteger, kExcCode) {
    EXCEPTION_INTERNAL,
    EXCEPTION_VIRT_FUNTION_CALLED,
    EXCEPTION_GUI,
    EXCEPTION_NETWORK,
    EXCEPTION_BAD_RESPONSE
};

//==============
// Error codes
//==============

typedef NS_ENUM(NSUInteger, kErrorCode) {
    // gui errrs
    kErrorUIElementWasNotFound,
    // network errors
    kErrorNetwork,
    // bad response errors
    kErrorBadResponse,
    // internal errors
    kErrorVirtualFunctionCall,
    kErrorUnexpected
};

//==================
// Error msg codes
//==================

typedef NS_ENUM(NSInteger, kErrorMsgCode) {
    MSG_UIElementWasNotFound,
    MSG_ErrorVirtualFunctionCall,
    MSG_ErrorUnexpected,
    MSG_ErrorNetwork,
    MSG_ErrorBadResponse,
};

//=============================
// Error msg codes for users
//=============================

typedef NS_ENUM(NSInteger, kErrorUMsgCode) {
    UMSG_EmergencyError,
    UMSG_Warning,
    UMSG_NetworkError,
    UMSG_BadResponse
};

#endif
