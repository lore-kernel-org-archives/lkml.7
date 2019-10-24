Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138B1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C13205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ddU0SNxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394125AbfJXSbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:31:19 -0400
Received: from mout.web.de ([212.227.17.11]:36017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfJXSbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571941842;
        bh=YB+702cEpqJzn3ahzv6oyUdLsIgga9l0D6kudYn84M4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ddU0SNxnT1+YOSIlD8gluAsLYsmY/qvtELCYlJ7lxDwjvLAg1yZQgG/wf8HntBPq8
         To8ndosrQjzJQSjGtY0W8ao5W7SAbd/17BfEZQNvwgg8HsL9ROJQEk5qP3f3tqAUtn
         wgVngdI271zm9zL0ch3U4npJb2eWrtB2oWMZ3/Ec=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.110.199]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbJ02-1hiHSy0bXO-00kxtb; Thu, 24
 Oct 2019 20:30:42 +0200
Subject: Re: coccinelle: api/devm_platform_ioremap_resource: remove useless
 script
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc:     Joe Perches <joe@perches.com>, Marc Zyngier <maz@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
 <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de> <868spgzcti.wl-maz@kernel.org>
 <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
 <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9a592d2d-44ec-fdf3-8aae-86688efbdbc1@web.de>
Date:   Thu, 24 Oct 2019 20:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:F4QwyWtcYHGveJtaf0WkF6zrRkhYSZUB3zVyNRTA++y4pXPCWVM
 aJNtH+xpqTbLFE6DWTsFcsfYTVa0gbRXBrnvaD2AXOzS+knZkRDGtrBRFBbbgd12M422o5v
 GYQ54jMRbvNr7HDPzntxjwuV7VJ3ne8I1IUV0UvgQjp087VnhBcwm+Dy2zmt9ZO4zUGschj
 LxO7z3k3WF2OFbijQvm8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WPvw9OALQtU=:iOeeJeOgAA/EnccSBThb2n
 d0zejb7ttxciW4pQskLL+n9AL4e3inxlvQZQVEZRrXF3S2pbrjuPK5sBSKwzamWQG2kAvb6jg
 GgP/9adbQ7XcJeLw1eW3A4BEQooKQ+XqZRt02j94ej/buIbQRc7Z9Ll3rEJk81C7RpBfZDuaV
 05e6xWPI2zRHmM29YSIEDFE88mksEbjHsttbJfZ2+2x6aLu1w5gqcBQb1fab6vjd9Gj3NgWR9
 m8J0KFJVTo/+m64GEDet8KR9iB/Pu771jY36V/IMrIOEG3paLuMqyw+mdW+jwjybd91EJhucJ
 zdkItEA5wfEabsz33xGqzSptCNyaeGJSaUijqhtMtXo8EYN4il5Wbmqe5ALqvuctZNuhpzFFq
 evK0+KEig2LCUb/wOp8IOsos4ZhX7uDcYtFQeheo8irqwM088Ie2QPGfj1tsNc92Pcc0BuR7w
 IAaA/V0KC4BjQOCL9LXaTXPwoWxnr4Vg9R5G2aeDDotL5ARKZnT36IPYqcxfnkuABoT2EMbrO
 h5qql1cpekUYRD33JvxgrJgINrvdFpUKGMgLrasE46A0ybbnLibgZfen7JZZrVDxrQHumCkDs
 qSOA3rn2nfG0pg+N0WkAaT+Y218DowyT6Zt1O5YgJNQ9gKDRWhXtcvMvtZ7bBOUyNRVM4BgxO
 CTHi0Ixf87rYW0UIeFCMkyg6/lbe0N6yxqRLygL5sixWg+FVKsFNAkIhEAHhusUcAVDahWiG0
 GY+LkgC/JVEte+Kq08cGl65CW+fNASWD1cNnOGGsU/fT6aHNexSdygs8elqoBUrfOyODSEBtA
 je1SsSf2lZhvg9ZFrGStpQA7fRnsmSt7qhTB4IUAG+9+gIStgmoNVd83pQRTABhgS0WzCT4Mt
 lxkhPKhtFPprfgEGS7Oxo9cKLGUNUY5+KXrqgTmCmqUOsMYZFStr5THcugm7kxPPUyms4TPrH
 +xSQzMTS0aR49g6JEiTHA2WV0qHHJ2FJcfwfoWTWpZraCDQi1U28JFga1V3Ak363ncW0j6VaM
 wH3bvndMhj2ZqDNUlxzW/PZEbtoxPFyh6PEfwJkY2z3nM+6ovtBcDjDR3tml6T9jaH0hScmf0
 yc4DFlXANe5M975YKHT52an7WcmL9BmnYgb9hrfinsWk1T7G9pou2p654YBKlJagpqG1Jv4bZ
 dQc1UXAwP9stPyfAlo55h9+09n+zy5IK7wconjPMQEZ6oAzxZW9Z6eejc/jafMcmgsfSkzO+b
 KJsm7G9YOjEz9Mp1V364BrlYHDR17/JZbboQeKKgPnF+FGCuYEACIkAX3RaI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I always appreciate the code refactoring
> that reduces the object size.

Would you like to compare effects around conversions for
the mentioned wrapper function any more?

Regards,
Markus
