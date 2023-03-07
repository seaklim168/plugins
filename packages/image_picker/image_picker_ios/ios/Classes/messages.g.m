// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v3.0.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "messages.g.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
      @"code" : (error.code ? error.code : [NSNull null]),
      @"message" : (error.message ? error.message : [NSNull null]),
      @"details" : (error.details ? error.details : [NSNull null]),
    };
  }
  return @{
    @"result" : (result ? result : [NSNull null]),
    @"error" : errorDict,
  };
}
static id GetNullableObject(NSDictionary *dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface FLTMaxSize ()
+ (FLTMaxSize *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface FLTSourceSpecification ()
+ (FLTSourceSpecification *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation FLTMaxSize
+ (instancetype)makeWithWidth:(nullable NSNumber *)width height:(nullable NSNumber *)height {
  FLTMaxSize *pigeonResult = [[FLTMaxSize alloc] init];
  pigeonResult.width = width;
  pigeonResult.height = height;
  return pigeonResult;
}
+ (FLTMaxSize *)fromMap:(NSDictionary *)dict {
  FLTMaxSize *pigeonResult = [[FLTMaxSize alloc] init];
  pigeonResult.width = GetNullableObject(dict, @"width");
  pigeonResult.height = GetNullableObject(dict, @"height");
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return [NSDictionary
      dictionaryWithObjectsAndKeys:(self.width ? self.width : [NSNull null]), @"width",
                                   (self.height ? self.height : [NSNull null]), @"height", nil];
}
@end

@implementation FLTSourceSpecification
+ (instancetype)makeWithType:(FLTSourceType)type camera:(FLTSourceCamera)camera {
  FLTSourceSpecification *pigeonResult = [[FLTSourceSpecification alloc] init];
  pigeonResult.type = type;
  pigeonResult.camera = camera;
  return pigeonResult;
}
+ (FLTSourceSpecification *)fromMap:(NSDictionary *)dict {
  FLTSourceSpecification *pigeonResult = [[FLTSourceSpecification alloc] init];
  pigeonResult.type = [GetNullableObject(dict, @"type") integerValue];
  pigeonResult.camera = [GetNullableObject(dict, @"camera") integerValue];
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return [NSDictionary
      dictionaryWithObjectsAndKeys:@(self.type), @"type", @(self.camera), @"camera", nil];
}
@end

@interface FLTImagePickerApiCodecReader : FlutterStandardReader
@end
@implementation FLTImagePickerApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128:
      return [FLTMaxSize fromMap:[self readValue]];

    case 129:
      return [FLTSourceSpecification fromMap:[self readValue]];

    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FLTImagePickerApiCodecWriter : FlutterStandardWriter
@end
@implementation FLTImagePickerApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FLTMaxSize class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else if ([value isKindOfClass:[FLTSourceSpecification class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FLTImagePickerApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTImagePickerApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTImagePickerApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTImagePickerApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTImagePickerApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTImagePickerApiCodecReaderWriter *readerWriter =
        [[FLTImagePickerApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void FLTImagePickerApiSetup(id<FlutterBinaryMessenger> binaryMessenger,
                            NSObject<FLTImagePickerApi> *api) {
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.ImagePickerApi.pickImage"
        binaryMessenger:binaryMessenger
                  codec:FLTImagePickerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector
                 (pickImageWithSource:maxSize:quality:fullMetadata:withType:completion:)],
                @"FLTImagePickerApi api (%@) doesn't respond to "
                @"@selector(pickImageWithSource:maxSize:quality:fullMetadata:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTSourceSpecification *arg_source = GetNullableObjectAtIndex(args, 0);
        FLTMaxSize *arg_maxSize = GetNullableObjectAtIndex(args, 1);
        NSNumber *arg_imageQuality = GetNullableObjectAtIndex(args, 2);
        NSNumber *arg_requestFullMetadata = GetNullableObjectAtIndex(args, 3);
          NSString *type = GetNullableObjectAtIndex(args, 4) ?: @"image";
        [api pickImageWithSource:arg_source
                         maxSize:arg_maxSize
                         quality:arg_imageQuality
                    fullMetadata:arg_requestFullMetadata
                        withType: type
                      completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
                        callback(wrapResult(output, error));
                      }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.ImagePickerApi.pickMultiImage"
        binaryMessenger:binaryMessenger
                  codec:FLTImagePickerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector
                 (pickMultiImageWithMaxSize:quality:fullMetadata:withType:completion:)],
                @"FLTImagePickerApi api (%@) doesn't respond to "
                @"@selector(pickMultiImageWithMaxSize:quality:fullMetadata:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTMaxSize *arg_maxSize = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_imageQuality = GetNullableObjectAtIndex(args, 1);
        NSNumber *arg_requestFullMetadata = GetNullableObjectAtIndex(args, 2);
          NSString *type = GetNullableObjectAtIndex(args, 3) ?: @"image";
        [api pickMultiImageWithMaxSize:arg_maxSize
                               quality:arg_imageQuality
                          fullMetadata:arg_requestFullMetadata
                              withType:type
                            completion:^(NSArray<NSString *> *_Nullable output,
                                         FlutterError *_Nullable error) {
                              callback(wrapResult(output, error));
                            }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.ImagePickerApi.pickVideo"
        binaryMessenger:binaryMessenger
                  codec:FLTImagePickerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(pickVideoWithSource:maxDuration:completion:)],
                @"FLTImagePickerApi api (%@) doesn't respond to "
                @"@selector(pickVideoWithSource:maxDuration:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTSourceSpecification *arg_source = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_maxDurationSeconds = GetNullableObjectAtIndex(args, 1);
        [api pickVideoWithSource:arg_source
                     maxDuration:arg_maxDurationSeconds
                      completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
                        callback(wrapResult(output, error));
                      }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
