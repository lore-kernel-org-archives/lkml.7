Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27EDC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D3D207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441046AbfIXMzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:55:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46559 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395416AbfIXMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:55:21 -0400
Received: from [192.168.1.110] ([95.114.122.209]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mvbr4-1hvuHu0Nh0-00sh60; Tue, 24 Sep 2019 14:55:20 +0200
To:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Portege Z930 extra keys and leds
Organization: metux IT consult
Message-ID: <09e715a0-08d2-100d-4bc3-c4f6c87f2a98@metux.net>
Date:   Tue, 24 Sep 2019 14:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UOtB/iGkhXcNR2BZbMPmAZ0fHg4wQxTbYIoeGQ53EylKibPTAFt
 G1P0ZnuNCgtsKK0cC4u3ItXfZNL7xIOMcRp8SXjuybK1+U77ygL4390hM/3fVGRftTgyYyE
 Ju4swvvs72IQxewtwbFXm0JrxTk6gD6XFtb0jVLh6A0c8wA/qt7ugUbBzI6RtiAaRZ8kHPW
 B1ahgvvT5KLZxm/rvFJNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:92czqRed0WA=:dbAyzHGkptE+ARtzgy3NwU
 3cG9pSMEqeDj/cS5DXzQpFEAb+nOIjWJ2UoHanm8mlQcpZZyRVDnJeKZfdwnQgNMKJk19MicZ
 B7JoAz93W+TvB/rUugq+H2vp+l9VF2pI/Zkulwx/kYKiEat0xWhMSz6aWrlU7p8XkFMMZN61Y
 XYbpYMeS/2CdfJOp+0/3LYMljwOoRZb353QrvjBbK/o/EEWjcSSSZYvnz9pTc8ldpdtdOkqIZ
 S762jItWWM2XCW8IOhWaUcMoQ2PJmlj/KibXr68B9H11LZhglXDMER+SGgu4f+xuk18gPV+B1
 9Om9TPpZ0ppr404B6ot4IlfDu4RXddiY72SDhzpsLAmGQOodOrMfr/xP5YccEIL2cquZt1RxJ
 L0vgXbKuamycUqZmJ1tN07KSLBdrBKw7IOfcpqP7Zjj8g7yWwXImx6LSCjkWhcdQoqZaK7kMa
 6UudLlCZb/BwNquhmeXAk9NFWCKYu9EickzLiSodZHvFysmrWlPNMd04oag6hRXnu617MdZw7
 lL1HZYXyrOYcLTehH3KkKkSmZBeYPNBcre52gvVS7oexAWnrNKefeUIBhT+oSb1Gknr/obr/C
 3MQpClG9Wfv0hzfrLInviJS66YV+ZZ85ZbP9B3GBxeeYPkWf14kQYEn85yZtCK82EXHAkhFhQ
 9v7N4YtHZnZ4JCT2TdzTVCIGrmntqkVQGiH2Kje49zC8nMTLSh3Atso9Og4mqiaHPWRwgTSAT
 F7YiGt38HKwPoUkgl7E4HDBtkNhsv+qrtA9o040kqrbeFs89S1hfiWy9R7igO1Eq8aW07o9t+
 M2zwmpvnpM1qMnTB+BjeybqsvJt6Sc1Cgql7PNT8de7DZh8StbEwdhPbpS1QsF+fVp6hT9q53
 3kVis/PSuXaFcO5gE//g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


does anybody happen to know how to drive the extra keys and leds
of Toshiba Portege Z930 notebook ?

It has two extra keys above the keyboard (right next to the power
button) and some indicator leds underneath the touch panel buttons.

Toshiba originally ships the notebook with some strange Windows software
(for some mysterious "ECO" mode) that reacts on these two buttons and
drives at least the rightmost LED directly - so there has to be *some*
way to control them by software.

When in a terminal (on the console only when /dev/input/event10 -
"Toshiba input device" is opened), both keys seem to generate an "x"
keypress, but nothing coming in in the event device.

Does anybody have an idea how to catch these key press events or
how to drive this myserious ("ECO") led ?


thx
--mtx


PS: tried on an older 4.14 kernel - haven't had a chance to upgrade
the notebook to something more recent :o
-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
