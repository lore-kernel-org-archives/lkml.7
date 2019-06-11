Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071CBC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516A21871
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406572AbfFKUkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:40:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406545AbfFKUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:40:41 -0400
Received: from [192.168.1.110] ([95.118.191.213]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrQ2R-1iPHOT18lz-00oVWA; Tue, 11 Jun 2019 22:40:30 +0200
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
To:     Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
Date:   Tue, 11 Jun 2019 22:40:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f+Ht5hYFuUjeYvOKk6o2JFMqi39l5C6wxnnE8+7O0BKjk77Q6Gu
 qW9aH+F0ZT8XX2DGUe0Sjk2ayDE4lx9wopAmDNfaFfijlhzOFpqsy8LoaCD8wFHpI0IZUel
 ovAoUFC4eCcRwscNpmi84MD7qv7J/UNi3mwOZn58//9eJqryuQDpj3WsV2SpPl7aThOemU/
 BtDuGhGNhqpfa9fFMTlTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yXeVLoxn+9I=:RwY/bgJO0YPNmR9AYAPBeS
 /+qzsjqiuP5IAgj2OapVuADyWvI6cWGzbmF3A6aE5gtJaRh2g2WierULflfOPPqEfdaplzAFA
 yo/GMjqfiPMx++tBUZMbrDF7UeX8G8tAOTnX1MPCa+ToME7XY+iIpkCw+7cvN2Fa/Pv0R1bw9
 4cFL42FCsm+z5AID2Owml/OcPwE1KZmnEQ8jfzxuoBdiuiKaV5vvw4xV5Lz+uWTRyqKIOIbo2
 yu2birfHdrv/orQpu7CQRHhAxwX0Zw5QGhWjbwIc1U7rzNsXpk7D2OmniUi46t7eIA/wHd/od
 /MfCYikLODkOX66TcDDtgAswB+J6ko+0O7zOJH6xSAD9t517IfZQ1DH8S9oXl5vxRMDzAQ2pm
 r9DkylZpbhuI0qTH7s778dPkaX0KSP2MvYf2VVfsI9ILSI8MjDiyRi31Yehmm3YPfLsKcI44o
 MalWbbQurUYeI/DJj3Xh/jxYYlbtyfXn3BPIE4Z72CHa+3Xz31NLb02XLYQlXZpvYN2oiWW4k
 aGTzHQUIvQzA7Y2nSLZkNtDaF0B74I7AlkzGshi5yCOEdjRU1R5gVruYCCif23N98W9UuB6TJ
 2IjfyxdJSIXsUtwC2oWD0Y4444cuHK+ThFlLQRj5FgW3rBhcK9lOV6wDPgD1KkpTx0R8+5znJ
 pBnkvkZo8TA9DEHzXObMdjfIAFDrUbZRPZtLpjHYUqpVBRZwN0T6E7rsOEAPPPZxwQRH1wVcW
 qbaQS5yN+aTEQmPw5QA13iLHpBYrEbWpvjePeWIqHUgX52/KeA8a1qe/NdY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.06.19 10:55, Markus Elfring wrote:

<snip>

>> But there is not usually any interesting formatting on the left side of an
>> assignment (ie typically no newlines or comments).
> 
> Is there any need to trigger additional source code reformatting?
> 
>> I can see no purpose to factorizing the right parenthesis.
> 
> These characters at the end of such a function call should be kept unchanged.

Agreed. OTOH, we all know that spatch results still need to be carefully
checked. I suspect trying to teach it all the formatting rules of the
kernel isn't an easy task.

> The flag “IORESOURCE_MEM” is passed as the second parameter for the call
> of the function “platform_get_resource” in this refactoring.

In that particular case, we maybe should consider separate inline
helpers instead of passing this is a parameter.

Maybe it would even be more efficient to have completely separate
versions of devm_platform_ioremap_resource(), so we don't even have
to pass that parameter on stack.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
