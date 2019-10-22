Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE30BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868AD2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfJVKBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:01:09 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731439AbfJVKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:01:09 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MvJsF-1i5K3W2p05-00rDDT for <linux-kernel@vger.kernel.org>; Tue, 22 Oct
 2019 12:01:07 +0200
Received: by mail-qk1-f176.google.com with SMTP id w2so15657774qkf.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:01:07 -0700 (PDT)
X-Gm-Message-State: APjAAAXuXy1pelWmvDJozPkY5/qFb58aqX9F/BGd0K77AUzyNOV0sS3y
        UURskf014MyhnJKOtywvAU63GAtn2t+jrXq/JYM=
X-Google-Smtp-Source: APXvYqyoMIjk7fBvUWRiXF8k07tFQvXGIdLU7kRIlPOeM1jTgptpSLpWi87upCSM+kuYDA+uEkyDtyteslJySUIWKjQ=
X-Received: by 2002:a05:620a:4f:: with SMTP id t15mr2145972qkt.286.1571738466579;
 Tue, 22 Oct 2019 03:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-11-arnd@arndb.de>
 <20191019114417.5268f7e4@xps13>
In-Reply-To: <20191019114417.5268f7e4@xps13>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Oct 2019 12:00:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1pR=fmvDr6n22Zp1XM7J=durtt1Au8F2qg3=Jc75DrNg@mail.gmail.com>
Message-ID: <CAK8P3a1pR=fmvDr6n22Zp1XM7J=durtt1Au8F2qg3=Jc75DrNg@mail.gmail.com>
Subject: Re: [PATCH 11/46] ARM: pxa: cmx270: use platform device for nand
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tT8zKhmTNS8yJqLtjj7C+5nL4wiRhScvbgahO/Luy9v5Ywux2Cl
 DVlCAt6KvH+hvkIc/JLJgVyTFj7I3XYdYuIZ083RUPuI3k7/1nuyzayKbbO6PTQl2V7uNLI
 6vs2eQ10HvFPUexzKNnijIO7B8LoDLzguGJSOxR1x2fx5U6S1pYVtwobO/o+y0yWQhIxhZK
 tOLkDoLTXW0bNJAv5Qurw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZhLJ6kNFoRI=:2FqjaM1DCDtdoLAtmohe7X
 S0to2iXUaI0sJtW/Vt5Z26/8D+45BKjDJoXuUur3+KlKoivaLu71RxfzI7/lfGVAxVmZh3e/u
 VVFwqBl/dTiU21huNApR29Z2zdGPFSO6wQnpdEd8XV0BhXt102trPThP8xrGyOznTY3N2dMBV
 WuxS3HEC1LFenJcSvSlMIi83cY6CYO5IWmd3NUlcC7Vbju86E5biYkCjGwQwuBxNajcnMcuFp
 W/3kKw/SILSVFJEiSakS2i8q4IvKpO5vUI5k4JvU+pJIozrVvf8Hw3MtSa4KQdGFxXT60djOR
 75HXh/IiKZveU/uXufIwDyLiIPGFCGVyiBrH7qtrQswRgzFpugg54iyLtf8sBFSkfdUDcfzwe
 anCx0qXRRZ6C5qO3WPr9ImQbcbcJqiokXj1C9f/C/IAFNLYWgPcRTj3Zk1y0IQfB/V7pDLOmv
 nn2J9Gp6+y3yVz6HCZ5J3s2HwSwlsek1IQuddcrNByDJuCosly6V/Osbag6/R26d2ojJxABB0
 a75HM7lUXwbj+lUEaMBIY/dPSnSpHT7gmxzti2kpJJdybbd+FFyGZS5lbGpLzyaowXWOE99bL
 jPUcRBEv1w5bxFQYFbqFz4Qe+5baHIhmcNOX5f24LPnMNggfLklrrW6ynoCiPtZLEygagEi/G
 dpvfW8zDD2fEBc2eZn2ESt6srEwdgD0wUYPmqkORxgXB5k8LaWs55feEDxu/DZvtKpJRtE4xB
 TCLWanutcuA/7OMFTRMabDlfNveQ0VPfvOV2IfEaR7uqBaFnXnyt9WFXlrzpaJl4k/9W7e66n
 plPmALYz/avbzsUEaS4rtS5/y14YH3GrFqX4IxWcV6OhrcUQ68cHwitRbSo05+t3tqzh//5C8
 NcYhvIJcHXB8GhGFByGA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 11:44 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Arnd,
>
> Arnd Bergmann <arnd@arndb.de> wrote on Fri, 18 Oct 2019 17:41:26 +0200:
>
> > The driver traditionally hardcodes the MMIO register address and
> > the GPIO numbers from data defined in platform header files.
> >
> > To make it indepdendent of that, use a memory resource for the
> > registers, and a gpio lookup table to replace the gpio numbers.
>
> Looks good to me besides the typo s/indepdendent/independent/.

Fixed now

> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks!

     Arnd
