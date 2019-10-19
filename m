Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40287CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A41222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfJSTez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 15:34:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfJSTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 15:34:55 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7rxE-1iPmNb1R2o-0054s6 for <linux-kernel@vger.kernel.org>; Sat, 19 Oct
 2019 21:34:53 +0200
Received: by mail-qt1-f175.google.com with SMTP id u40so14289720qth.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 12:34:53 -0700 (PDT)
X-Gm-Message-State: APjAAAXp61ezAskyvlbWXoSEccXbtKpe9OTZNpRqOZQnloRp0KH2aAtM
        jTCx8oIBaOQ6OyEV2i9eYjXwk5WNd9LrwoN0QEE=
X-Google-Smtp-Source: APXvYqy22GrAJBe0FkPxmOqPm4Xlz+XL09o/POQr34X5BMu5W279MixtQUydyM5HiIo/UQu7OEriNwiYVGEphslC9R0=
X-Received: by 2002:ac8:38e3:: with SMTP id g32mr16775838qtc.304.1571513692155;
 Sat, 19 Oct 2019 12:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-44-arnd@arndb.de>
 <4d6920e9fab519ddf69aae9da13a1cd02d13bddd.camel@v3.sk>
In-Reply-To: <4d6920e9fab519ddf69aae9da13a1cd02d13bddd.camel@v3.sk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 19 Oct 2019 21:34:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1buT7K7YWAdztqnZ83Jq6f4q-7x_G3Ed09cKQxtKLJSQ@mail.gmail.com>
Message-ID: <CAK8P3a1buT7K7YWAdztqnZ83Jq6f4q-7x_G3Ed09cKQxtKLJSQ@mail.gmail.com>
Subject: Re: [PATCH 44/46] ARM: mmp: remove tavorevb board support
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RFAmhEsdA6kxFpSgM8lHmA0wEEu5pmby0DqOCGFNm8WHjYai81X
 mboWZnK33Gy9CvXEZfq59LPyr5/8DNMpr+DdT/jLOCYxTuW3iDLGAnslJVAcC4WdN5aL9om
 Zv/g9rOIkdCRLckdZ4knl3Z9jY195TnU+YNLfoYgm/7vbPnGrUujrBaS6d/VZVpkOP4OQH6
 /4jJmEvDrWKW7eToU1f6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QR2VVtTc4E0=:OUJCyA2sxeW9lmDH7B0ySm
 vaggIeLEmCvcPpmFq3CvNbJ6zy51dDgs/dzfHcilMsLOaPhgGtGiOc3bBZgQxwvJ76bq4CRVV
 sV9pYXD0DqsGVtt0dw0VpWjD+YjTDk2vG6X5GxwNXi+KD5x/e6O7t+RKSmytg14otQBGVfmu4
 TGMGfG++/yq+oQuuewRsT8GUfDdRvieaLF+lTD8AuyAyR4pjrd5Vqr4MS5N9y3JSTxlIRT0wl
 u8O2DBRUPqXXZjMA8rVnHhKl1tosPKZw7rEeT7HUgKzz2M9speeeC6O7QFSlVlcd7po/c6bHY
 mnCC3Rf7LMxn5AlyaHq+pXdzx4dFezSnO8/+fZcXSUarczwZMHWCTNR5L4Rpajag0VmUz5vFH
 ma8ZwIjfoIH0nuowMv451LMVIyMA/kPj20smAALUg583QHEI9KjJq1Yl80VDGtvewVOjbQbHb
 iq/jpPXh0M7n3JCuIZhK029e0//e8sNUijndQ7R9v1zzSoCICb8EYON8YQpRkUyiO+Nahb87Z
 cEyICM9X8h0la7tAxOl3Ne7b0W6W049wHnRE1BRynkGGsogWiWQ7H+BiYrb9jjBC19KTKU69n
 wpH48h1Osshg2TU7L2ZvxVrlOxboKkayc26LNYGWyQr/tFwWrksseKHHYzjtwXYzD/zeNkcFR
 0OMMbZva9SeszrebpGgSgdRW194kVT2E0E1EWdryr6Mb5TE+E0V4GMGaQYsN4w+0UNSTrraiB
 iFLE6Tl62gSuB55WNZdRXpgIbnn/vec0EIaBgpw+fdFpWTgIPlKrngS52rJJOAPRcw+F1Shs5
 dl9ud8mdAyuWRQgZCQZj2YkJFahxuIBNQBbr0Fo//bwmYXvCnrbcOIvEVG9SMa2VrHsxy1CqV
 f9jRwjuqA0Oa3MKF3d9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 4:20 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Fri, 2019-10-18 at 17:41 +0200, Arnd Bergmann wrote:
> >
> > There is a third board named TavorEVB in the Kconfig description,
> > but this refers to the "TTC_DKB" machine. The two are clearly
> > related, so I change the Kconfig description to just list both
> > names.
> >
> > Cc: Lubomir Rintel <lkundrak@v3.sk>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>
>
> In fact, I'd love to see more non-DT boards go from mach-mmp. There are
> good indications nobody is looking after MMP2-based "Jasper", "Flint"
> and "Brownstone" and they probably weren't seen outside Marvell either.
> The latter has a DTS file.
>
> Would anybody miss them?

Probably not, but I had a hard time identifying any boards in mmp
and some other platforms that are actually worth keeping.

Back in the days, a common way the platforms were maintained
was to only have the official development board in mainline Linux,
while many products were left with out of tree board files.
This means it's impossible to see which SoCs actually got used
in the field and which ones did not. It also means the other
machines stopped getting forward-ported and nobody could test
the mainline changes.

I wouldn't mind just removing all of the machines that were clearly
reference hardware rather than actual products unless we know of
someone still using them.

In case of MMP, that doesn't leave a lot though, the gplugD is the
only one that clearly meant as an end-user product. I'd also leave
all the DT based platforms as a rule, mainly because the DT has
made it possible to support additional boards with a custom dt blob
and no kernel changes.

If you have any more insight into what particular boards actually
were used for, and which ones can get removed, that would
be very welcome.

        Arnd
