#import "AnyPromise+Private.h"

AnyPromise *PMKRace(NSArray *promises) {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        for (AnyPromise *promise in promises) {
            [promise __pipe:resolve];
        }
    }];
}

/**
 Waits for one promise to fulfill

 @note If there are no fulfilled promises, the returned promise is rejected with `PMKNoWinnerError`.
 @param promises The promises to fulfill.
 @return The promise that was fulfilled first.
*/
AnyPromise *PMKRaceFulfilled(NSArray *promises) {
    __block int32_t countdown = (int32_t)[promises count];

    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        for (__strong AnyPromise* promise in promises) {
            [promise __pipe:^(id value) {
                if (IsError(value)) {
                    if (OSAtomicDecrement32(&countdown) == 0) {
                        id err = [NSError errorWithDomain:PMKErrorDomain code:PMKNoWinnerError userInfo:@{NSLocalizedDescriptionKey: @"PMKRaceFulfilled(nil)"}];
                        resolve(err);
                    }
                } else {
                    resolve(value);
                }
            }];
        }
    }];
}
