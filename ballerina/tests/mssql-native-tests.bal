// // Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
// //
// // WSO2 LLC. licenses this file to you under the Apache License,
// // Version 2.0 (the "License"); you may not use this file except
// // in compliance with the License.
// // You may obtain a copy of the License at
// //
// // http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing,
// // software distributed under the License is distributed on an
// // "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// // KIND, either express or implied.  See the License for the
// // specific language governing permissions and limitations
// // under the License.

// import ballerina/test;
// import ballerina/persist;

// @test:Config {
//     groups: ["native", "mssql"],
//     dependsOn: [mssqlEmployeeRelationsTest, mssqlWorkspaceRelationsTest, mssqlBuildingRelationsTest, mssqlDepartmentRelationsTest]
// }
// function mssqlNativeExecuteTest() returns error? {
//     MSSQLRainierClient rainierClient = check new ();
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Employee`);
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Workspace`);
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Building`);
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Department`);

//     ExecutionResult executionResult = check rainierClient->executeNativeSQL(`
//         INSERT INTO Department (deptNo, deptName)
//         VALUES 
//             (${departmentNative1.deptNo}, ${departmentNative1.deptName}),
//             (${departmentNative2.deptNo}, ${departmentNative2.deptName}),
//             (${departmentNative3.deptNo}, ${departmentNative3.deptName})
//     `);
//     test:assertEquals(executionResult, {affectedRowCount: 3, lastInsertId: ()});

//     executionResult = check rainierClient->executeNativeSQL(`
//         INSERT INTO Building (buildingCode, city, state, country, postalCode, type)
//         VALUES 
//             (${buildingNative1.buildingCode}, ${buildingNative1.city}, ${buildingNative1.state}, ${buildingNative1.country}, ${buildingNative1.postalCode}, ${buildingNative1.'type}),
//             (${buildingNative2.buildingCode}, ${buildingNative2.city}, ${buildingNative2.state}, ${buildingNative2.country}, ${buildingNative2.postalCode}, ${buildingNative2.'type}),
//             (${buildingNative3.buildingCode}, ${buildingNative3.city}, ${buildingNative3.state}, ${buildingNative3.country}, ${buildingNative3.postalCode}, ${buildingNative3.'type})
//     `);
//     test:assertEquals(executionResult, {affectedRowCount: 3, lastInsertId: ()});

//     executionResult = check rainierClient->executeNativeSQL(`
//         INSERT INTO Workspace (workspaceId, workspaceType, locationBuildingCode)
//         VALUES 
//             (${workspaceNative1.workspaceId}, ${workspaceNative1.workspaceType}, ${workspaceNative1.locationBuildingCode}),
//             (${workspaceNative2.workspaceId}, ${workspaceNative2.workspaceType}, ${workspaceNative2.locationBuildingCode}),
//             (${workspaceNative3.workspaceId}, ${workspaceNative3.workspaceType}, ${workspaceNative3.locationBuildingCode})
//     `);
//     test:assertEquals(executionResult, {affectedRowCount: 3, lastInsertId: ()});

//     executionResult = check rainierClient->executeNativeSQL(`
//         INSERT INTO Employee (empNo, firstName, lastName, birthDate, gender, hireDate, departmentDeptNo, workspaceWorkspaceId)
//         VALUES 
//             (${employeeNative1.empNo}, ${employeeNative1.firstName}, ${employeeNative1.lastName}, ${employeeNative1.birthDate}, ${employeeNative1.gender}, ${employeeNative1.hireDate}, ${employeeNative1.departmentDeptNo}, ${employeeNative1.workspaceWorkspaceId}),
//             (${employeeNative2.empNo}, ${employeeNative2.firstName}, ${employeeNative2.lastName}, ${employeeNative2.birthDate}, ${employeeNative2.gender}, ${employeeNative2.hireDate}, ${employeeNative2.departmentDeptNo}, ${employeeNative2.workspaceWorkspaceId}),
//             (${employeeNative3.empNo}, ${employeeNative3.firstName}, ${employeeNative3.lastName}, ${employeeNative3.birthDate}, ${employeeNative3.gender}, ${employeeNative3.hireDate}, ${employeeNative3.departmentDeptNo}, ${employeeNative3.workspaceWorkspaceId})
//     `);
//     test:assertEquals(executionResult, {affectedRowCount: 3, lastInsertId: ()});

//     check rainierClient.close();
// }

// @test:Config {
//     groups: ["native", "mssql"],
//     dependsOn: [mssqlNativeExecuteTest]
// }
// function mssqlNativeExecuteTestNegative1() returns error? {
//     MSSQLRainierClient rainierClient = check new ();
//     ExecutionResult|persist:Error executionResult = rainierClient->executeNativeSQL(`
//         INSERT INTO Department (deptNo, deptName)
//         VALUES (${departmentNative1.deptNo}, ${departmentNative1.deptName})
//     `);

//     if executionResult is persist:Error {
//         test:assertTrue(executionResult.message().includes("Cannot insert duplicate key"));
//     } else {
//         test:assertFail("persist:Error expected.");
//     }

//     check rainierClient.close();
// }

// @test:Config {
//     groups: ["native", "mssql"],
//     dependsOn: [mssqlNativeExecuteTest]
// }
// function mssqlNativeExecuteTestNegative2() returns error? {
//     MSSQLRainierClient rainierClient = check new ();
//     ExecutionResult|persist:Error executionResult = rainierClient->executeNativeSQL(`
//         INSERT INTO Departments (deptNo, deptName)
//         VALUES (${departmentNative1.deptNo}, ${departmentNative1.deptName})
//     `);

//     if executionResult is persist:Error {
//         test:assertTrue(executionResult.message().includes("Invalid object name 'Departments'"));
//     } else {
//         test:assertFail("persist:Error expected.");
//     }

//     check rainierClient.close();
// }

// @test:Config {
//     groups: ["native", "mssql"],
//     dependsOn: [mssqlNativeExecuteTest]
// }
// function mssqlNativeQueryTest() returns error? {
//     MSSQLRainierClient rainierClient = check new ();
//     stream<Department, persist:Error?> departmentStream = rainierClient->queryNativeSQL(`SELECT * FROM Department`);
//     Department[] departments = check from Department department in departmentStream
//         select department;
//     check departmentStream.close();
//     test:assertEquals(departments, [departmentNative1, departmentNative2, departmentNative3]);

//     stream<Building, persist:Error?> buildingStream = rainierClient->queryNativeSQL(`SELECT * FROM Building`);
//     Building[] buildings = check from Building building in buildingStream
//         select building;
//     check buildingStream.close();
//     test:assertEquals(buildings, [buildingNative1, buildingNative2, buildingNative3]);

//     stream<Workspace, persist:Error?> workspaceStream = rainierClient->queryNativeSQL(`SELECT * FROM Workspace`);
//     Workspace[] workspaces = check from Workspace workspace in workspaceStream
//         select workspace;
//     check workspaceStream.close();
//     test:assertEquals(workspaces, [workspaceNative1, workspaceNative2, workspaceNative3]);

//     stream<Employee, persist:Error?> employeeStream = rainierClient->queryNativeSQL(`SELECT * FROM Employee`);
//     Employee[] employees = check from Employee employee in employeeStream
//         select employee;
//     check employeeStream.close();
//     test:assertEquals(employees, [employeeNative1, employeeNative2, employeeNative3]);

//     check rainierClient.close();
// }

// @test:Config {
//     groups: ["native", "mssql"],
//     dependsOn: [mssqlNativeExecuteTest]
// }
// function mssqlNativeQueryTestNegative() returns error? {
//     MSSQLRainierClient rainierClient = check new ();
//     stream<Department, persist:Error?> departmentStream = rainierClient->queryNativeSQL(`SELECT * FROM Departments`);
//     Department[]|persist:Error departments = from Department department in departmentStream
//         select department;
//     check departmentStream.close();

//     if departments is persist:Error {
//         test:assertTrue(departments.message().includes("Invalid object name 'Departments'"));
//     } else {
//         test:assertFail("persist:Error expected.");
//     }

//     check rainierClient.close();
// }

// @test:Config {
//     groups: ["native", "mssql"],
//     dependsOn: [mssqlNativeExecuteTest]
// }
// function mssqlNativeQueryComplexTest() returns error? {
//     MSSQLRainierClient rainierClient = check new ();
//     stream<EmployeeInfo, persist:Error?> employeeInfoStream = rainierClient->queryNativeSQL(`
//         SELECT 
//             firstName,
//             lastName,
//             department.deptName AS 'department.deptName',
//             workspace.workspaceId AS 'workspace.workspaceId',
//             workspace.workspaceType AS 'workspace.workspaceType',
//             workspace.locationBuildingCode AS 'workspace.locationBuildingCode'
//         FROM Employee
//         INNER JOIN 
//             Department department ON Employee.departmentDeptNo = department.deptNo
//         INNER JOIN
//             Workspace workspace ON Employee.workspaceWorkspaceId = workspace.workspaceId
//     `);
//     EmployeeInfo[] employees = check from EmployeeInfo employee in employeeInfoStream
//         select employee;
//     check employeeInfoStream.close();
//     test:assertEquals(employees, [employeeInfoNative1, employeeInfoNative2, employeeInfoNative3]);

//     check rainierClient.close();
// }

// @test:Config {
//     groups: ["transactions", "mssql", "native"],
//     dependsOn: [mssqlNativeExecuteTestNegative1, mssqlNativeQueryTest, mssqlNativeQueryTestNegative, mssqlNativeQueryComplexTest]
// }
// function mssqlNativeTransactionTest() returns error? {
//     MSSQLRainierClient rainierClient = check new ();
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Employee`);
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Workspace`);
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Building`);
//     _ = check rainierClient->executeNativeSQL(`DELETE FROM Department`);

//     transaction {
//         ExecutionResult executionResult = check rainierClient->executeNativeSQL(`
//         INSERT INTO Building (buildingCode, city, state, country, postalCode, type)
//         VALUES 
//             (${building31.buildingCode}, ${building31.city}, ${building31.state}, ${building31.country}, ${building31.postalCode}, ${building31.'type}),
//             (${building32.buildingCode}, ${building32.city}, ${building32.state}, ${building32.country}, ${building32.postalCode}, ${building32.'type})
//         `);
//         test:assertEquals(executionResult, {affectedRowCount: 2, lastInsertId: ()});

//         stream<Building, persist:Error?> buildingStream = rainierClient->queryNativeSQL(`SELECT * FROM Building`);
//         Building[] buildings = check from Building building in buildingStream
//             select building;
//         check buildingStream.close();
//         test:assertEquals(buildings, [building31, building32]);

//         executionResult = check rainierClient->executeNativeSQL(`
//         INSERT INTO Building (buildingCode, city, state, country, postalCode, type)
//         VALUES 
//             (${building31.buildingCode}, ${building31.city}, ${building31.state}, ${building31.country}, ${building31.postalCode}, ${building31.'type})
//         `);
//         check commit;
//     } on fail error e {
//         test:assertTrue(e is persist:Error, "persist:Error expected");
//     }

//     stream<Building, persist:Error?> buildingStream = rainierClient->queryNativeSQL(`SELECT * FROM Building`);
//     Building[] buildings = check from Building building in buildingStream
//         select building;
//     check buildingStream.close();
//     test:assertEquals(buildings, []);

//     check rainierClient.close();
// }

// @test:Config {
//     groups: ["transactions", "mssql", "native"],
//     dependsOn: [mssqlNativeExecuteTestNegative1, mssqlNativeQueryTest, mssqlNativeQueryTestNegative, mssqlNativeQueryComplexTest]
// }
// function mssqlNativeTransactionTest2() returns error? {
//     MSSQLRainierClient rainierClient = check new ();

//     ExecutionResult executionResult = check rainierClient->executeNativeSQL(`
//         INSERT INTO Building (buildingCode, city, state, country, postalCode, type)
//         VALUES 
//             (${building33.buildingCode}, ${building33.city}, ${building33.state}, ${building33.country}, ${building33.postalCode}, ${building33.'type})
//         `);
//     test:assertEquals(executionResult, {affectedRowCount: 1, lastInsertId: ()});

//     stream<Building, persist:Error?> buildingStream = rainierClient->queryNativeSQL(`SELECT * FROM Building WHERE buildingCode = ${building33.buildingCode}`);
//     Building[] buildings = check from Building building in buildingStream
//         select building;
//     check buildingStream.close();
//     test:assertEquals(buildings, [building33]);

//     transaction {
//         ExecutionResult executionResult2 = check rainierClient->executeNativeSQL(`
//             UPDATE Building
//             SET
//                 city = ${building33Updated.city},
//                 state = ${building33Updated.state},
//                 country = ${building33Updated.country}
//             WHERE buildingCode = ${building33.buildingCode}
//         `);
//         check commit;
//     }

//     stream<Building, persist:Error?> buildingStream3 = rainierClient->queryNativeSQL(`SELECT * FROM Building WHERE buildingCode = ${building33.buildingCode}`);
//     Building[] buildings3 = check from Building building in buildingStream3
//         select building;
//     check buildingStream3.close();
//     test:assertEquals(buildings3, [building33Updated]);

//     check rainierClient.close();
// }
