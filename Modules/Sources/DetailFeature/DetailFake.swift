//
//  DetailFake.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import Core
import Foundation

extension FundDetail {

    private enum Fake {
        case first
        case second
        case third
    }

    static var fake1: Self {
        .init(
            id: FundDTO.fake1.id,
            fund: .fake1,
            title: FundDTO.fake1.title,
            author: "Михаил Борисов",
            info: Self.info(for: .first),
            isIncoming: false,
            progress: .fixture
        )
    }

    static var fake2: Self {
        .init(
            id: FundDTO.fake2.id,
            fund: .fake2,
            title: FundDTO.fake2.title,
            author: "Дмитрий Гриднев",
            info: Self.info(for: .second),
            isIncoming: true,
            progress: .fixture
        )
    }

    static var fake3: Self {
        .init(
            id: FundDTO.fake3.id,
            fund: .fake3,
            title: FundDTO.fake3.title,
            author: "Благотворительный фонд",
            info: Self.info(for: .third),
            isIncoming: true,
            progress: nil
        )
    }

    private static func info(for fake: Fake) -> String {
        switch fake {
        case .first:
            return """
            Представьте себя на корабле, который сделан из мусора. Звучит странно?
            Так и есть! Крузер - **первый**, который был сделан из мусора.

            Его основные преймущества:
            - Дешевый
            - Комфортный
            - Локальное производство

            Все этип плюсы перекрывают минусы. *Поддержите сейчас - прокатитесь потом*
            """
        case .second:
            return """
            В наше время, когда цены на топливо растут, а санкции вводятся, появляется потребность для чего-то своего.
            Илон Маск далеко, Marcedez уходит, а китацские проивзодители не спешат поставлять электрокары. Что делать?
            Правильно, **инвестировать в Ё-мобиль**.

            Его основные преймущества:
            - Дешевый
            - Комфортный
            - Локальное производство

            Если вы ездите до сих пор не на электрокаре, то почему вы здесь?
            """
        case .third:
            return """
            «Собаки, которые любят» – некоммерческая организация, которая помогает бездомным собакам и кошкам. Благотворительный Фонд официально зарегистрирован в апреле 2017 года и создан на основе волонтерского коллектива, помогающего животным с 2011 года.

            Мы оказываем системную поддержку животным в муниципальных и частных приютах: приезжаем к ним в качестве волонтеров, социализируем и выгуливаем, закупаем корма и медикаменты.
            """
        }
    }
}
