Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746EC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1252071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfL3MMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:12:50 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:50105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfL3MMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 07:12:50 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MYedH-1jGtAx3zRD-00Vgx9 for <linux-kernel@vger.kernel.org>; Mon, 30 Dec
 2019 13:12:49 +0100
Received: by mail-qv1-f54.google.com with SMTP id z3so12299932qvn.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 04:12:48 -0800 (PST)
X-Gm-Message-State: APjAAAXGnDArELTodPYK/RY1RLdo30HZ7Ubahjj/nVek6eLeyXjjBjJx
        4wsPmsLjt9stJgIGyDWbh4X0mgbX8zkSX247hpA=
X-Google-Smtp-Source: APXvYqz1e+cxV1mTZXrGmUG84/Xo9WQfecIQqRaFpkN1CSnq2nZarKOac0aTW/F0VJnT9fmYMtvxWM2bGA98gJcfKVU=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr48048227qvp.210.1577707967870;
 Mon, 30 Dec 2019 04:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20191221151813.1573450-1-raj.khem@gmail.com> <20191223171043.g54secptjtqkhuve@box>
 <CAMKF1sqvEH94Abv2Ptz3XTCg6hGk9tQ1Dr86RwYn+bpSLQVyxg@mail.gmail.com> <20191223230857.eafab52y5erfmgab@box>
In-Reply-To: <20191223230857.eafab52y5erfmgab@box>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 Dec 2019 13:12:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0rwQ6jyibZJ85N32UrrhBhyhesO24_6-66F07JMFYz+A@mail.gmail.com>
Message-ID: <CAK8P3a0rwQ6jyibZJ85N32UrrhBhyhesO24_6-66F07JMFYz+A@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed/64: Define __force_order only when
 CONFIG_RANDOMIZE_BASE is unset
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Khem Raj <raj.khem@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yfG3rEOsgnCooNFoVGydWC/2tYS6ZUZVD0VMsbciMFhnOqu6W90
 hW2VBVbDL/UuJSYrylZ64HTnfE3YyoHkKHit5OWRiyohF9RjN1sA1ismWG70Gs6X6kRrLLw
 oGUWkQQGe2AnhVoBbXPgGAzlyrCsoZytlOnSby063L9jijtO12Ck9alO+RQ4Qq9IkwfiDAN
 P9bThBb311lQx8NKy6McA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U73m9w9Hp7M=:5QMdNHd8jcQyxssHkFtwOH
 IR9+kiHkK7VcBi8lEngZ3a/Dh8qIWg7m9oP1uUU7J3VoZSVaOZcrtQHhxmSXsUc1NYvr6M8Ls
 xSDiQtxRF+Kre1hmfp182bFLI0rtpPe57MJR4IBJn1r7y4ArYWEK2aoA1usRJ3G59fwz7p8Ps
 /ifTmjkKxlBZ0C0pRCV7QxgtyYs720MRM95iV2rAvF6XOQ1n32i0hkQvzypml8X0UD8GUQ21c
 4EV3kc28ijYQo7rfnyX2v9H5LKUIX/GeElL8Id1WxlJWBxRMwoG9W8ijiehoY4AAp6+o7KuaZ
 bTTm2wkIDlTmBsQgbknmCUl7CEG2TdumSSCX+PhoVqXHjvhPDemXw/cReRfcG7oGtoVbzhrj1
 vawr06p+dRn848EWYuCIrcqCvpwjwiT8R/j2rQ2dCJvXhapXMsBFHqw9BKOwyR5y5M3M+4X94
 ip3jyq0c8yqBMjbpNkdPrbTI8FrRwx2/nuCGGKSgWSiTfnE3cGycAETHVbLe+d5CDQVyhMd0E
 qtGFuYt9dsTgNEGkk+Bz/dTYvMYg/VYWf+JLh5+V+gRLtK1wkxI9eB5YX389MXBlmJtPWL+cb
 exrRrQTvrJyTyevdiOBu3t5/4KmeMvUS/c8gpScxQWbiTIcIsDLwCCC0TdC7OnCbcdnK/EZpf
 pLDyV/FQJxMiswe0YM4y18v8ilptjYoGjmMEug0Sx06uOA7gcGl5qtQqUlU4bFWoi2YyPxl9y
 eblEIv1GGtefYl/n3tQTc6gh5G1lPwPsG8J3JfOvnX/yiCWmrTHEtoUW7iFaV1u1qEgIs1eQs
 iC54xDsAdbDO06ZyQ462v2PVzehAG8693gk71sBE4pzeg6k+osY8zR6jnwlK4MVPuDfwLCE5d
 IkmQneZspN1JdfRwVAsw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 12:08 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Mon, Dec 23, 2019 at 02:25:02PM -0800, Khem Raj wrote:
> > On Mon, Dec 23, 2019 at 9:10 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Sat, Dec 21, 2019 at 07:18:13AM -0800, Khem Raj wrote:
> > > > Since arch/x86/boot/compressed/Makefile overrides global CFLAGS it loses
> > > > -fno-common option which would have caught this
> > >
> > > If this doesn't cause any visible problems, why bother?
> > >
> >
> > it does break builds with gcc trunk as of now e.g.
> >
> > > Hopefully, we will be able to drop it altogether once we ditch GCC 4.X
> > > support.
> > >
> >
> > gcc10 is switching defaults to -fno-common so we need to solve this one way or
> > other, I am not sure if gcc 4.x will be dropped before gcc10 release
> > which would be
> > in mid of 2020
>
> Okay, it makes sense then. Please include this info into the commit
> message.
>
> Also, I wounder if it would be cleaner to define both of them as __weak?

Or maybe make the #ifdef check for gcc < 5 instead of checking for
CONFIG_RANDOMIZE_BASE? That way it will be found by whoever
cleans up the code when we increase the minimum compiler
version to one that doesn't require the hack.

        Arnd
