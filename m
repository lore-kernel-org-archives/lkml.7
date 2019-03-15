Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10309C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD0621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfCOJhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:37:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:37:37 -0400
Received: from [192.168.1.110] ([77.2.38.11]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4Q8u-1gwW680DNW-011QXn; Fri, 15 Mar 2019 10:37:14 +0100
Subject: Re: [PATCH v2 02/45] drivers: tty: serial: 8250_dw: use
 devm_ioremap_resource()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        macro@linux-mips.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, baohua@kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-3-git-send-email-info@metux.net>
 <CAHp75VegzKNhH1Uza9gwQMOAEOdh57WTzsHUx7vPdVs7XvJROQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d4e60f4b-6a3f-8af1-0ddb-e7a69e0c15d4@metux.net>
Date:   Fri, 15 Mar 2019 10:37:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VegzKNhH1Uza9gwQMOAEOdh57WTzsHUx7vPdVs7XvJROQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LMbGrgS1Fw3sbm3BX4m+19HQ5xTGusRRe0UWXpP0ztIQVQgQrlc
 m53H4MQDK/RM1nKPWCag0ezzxjT0wbjDa/N87KZImrFRriiJckuCAztY6IZagfpoEJntLOq
 nR2WhNIHqdTuNxUilfS9+Zd8kAWSBCOmM7u7UouBs0uNFHrI07s+K5WRHezpTZz+6g55hnn
 5awtt6qM+v1ChFGU/1Qzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9yl8hjgmV4o=:qa/ooxfQuXBNMJTkd2wlcR
 Jw/fZubKj2Que3t0FPCECdniDQk2yOI5tSLsLYxL0OlYOMJBp8cthnB21miHDJVVndcoxTtEB
 0qot9dVVlpVC9Oi965cbNDllBml8Hufy2WCwPaCEmDReH3IxuA7SLW8gIKc/M+c4mn7Sk42bR
 HNFhlmkISgobr3RuMwUKF6TWzaUzz/eK73n2Py/5S425fJyWSL0RpIXZlrY31V+GCCuX6bGjk
 KBFwZZ3Gahd4D4J0DhXrqdZ2TPU79oFdS1YEt70M382z/fAF+LS+owfknLuQUWBixQHTD4+xw
 bv7KzuY+SH9gmERV2Cc7ShXyDzjoF9uYnXLrngClY1ECj06unYyGAQuqIUAJ2AE78V93W8d0c
 baqT7D0/aNb8JibxCHlEjxM9tnXUuLSCq11fveazwuMJSWlBs7KEQvp+AZgajDXHWVaK63tV9
 QDWQE9bI3VSBA0P1mxONwdL6ClTKbU50XdEYW/p+/y3O0AzR0De6G7DHnQdMZTVLNIteupKXm
 4vvwOaFIXDhDbCqHXWU257N3CsAXaVLqXSCwBImubVFSN89Y6o+An/xAo8hmouhMMdsJZwl6K
 Zknww/47T5BMDfduJqxseSz/+nLikMzgHDC5rvywnEQSMlhsh5nk2vQ4zYQmUlfIjigXmPhkn
 sthMjOrxzn2RcnHJf3/W9Jk/ah/KlUGIzPFgAsL8wcG7Qr/ypb5/vt7B0Yh7Y14dbqpuCbUvi
 mLOvAw6A3AFkBatEoo70z5+f1ApgzAV10DNl9pjAdv97E2b5i9d07N8aEpE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.19 10:04, Andy Shevchenko wrote:
> On Fri, Mar 15, 2019 at 12:41 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> Instead of fetching out data from a struct resource for passing
>> it to devm_ioremap(), directly use devm_ioremap_resource()
> 
> I don't see any advantage of this change.
> See also below.

I see that the whole story wasn't clear. Please see my reply to Greg,
hope that clears it up a little bit.

>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
>>         p->set_ldisc    = dw8250_set_ldisc;
>>         p->set_termios  = dw8250_set_termios;
>>
>> -       p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
>> +       p->membase = devm_ioremap_resource(dev, regs);
>>         if (!p->membase)
> 
> And how did you test this? devm_ioremap_resource() returns error
> pointer in case of error.

hmm, devm_ioremap_resource() does so, but devm_ioremap() does not ?
I really didn't expect that. Thanks for pointing that out.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
