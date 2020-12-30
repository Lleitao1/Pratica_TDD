//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeveReceberLance(){
        let leilao = Leilao(descricao: "Macbook pro 15")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let jobs = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(jobs, 2000.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances(){
        let leilao = Leilao(descricao: "Macbook pro 15")
        let jobs = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(jobs, 2000.0))
        
        let gates = Usuario(nome: "Bill Gates")
        leilao.propoe(lance: Lance(gates, 3000.0))
        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
        XCTAssertEqual(3000.0, leilao.lances?[1].valor)
    }
    
    func testeDeveIgnorarDoisLancesSeguidosMesmoUsuario(){
        let leilao = Leilao(descricao: "Macbook pro 15")
        let jobs = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(jobs, 2000.0))
        leilao.propoe(lance: Lance(jobs, 3000.0))   
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveIgnorarMaisQueCincoLancesMesmoUsuario(){
        let leilao = Leilao(descricao: "Macbook pro 15")
        let jobs = Usuario(nome: "Steve Jobs")
        let gates = Usuario(nome: "Bill Gates")
        
        leilao.propoe(lance: Lance(jobs, 1000.0))
        leilao.propoe(lance: Lance(gates, 2000.0))
        
        leilao.propoe(lance: Lance(jobs, 3000.0))
        leilao.propoe(lance: Lance(gates, 4000.0))
        
        leilao.propoe(lance: Lance(jobs, 5000.0))
        leilao.propoe(lance: Lance(gates, 6000.0))
        
        leilao.propoe(lance: Lance(jobs, 7000.0))
        leilao.propoe(lance: Lance(gates, 8000.0))
        
        leilao.propoe(lance: Lance(jobs, 9000.0))
        leilao.propoe(lance: Lance(gates, 10000.0))
        
        //ignorar proximos lances jobs ou gates
        leilao.propoe(lance: Lance(jobs, 11000.0))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(10000.0, leilao.lances?.last?.valor)
    }
}
