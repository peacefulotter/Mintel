circuit temp :
  module decoder7seg :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module Tx :
    input clock : Clock
    input reset : Reset
    output io : { txd : UInt<1>, flip channel : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg shiftReg : UInt, clock with :
      reset => (reset, UInt<11>("h7ff")) @[Uart.scala 29:25]
    reg cntReg : UInt<20>, clock with :
      reset => (reset, UInt<20>("h0")) @[Uart.scala 30:23]
    reg bitsReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[Uart.scala 31:24]
    node _io_channel_ready_T = eq(cntReg, UInt<1>("h0")) @[Uart.scala 33:31]
    node _io_channel_ready_T_1 = eq(bitsReg, UInt<1>("h0")) @[Uart.scala 33:52]
    node _io_channel_ready_T_2 = and(_io_channel_ready_T, _io_channel_ready_T_1) @[Uart.scala 33:40]
    io.channel.ready <= _io_channel_ready_T_2 @[Uart.scala 33:20]
    node _io_txd_T = bits(shiftReg, 0, 0) @[Uart.scala 34:21]
    io.txd <= _io_txd_T @[Uart.scala 34:10]
    node _T = eq(cntReg, UInt<1>("h0")) @[Uart.scala 36:15]
    when _T : @[Uart.scala 36:24]
      cntReg <= UInt<9>("h1b1") @[Uart.scala 38:12]
      node _T_1 = neq(bitsReg, UInt<1>("h0")) @[Uart.scala 39:18]
      when _T_1 : @[Uart.scala 39:27]
        node shift = shr(shiftReg, 1) @[Uart.scala 40:28]
        node _shiftReg_T = bits(shift, 9, 0) @[Uart.scala 41:33]
        node _shiftReg_T_1 = cat(UInt<1>("h1"), _shiftReg_T) @[Cat.scala 31:58]
        shiftReg <= _shiftReg_T_1 @[Uart.scala 41:16]
        node _bitsReg_T = sub(bitsReg, UInt<1>("h1")) @[Uart.scala 42:26]
        node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[Uart.scala 42:26]
        bitsReg <= _bitsReg_T_1 @[Uart.scala 42:15]
      else :
        when io.channel.valid : @[Uart.scala 44:30]
          node _shiftReg_T_2 = cat(UInt<2>("h3"), io.channel.bits) @[Cat.scala 31:58]
          node _shiftReg_T_3 = cat(_shiftReg_T_2, UInt<1>("h0")) @[Cat.scala 31:58]
          shiftReg <= _shiftReg_T_3 @[Uart.scala 45:18]
          bitsReg <= UInt<4>("hb") @[Uart.scala 46:17]
        else :
          shiftReg <= UInt<11>("h7ff") @[Uart.scala 48:18]
    else :
      node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[Uart.scala 53:22]
      node _cntReg_T_1 = tail(_cntReg_T, 1) @[Uart.scala 53:22]
      cntReg <= _cntReg_T_1 @[Uart.scala 53:12]

  module Buffer :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Uart.scala 115:25]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Uart.scala 116:24]
    node _io_in_ready_T = eq(stateReg, UInt<1>("h0")) @[Uart.scala 118:27]
    io.in.ready <= _io_in_ready_T @[Uart.scala 118:15]
    node _io_out_valid_T = eq(stateReg, UInt<1>("h1")) @[Uart.scala 119:28]
    io.out.valid <= _io_out_valid_T @[Uart.scala 119:16]
    node _T = eq(stateReg, UInt<1>("h0")) @[Uart.scala 121:17]
    when _T : @[Uart.scala 121:28]
      when io.in.valid : @[Uart.scala 122:23]
        dataReg <= io.in.bits @[Uart.scala 123:15]
        stateReg <= UInt<1>("h1") @[Uart.scala 124:16]
    else :
      when io.out.ready : @[Uart.scala 127:24]
        stateReg <= UInt<1>("h0") @[Uart.scala 128:16]
    io.out.bits <= dataReg @[Uart.scala 131:15]

  module BufferedTx :
    input clock : Clock
    input reset : Reset
    output io : { txd : UInt<1>, flip channel : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    inst tx of Tx @[Uart.scala 142:18]
    tx.clock <= clock
    tx.reset <= reset
    inst buf of Buffer @[Uart.scala 143:19]
    buf.clock <= clock
    buf.reset <= reset
    buf.io.in.bits <= io.channel.bits @[Uart.scala 145:13]
    buf.io.in.valid <= io.channel.valid @[Uart.scala 145:13]
    io.channel.ready <= buf.io.in.ready @[Uart.scala 145:13]
    tx.io.channel.bits <= buf.io.out.bits @[Uart.scala 146:17]
    tx.io.channel.valid <= buf.io.out.valid @[Uart.scala 146:17]
    buf.io.out.ready <= tx.io.channel.ready @[Uart.scala 146:17]
    io.txd <= tx.io.txd @[Uart.scala 147:10]

  module temp :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip SW : UInt<18>, txd_instr : UInt<1>, hex7 : UInt<7>, hex6 : UInt<7>, hex5 : UInt<7>, hex4 : UInt<7>, hex3 : UInt<7>, hex2 : UInt<7>, hex1 : UInt<7>, hex0 : UInt<7>, LEDR : UInt<18>, LEDG : UInt<8>, flip KEY : UInt<4>}

    node Inport1 = bits(io.SW, 7, 0) @[temp.scala 43:23]
    node Inport2 = bits(io.SW, 15, 8) @[temp.scala 44:23]
    wire Outport : UInt<16>
    Outport <= UInt<16>("h0")
    wire instr : UInt<16>
    instr <= UInt<16>("h0")
    node _Outport_T = add(Inport1, Inport2) @[temp.scala 51:22]
    node _Outport_T_1 = tail(_Outport_T, 1) @[temp.scala 51:22]
    Outport <= _Outport_T_1 @[temp.scala 51:11]
    node _instr_T = sub(Inport1, Inport2) @[temp.scala 52:23]
    node _instr_T_1 = tail(_instr_T, 1) @[temp.scala 52:23]
    instr <= _instr_T_1 @[temp.scala 52:12]
    inst U_decoder7seg_7 of decoder7seg @[temp.scala 55:31]
    U_decoder7seg_7.clock <= clock
    U_decoder7seg_7.reset <= reset
    inst U_decoder7seg_6 of decoder7seg_1 @[temp.scala 56:31]
    U_decoder7seg_6.clock <= clock
    U_decoder7seg_6.reset <= reset
    inst U_decoder7seg_5 of decoder7seg_2 @[temp.scala 57:31]
    U_decoder7seg_5.clock <= clock
    U_decoder7seg_5.reset <= reset
    inst U_decoder7seg_4 of decoder7seg_3 @[temp.scala 58:31]
    U_decoder7seg_4.clock <= clock
    U_decoder7seg_4.reset <= reset
    inst U_decoder7seg_3 of decoder7seg_4 @[temp.scala 59:31]
    U_decoder7seg_3.clock <= clock
    U_decoder7seg_3.reset <= reset
    inst U_decoder7seg_2 of decoder7seg_5 @[temp.scala 60:31]
    U_decoder7seg_2.clock <= clock
    U_decoder7seg_2.reset <= reset
    inst U_decoder7seg_1 of decoder7seg_6 @[temp.scala 61:31]
    U_decoder7seg_1.clock <= clock
    U_decoder7seg_1.reset <= reset
    inst U_decoder7seg_0 of decoder7seg_7 @[temp.scala 62:31]
    U_decoder7seg_0.clock <= clock
    U_decoder7seg_0.reset <= reset
    node _U_decoder7seg_7_io_in_T = bits(Inport1, 7, 4) @[temp.scala 64:35]
    U_decoder7seg_7.io.in <= _U_decoder7seg_7_io_in_T @[temp.scala 64:25]
    node _U_decoder7seg_6_io_in_T = bits(Inport1, 3, 0) @[temp.scala 65:35]
    U_decoder7seg_6.io.in <= _U_decoder7seg_6_io_in_T @[temp.scala 65:25]
    node _U_decoder7seg_5_io_in_T = bits(Inport2, 7, 4) @[temp.scala 66:35]
    U_decoder7seg_5.io.in <= _U_decoder7seg_5_io_in_T @[temp.scala 66:25]
    node _U_decoder7seg_4_io_in_T = bits(Inport2, 3, 0) @[temp.scala 67:35]
    U_decoder7seg_4.io.in <= _U_decoder7seg_4_io_in_T @[temp.scala 67:25]
    node _U_decoder7seg_3_io_in_T = bits(Outport, 15, 12) @[temp.scala 69:35]
    U_decoder7seg_3.io.in <= _U_decoder7seg_3_io_in_T @[temp.scala 69:25]
    node _U_decoder7seg_2_io_in_T = bits(Outport, 11, 8) @[temp.scala 70:35]
    U_decoder7seg_2.io.in <= _U_decoder7seg_2_io_in_T @[temp.scala 70:25]
    node _U_decoder7seg_1_io_in_T = bits(Outport, 7, 4) @[temp.scala 71:35]
    U_decoder7seg_1.io.in <= _U_decoder7seg_1_io_in_T @[temp.scala 71:25]
    node _U_decoder7seg_0_io_in_T = bits(Outport, 3, 0) @[temp.scala 72:35]
    U_decoder7seg_0.io.in <= _U_decoder7seg_0_io_in_T @[temp.scala 72:25]
    io.hex7 <= U_decoder7seg_7.io.out @[temp.scala 74:11]
    io.hex6 <= U_decoder7seg_6.io.out @[temp.scala 75:11]
    io.hex5 <= U_decoder7seg_5.io.out @[temp.scala 76:11]
    io.hex4 <= U_decoder7seg_4.io.out @[temp.scala 77:11]
    io.hex3 <= U_decoder7seg_3.io.out @[temp.scala 78:11]
    io.hex2 <= U_decoder7seg_2.io.out @[temp.scala 79:11]
    io.hex1 <= U_decoder7seg_1.io.out @[temp.scala 80:11]
    io.hex0 <= U_decoder7seg_0.io.out @[temp.scala 81:11]
    inst tx of BufferedTx @[temp.scala 84:18]
    tx.clock <= clock
    tx.reset <= reset
    io.txd_instr <= tx.io.txd @[temp.scala 85:16]
    wire text : UInt<6>[11] @[temp.scala 93:21]
    text[0] <= UInt<6>("h30") @[temp.scala 93:21]
    text[1] <= UInt<6>("h31") @[temp.scala 93:21]
    text[2] <= UInt<6>("h32") @[temp.scala 93:21]
    text[3] <= UInt<6>("h33") @[temp.scala 93:21]
    text[4] <= UInt<6>("h34") @[temp.scala 93:21]
    text[5] <= UInt<6>("h35") @[temp.scala 93:21]
    text[6] <= UInt<6>("h36") @[temp.scala 93:21]
    text[7] <= UInt<6>("h37") @[temp.scala 93:21]
    text[8] <= UInt<6>("h38") @[temp.scala 93:21]
    text[9] <= UInt<6>("h39") @[temp.scala 93:21]
    text[10] <= UInt<6>("h20") @[temp.scala 93:21]
    reg cntReg2 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[temp.scala 98:24]
    node _tx_io_channel_bits_T = bits(cntReg2, 3, 0)
    tx.io.channel.bits <= text[_tx_io_channel_bits_T] @[temp.scala 100:22]
    node _tx_io_channel_valid_T = neq(cntReg2, UInt<4>("hb")) @[temp.scala 101:34]
    tx.io.channel.valid <= _tx_io_channel_valid_T @[temp.scala 101:23]
    node _T = neq(cntReg2, UInt<4>("hb")) @[temp.scala 105:39]
    node _T_1 = and(tx.io.channel.ready, _T) @[temp.scala 105:28]
    when _T_1 : @[temp.scala 105:48]
      node _cntReg2_T = add(cntReg2, UInt<1>("h1")) @[temp.scala 106:24]
      node _cntReg2_T_1 = tail(_cntReg2_T, 1) @[temp.scala 106:24]
      cntReg2 <= _cntReg2_T_1 @[temp.scala 106:13]
    else :
      node _T_2 = eq(cntReg2, UInt<4>("hb")) @[temp.scala 107:23]
      when _T_2 : @[temp.scala 107:31]
        cntReg2 <= UInt<1>("h0") @[temp.scala 108:13]
    wire LEDG : UInt<8>
    LEDG <= UInt<8>("h0")
    io.LEDR <= io.SW @[temp.scala 113:17]
    node _LEDG_T = not(io.KEY) @[temp.scala 114:24]
    node _LEDG_T_1 = not(io.KEY) @[temp.scala 114:33]
    node _LEDG_T_2 = cat(_LEDG_T, _LEDG_T_1) @[Cat.scala 31:58]
    LEDG <= _LEDG_T_2 @[temp.scala 114:17]
    io.LEDG <= LEDG @[temp.scala 115:17]

