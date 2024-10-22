//
//  ServersViewModel_tests.swift
//  TestioTests
//
//  Created by Arturas Krivenkis on 18/10/2024.
//

import XCTest
@testable import Testio

final class ServersViewModel_tests: XCTestCase {

    var viewModel: ServersViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ServersViewModel(serversService: ServerService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_SeversViewModel_fetchServers_shouldGetData() async {
        //Given
        AppManager.token = "f9731b590611a5a9377fbd02f247fcdf"
        //When
        let expectation = XCTestExpectation()

        Task {
            await viewModel?.fetchServers()
            expectation.fulfill()
        }
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertEqual(viewModel?.serverList.isEmpty, false)
    }

    func test_SeversViewModel_fetchServers_shouldFail() async {
        //Given
        AppManager.token = nil
        //When
        let expectation = XCTestExpectation()

        Task {
            await viewModel?.fetchServers()
            expectation.fulfill()
        }
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertEqual(viewModel?.serverList.isEmpty, true)
    }

    func test_SeversViewModel_logoutUser_shouldRemoveData() async {
        //Given
        AppManager.token = "f9731b590611a5a9377fbd02f247fcdf"
        viewModel?.serverList = mockServerList()
        //When
        let expectation = XCTestExpectation()

        await MainActor.run {
            viewModel?.logoutUser()
            expectation.fulfill()
        }
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertEqual(viewModel?.serverList.isEmpty, true)
        XCTAssertNil(AppManager.token)
    }

    func test_ServersViewModel_sortServers_byAlphabet() {
        // Given
        viewModel?.serverList = mockServerList()
        // When
        viewModel?.sortServers(by: .alphabet)
        // Then
        XCTAssertEqual(viewModel?.serverList.isEmpty, false)
        XCTAssertEqual(viewModel?.serverList.first?.name, "ABS")
    }

    func test_ServersViewModel_sortServers_byDistance() {
        // Given
        viewModel?.serverList = mockServerList()
        // When
        viewModel?.sortServers(by: .byDistance)
        // Then
        XCTAssertEqual(viewModel?.serverList.isEmpty, false)
        XCTAssertEqual(viewModel?.serverList.first?.distance, 11)
    }

    private func mockServerList() -> [Server] {
        return [Server(name: "BSA", distance: 123),
                Server(name: "ABS", distance: 11),
                Server(name: "CBA", distance: 135)]
    }
}
