Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A4FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C6820842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfKDPZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:25:49 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:25:49 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M1qfu-1iTr9w0XV2-002DXs for <linux-kernel@vger.kernel.org>; Mon, 04 Nov
 2019 16:25:48 +0100
Received: by mail-qk1-f173.google.com with SMTP id m4so17944808qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:25:47 -0800 (PST)
X-Gm-Message-State: APjAAAUF6AcLSY5esuNIODOC9Fkqv/bgY/zqjCjb9QKFlXOUmssVeVcU
        ZzteYR80a/vtwcv7TtRKLhChA8MNyRaEOW99bl0=
X-Google-Smtp-Source: APXvYqzFZt8fB9folG/dB9+o4OKV18odAQAK5Xk5C+z1pe04hR7xC3ih594ii6t+6rsPIHnw1KOyYjwhv3nQwrhHlNQ=
X-Received: by 2002:a37:4f0a:: with SMTP id d10mr17070233qkb.286.1572881146989;
 Mon, 04 Nov 2019 07:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20191018163047.1284736-1-arnd@arndb.de> <20191104151310.GA1872@bogus>
In-Reply-To: <20191104151310.GA1872@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Nov 2019 16:25:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1B5v_3p0XhddoeWu7wChr6BndfqVVjPUvWYC6=aRfLXg@mail.gmail.com>
Message-ID: <CAK8P3a1B5v_3p0XhddoeWu7wChr6BndfqVVjPUvWYC6=aRfLXg@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: versatile: move integrator/realview/vexpress to versatile
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rkGric0hkDlNNPHR8C+OVaVO7FBtbwOuIebMPNdvoK29ptSlyRt
 SNb6o4nfsrzxoB53NxTYJ2M110YhGhiWR1w4n2uSupEV6RYgqRkTc12LQKokuXAA9LKMsHx
 s8kzlzvYb5RGRgyv3SYbvOt6cbeLcLRirMQL/lKPWHN+ktyywiBaDIZWcXl0EbUsjxs2I7w
 I7GBsM3Xr7w7ejJ3CQk6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J4FXPkG1CMg=:Z/Aez3k4lpKcPaPmNkMm0r
 7RAAj32kMoUe0Bxv3fv9U0X/0skIT1uZ9vSnrX8VIjgy+HWA5aw5Lo49/n4XJIwOihjfSonMS
 BcsmnXEDUlHGfwSTTDTHALOUSIn56NqsjcBNqUJqosijNduKGjyKJYezei9++mvn0/9Q73hS8
 sd0eQbddY24m0fETQsvqWHpQsulzAPfoELl7V0Q7DoFuj5llSIPHCmPoRhfgO2MjFQrqFb69s
 Mmya9fc8M9Xk3HtffSUXcUcre3qIUH20AhfLe1zMamwX7b0eACeneDngr5zJcOO0TuzsfbwnK
 bOsXxnq5xHXAS4iMY6yoHhIk3GGsq5luCtyoFwqEJ/p63bNi7uT/+buQ3KYZqIYMXm1KYENQ3
 vA2j7ZIAEOa1BTispeoYL6I4GQqH+q15O/wVcQbC+5QCbEOj+RGoW7sthv6gLxOzOK0wt9mXm
 UK9aFdH+vBUYgupU0W6YRMzUpijDaETZURZOfRnGC+kup+j4/S904GbBuCXg+pmVv3FbCtpnQ
 scGV1vDiQaJHiD2Iwu9Fi633H7jMraxVZFkOrAyaDHZ2AAZuI64e7+qtTHqZ0fi065/sfdAG9
 4VOQIRb4HNBZL0MhG6lcd3PebHQmTCzhzFTq+2n0DzWVvfSyvl3LZ8u+lBuJMsWFXAn0miCZ4
 u9Yq7OisGToOPohy5sVkiSztgwG9jCCRepRjQdxLSD4jYAl1WDhSsq7CCKxpEZvjRJeceV9TA
 Sdakz1iJScehvmuyJ/9alTtptqa5wv/w0xfaHXBmGTNGt7TX9Q9EdvnJWUBeOfK+92CePoCBb
 aEL1EelDLA+ZXGzba1RgIf4raODudmiKJ98Kk4+18gbJAc7ZAKh1kR9QQywh5tz/SBowMxcI1
 0HpfDfC+LOQzpBlWQVEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 4:13 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 18, 2019 at 06:29:14PM +0200, Arnd Bergmann wrote:
> > These are all fairly small platforms by now, and they are
> > closely related. Just move them all into a single directory.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>
> Looks good to me, so for vexpress part:
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> As Linus W requested, if you share a branch, I can give it a go on
> Vexpress TC2.

You are of course both right, I should have split this out into a separate
branch, rather than sticking it on the end of the completely unrelated
pxa-multiplatform branch.

For testing the changes, this should be fine in the meantime:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=pxa-multiplatform



     Arnd
