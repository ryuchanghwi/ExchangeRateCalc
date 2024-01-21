//
//  ExchangeRateInformationConstants.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/18/24.
//

import Foundation

struct ExchangeRateInformationConstants {
    static let dummyData = ExchangeRateInformationDTO(success: true, terms: "https://currencylayer.com/terms", privacy: "https://currencylayer.com/privacy", timestamp: 1705847342, source: "USD", quotes: Quotes(koreaExChangeRate: 1333.794975, japenExChangeRate: 147.988972, philippinesChangeRate: 56.029499))
    static let jsonString = """
{
    "success": true,
    "terms": "https://currencylayer.com/terms",
    "privacy": "https://currencylayer.com/privacy",
    "timestamp": 1705847342,
    "source": "USD",
    "quotes": {
        "USDAED": 3.672899,
        "USDAFN": 73.023412,
        "USDALL": 95.374966,
        "USDAMD": 404.653748,
        "USDANG": 1.802816,
        "USDAOA": 831.445873,
        "USDARS": 819.257549,
        "USDAUD": 1.51697,
        "USDAWG": 1.8025,
        "USDAZN": 1.701415,
        "USDBAM": 1.796372,
        "USDBBD": 2.019705,
        "USDBDT": 109.768083,
        "USDBGN": 1.798598,
        "USDBHD": 0.376961,
        "USDBIF": 2852.234624,
        "USDBMD": 1,
        "USDBND": 1.344075,
        "USDBOB": 6.911661,
        "USDBRL": 4.930303,
        "USDBSD": 1.000299,
        "USDBTC": 2.4162422e-5,
        "USDBTN": 83.142887,
        "USDBWP": 13.656386,
        "USDBYN": 3.273546,
        "USDBYR": 19600,
        "USDBZD": 2.016306,
        "USDCAD": 1.34701,
        "USDCDF": 2661.999881,
        "USDCHF": 0.869285,
        "USDCLF": 0.033345,
        "USDCLP": 920.089776,
        "USDCNY": 7.114199,
        "USDCOP": 3921.14,
        "USDCRC": 515.821433,
        "USDCUC": 1,
        "USDCUP": 26.5,
        "USDCVE": 101.291114,
        "USDCZK": 22.806401,
        "USDDJF": 178.104403,
        "USDDKK": 6.858055,
        "USDDOP": 58.857844,
        "USDDZD": 134.447997,
        "USDEGP": 30.901798,
        "USDERN": 15,
        "USDETB": 56.381055,
        "USDEUR": 0.919665,
        "USDFJD": 2.236203,
        "USDFKP": 0.788341,
        "USDGBP": 0.789111,
        "USDGEL": 2.632016,
        "USDGGP": 0.788341,
        "USDGHS": 12.003546,
        "USDGIP": 0.788341,
        "USDGMD": 67.27499,
        "USDGNF": 8597.675807,
        "USDGTQ": 7.817488,
        "USDGYD": 209.435098,
        "USDHKD": 7.819265,
        "USDHNL": 24.709659,
        "USDHRK": 6.88032,
        "USDHTG": 131.651593,
        "USDHUF": 351.974968,
        "USDIDR": 15602.45,
        "USDILS": 3.75113,
        "USDIMP": 0.788341,
        "USDINR": 83.08755,
        "USDIQD": 1310.416734,
        "USDIRR": 42045.00015,
        "USDISK": 136.949921,
        "USDJEP": 0.788341,
        "USDJMD": 155.202903,
        "USDJOD": 0.709401,
        "USDJPY": 147.988972,
        "USDKES": 162.000294,
        "USDKGS": 89.3021,
        "USDKHR": 4082.47631,
        "USDKMF": 453.000228,
        "USDKPW": 899.963048,
        "USDKRW": 1333.794975,
        "USDKWD": 0.30779,
        "USDKYD": 0.833651,
        "USDKZT": 451.871007,
        "USDLAK": 20655.00015,
        "USDLBP": 15062.497835,
        "USDLKR": 321.304066,
        "USDLRD": 189.249941,
        "USDLSL": 18.909929,
        "USDLTL": 2.95274,
        "USDLVL": 0.60489,
        "USDLYD": 4.819843,
        "USDMAD": 9.968446,
        "USDMDL": 17.730764,
        "USDMGA": 4561.000133,
        "USDMKD": 56.582257,
        "USDMMK": 2100.636153,
        "USDMNT": 3434.325581,
        "USDMOP": 8.058754,
        "USDMRU": 39.550465,
        "USDMUR": 44.259691,
        "USDMVR": 15.405683,
        "USDMWK": 1683.000211,
        "USDMXN": 17.14765,
        "USDMYR": 4.717498,
        "USDMZN": 63.24995,
        "USDNAD": 18.910195,
        "USDNGN": 860.498801,
        "USDNIO": 36.729774,
        "USDNOK": 10.48108,
        "USDNPR": 133.034156,
        "USDNZD": 1.63548,
        "USDOMR": 0.384961,
        "USDPAB": 1.00028,
        "USDPEN": 3.746406,
        "USDPGK": 3.7095,
        "USDPHP": 56.029499,
        "USDPKR": 280.115787,
        "USDPLN": 4.031991,
        "USDPYG": 7291.183428,
        "USDQAR": 3.64085,
        "USDRON": 4.577098,
        "USDRSD": 107.80408,
        "USDRUB": 89.430127,
        "USDRWF": 1273,
        "USDSAR": 3.750603,
        "USDSBD": 8.43942,
        "USDSCR": 13.409419,
        "USDSDG": 601.000161,
        "USDSEK": 10.470325,
        "USDSGD": 1.34137,
        "USDSHP": 1.271503,
        "USDSLE": 22.681453,
        "USDSLL": 19750.000222,
        "USDSOS": 570.99972,
        "USDSRD": 36.950095,
        "USDSTD": 20697.981008,
        "USDSYP": 13001.964194,
        "USDSZL": 18.910145,
        "USDTHB": 35.531501,
        "USDTJS": 10.928131,
        "USDTMT": 3.5,
        "USDTND": 3.111502,
        "USDTOP": 2.36675,
        "USDTRY": 30.19127,
        "USDTTD": 6.792304,
        "USDTWD": 31.380979,
        "USDTZS": 2514.999797,
        "USDUAH": 37.679443,
        "USDUGX": 3803.985872,
        "USDUYU": 39.289536,
        "USDUZS": 12439.999734,
        "USDVEF": 3601609.780222,
        "USDVES": 36.092753,
        "USDVND": 24550,
        "USDVUV": 120.26101,
        "USDWST": 2.75241,
        "USDXAF": 602.583194,
        "USDXAG": 0.043892,
        "USDXAU": 0.000493,
        "USDXCD": 2.70255,
        "USDXDR": 0.751625,
        "USDXOF": 601.500113,
        "USDXPF": 110.049866,
        "USDYER": 250.349713,
        "USDZAR": 18.983897,
        "USDZMK": 9001.201031,
        "USDZMW": 26.373011,
        "USDZWL": 321.999592
    }
}

"""
}
