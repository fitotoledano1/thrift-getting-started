/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import Foundation
import Thrift

func main() {
    do {
        // Create socket transport
        let transport = try TSocketTransport(hostname: "localhost", port: 9090)
        
        // Create binary protocol
        let thriftProtocol = TBinaryProtocol(on: transport)
        
        // Create client
        let client = CalculatorClient(inProtocol: thriftProtocol, outProtocol: thriftProtocol)
        
        // Open connection
        try transport.open()
        
        print("Connected to server!")
        
        // Test ping
        print("ping()")
        try client.ping()
        
        // Test add
        print("add(1, 1)")
        let sum = try client.add(num1: 1, num2: 1)
        print("1 + 1 = \(sum)")
        
        // Test calculate with different operations
        let work1 = Work(num1: 15, num2: 10, op: .subtract)
        print("calculate(1, {subtract, 15, 10})")
        let diff = try client.calculate(logid: 1, w: work1)
        print("15 - 10 = \(diff)")
        
        let work2 = Work(num1: 15, num2: 10, op: .multiply)
        print("calculate(2, {multiply, 15, 10})")
        let prod = try client.calculate(logid: 2, w: work2)
        print("15 * 10 = \(prod)")
        
        // Test getting a struct
        print("getStruct(1)")
        let struct1 = try client.getStruct(key: 1)
        print("Retrieved struct: key=\(struct1.key), value=\(struct1.value)")
        
        // Test division
        let work3 = Work(num1: 15, num2: 3, op: .divide)
        print("calculate(3, {divide, 15, 3})")
        let quot = try client.calculate(logid: 3, w: work3)
        print("15 / 3 = \(quot)")
        
        // Test division by zero (should throw exception)
        do {
            let work4 = Work(num1: 15, num2: 0, op: .divide)
            print("calculate(4, {divide, 15, 0})")
            let _ = try client.calculate(logid: 4, w: work4)
        } catch let error as InvalidOperation {
            print("Caught InvalidOperation: \(error.why)")
        }
        
        // Test zip (oneway)
        print("zip()")
        try client.zip()
        
        print("All tests completed successfully!")
        
        // Close connection
        transport.close()
        
    } catch {
        print("Error: \(error)")
    }
}

// Run the main function
main() 