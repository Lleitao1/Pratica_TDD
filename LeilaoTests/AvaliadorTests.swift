//
//  AvaliadorTests.swift
//  LeilaoUITests
//
//  Created by Lucas Abdel Leitao on 30/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {
    
    var leiloeiro:Avaliador!
    private var joao:Usuario!
    private var maria:Usuario!
    private var jose:Usuario!

    override func setUp() {
        super.setUp()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        leiloeiro = Avaliador()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEntenderLancesOrdemCrescente() {
        // Cenario
        
        let leilao = CriadorDeLeilao().para("Playstation 4")
            .lance(joao,250.0)
            .lance(maria,300.0)
            .lance(jose,400.0).constroiLeilao()
        
        // Acao
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testEntenderLeilaoComLanceUnico() {
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testeEncontrarTresMaioresLances(){
        let leilao = CriadorDeLeilao().para("Playstation 4")
                                      .lance(joao,300.0)
                                      .lance(maria,400.0)
                                      .lance(joao,500.0)
                                      .lance(maria,600.0).constroiLeilao()
        
        
        try? leiloeiro.avalia(leilao: leilao)
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(600.0, listaLances[0].valor)
        XCTAssertEqual(500.0, listaLances[1].valor)
        XCTAssertEqual(400.0, listaLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemLance(){
        let leilao = CriadorDeLeilao().para("Playstation 4").constroiLeilao()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Nao e possivel avaliar um leilao sem lances") { (error) in
            print(error.localizedDescription)
        }
    }
}
