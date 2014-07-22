
#import "OSSClient.h"

@implementation OSSMethodResult

- (OSSMethodResult *)initWithStatusCode:(NSInteger)statusCode
                                   data:(NSData *)data
                                headers:(NSDictionary *)headers
                                    url:(NSURL *)url
                                  error:(NSError *)error{
    if (self=[super init]) {
        [self setStatusCode:statusCode];
        [self setData:data];
        [self setHeaders:headers];
        [self setError:error];
        [self setUrl:url];
    }
    return self;
}

@end

@implementation OSSClient{
    NSURL *_bucketBaseUrl;
    OSSBucketPermission _bucketPermission;
    NSString *(^_signCalculator)(OSSMethod method,NSString *ossFilePath,NSMutableDictionary *options);
}

//---------------------------
//public
//---------------------------

- (OSSClient *)initWithBucketBaseUrl:(NSURL *)bucketBaseUrl
                    bucketPermission:(OSSBucketPermission)bucketPermission
                      signCalculator:(NSString *(^)(OSSMethod method,NSString *ossFilePath,NSMutableDictionary *options)) signCalculator{
    if ((self=[super init])) {
        _bucketBaseUrl=bucketBaseUrl;
        _bucketPermission=bucketPermission;
        _signCalculator=signCalculator  ;
    }
    return self;
}

- (OSSMethodResult *)putFile:(NSString *)ossFilePath
               localFilePath:(NSString *)localFilePath
                     options:(NSMutableDictionary *)options{
    NSData *data=[NSData dataWithContentsOfFile:localFilePath];
    return [self putFile:ossFilePath data:data options:options];
}

- (OSSMethodResult *)putFile:(NSString *)ossFilePath
                        data:(NSData *)data
                     options:(NSMutableDictionary *)options{
    return [self ossFileMethodInvoke:PUT ossFilePath:ossFilePath data:data options:options];
}

- (OSSMethodResult *)getFile:(NSString *)ossFilePath
                     options:(NSMutableDictionary *)options{
    return [self ossFileMethodInvoke:GET ossFilePath:ossFilePath data:nil options:options];
}

- (OSSMethodResult *)deleteFile:(NSString *)ossFilePath{
    return [self ossFileMethodInvoke:DELETE ossFilePath:ossFilePath data:nil options:nil];
}

- (OSSMethodResult *)headFile:(NSString *)ossFilePath
                      options:(NSMutableDictionary *)options{
    return [self ossFileMethodInvoke:HEAD ossFilePath:ossFilePath data:nil options:options];
}

//---------------------------
//private
//---------------------------

- (OSSMethodResult *)ossFileMethodInvoke:(OSSMethod)method
                             ossFilePath:(NSString *)ossFilePath
                                    data:(NSData *)data
                                 options:(NSMutableDictionary *)options{
    if (options==nil) {
        options=[[NSMutableDictionary alloc] init];
    }
    
    //只有当对私有bucket进行读写和对私有写的bucket的进行写的时候才需要签名校验
    if (_bucketPermission==PRIVATE || (_bucketPermission==PRIVATE_W && method==PUT)) {
        [options setValue:[self gmtDateStrigOfNow] forKey:@"Date"];
        [options setValue:_signCalculator(method,ossFilePath,options) forKey:@"Authorization"];
    }
    
    //构造OSS文件的访问URL
    //NSURL *url=[NSURL URLWithString: ossFilePath relativeToURL: _bucketBaseUrl];
    //NSLog(@"%@",url);
    NSURL *url=[NSURL URLWithString:@"http://oss-cn-beijing.aliyuncs.com/fashion-test/image/test.txt"];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL: url];
    [request setAllHTTPHeaderFields:options];
    [request setHTTPMethod:OSSMethodLiterals[method]];
    [request setHTTPBody:[NSMutableData dataWithData:data]];
    
    NSHTTPURLResponse *response=nil;
    NSError *error=nil;
    NSData *responseData= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return [[OSSMethodResult alloc] initWithStatusCode:response.statusCode
                                                  data:responseData
                                               headers:response.allHeaderFields
                                                   url:url
                                                 error:error];
}

- (NSString *)gmtDateStrigOfNow{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    df.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
    //df.dateFormat = @"EE, dd MM yyyy HH:mm:ss GMT";
    return [df stringFromDate:[NSDate date]];
}

@end
