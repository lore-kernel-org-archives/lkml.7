Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6572ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A0520684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfJUL3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:29:39 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfJUL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:29:38 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5FxN-1huhaG0vbB-0117Z8 for <linux-kernel@vger.kernel.org>; Mon, 21 Oct
 2019 13:29:37 +0200
Received: by mail-qk1-f178.google.com with SMTP id w2so12229061qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:29:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWzRw0iz6yF9ICXqoVGR/pWXGa4DxU28XMBSRVILQA2jbLFdBbd
        oDEqv3ussACx4PJeAIxmeFaonpDIfILiX4tYlTw=
X-Google-Smtp-Source: APXvYqyxe91nGj8TKmw2rGsh4WkXsSBsZcCR4p2QMNxSQZJW/Arl7Yt8sn89P2z6gdacP0hRDEnp2Qs0G03JwPJmF9c=
X-Received: by 2002:a05:620a:4f:: with SMTP id t15mr11058944qkt.286.1571657376091;
 Mon, 21 Oct 2019 04:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191021105822.20271-1-lee.jones@linaro.org>
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Oct 2019 13:29:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
Message-ID: <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Simplify MFD Core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>, stephan@gerhold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2JfCHba4azJOimTandb6ifbcUYw/cN0hh1p6j+ekjAtBpqDrT8u
 q0y6IQ77cLeCJj3/Pkw8F9rTb54tzGyh65be0svGnYMGK9cY/Siy+qoAg2jtrW46yPfHzrl
 pYYU3GeWkJ1kssZxsjalm2fxAwYitfRfQYrxrkgO7JpGGi3BKJEp8DBNBcA6mwx+Sk3xEOA
 GaNCpeBvs8eRiKne2mzdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkJGr8GjrA4=:F87IxXjb0lVprBne15s/dr
 cTPXK2gvXyxNCa2ef//S0HCIvovjE+nlNRGDl+laPzBbFUMSHYIVHaDMWcUkslcybilXOvW+u
 4826JtfQ1K8MjzrPmiEdDQwDkRGHG/d+6MuTUati3d1rp6A1kupeV8mV5Mek+qA9EOFZlQd40
 m/8BwZNeWzPUs2moBf3De4UaX7ELRkh8ZO29qHUMLs33GIeaxso57fYo37/0GBYzdPgM23RK6
 cAXZfoHE4WTKEdqAjQnydlsqX0Jwm/v6AauUkwpNdd9OTs1tDDaEIk/KJ6LsXBZYCoHQ+2l8h
 bKiHWDN2UvYOX4fL7MBgNTU5pLwHZry/kDFBSbZlmAyLfg5mAh3xf3f4E2jwF0ROR5/SQq8M+
 cdD0E3FZmVFAm5HBh0VEIRXAK1dhHHUcUVX7MndjMxAUVT7+fSQDWQYlNC7ojjHa9t7yyHy2u
 MbjrrQgha/aikLw7WXhmJwAQyqu0w/o56OLt7vwx8uvx6WwmewXCIMRxsLGi/yF3CXiTfXxcK
 nrtwqXREF93M0kT1ByHLJbSi348bHjiCHJz8tmkgathWKywLZ0N7HM8oGkQRSNqSeYD56dXfV
 M133arMZhINuP8oAT3t8GYYGg215Q91OfdEcefsbQBH/lZEcHN2ML6qL62kRvpIc9Z5mU8oic
 pbO69Oeo3C19QLY8yroQ/1wR52JLZzPb2dvXe3DwJWSakIcFh35a+rctK0CIfAo/FP+ZerbRC
 NfdW8UTpqGjwFc2KfSH2yg4+5ZnQWW6gB0pTZccenR5NX2CIR5SvCrxotkC5ns+lMbYiMcc3o
 RaLNqEiILLRCi60aGegeH02/yxvy7nE/6o7jqnyQz3EchoZ8YvdimBqeKgCr2bSjA25cceeyz
 SI6maFLWcCFB70EG9jqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 12:58 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> MFD currently has one over-complicated user.  CS5535 uses a mixture of
> cell cloning, reference counting and subsystem-level call-backs to
> achieve its goal of requesting an IO memory region only once across 3
> consumers.  The same can be achieved by handling the region centrally
> during the parent device's .probe() sequence.  Releasing can be handed
> in a similar way during .remove().
>
> While we're here, take the opportunity to provide some clean-ups and
> error checking to issues noticed along the way.
>
> This also paves the way for clean cell disabling via Device Tree being
> discussed at [0]
>
> [0] https://lkml.org/lkml/2019/10/18/612.

As the CS5535 is primarily used on the OLPC XO1, it would be
good to have someone test the series on such a machine.

I've added a few people to Cc that may be able to help test it, or
know someone who can.

For the actual patches, see
https://lore.kernel.org/lkml/20191021105822.20271-1-lee.jones@linaro.org/T/#t

    Arnd

> Lee Jones (9):
>   mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
>   mfd: cs5535-mfd: Remove mfd_cell->id hack
>   mfd: cs5535-mfd: Request shared IO regions centrally
>   mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
>     entries
>   mfd: mfd-core: Remove mfd_clone_cell()
>   x86: olpc: Remove invocation of MFD's .enable()/.disable() call-backs
>   mfd: mfd-core: Protect against NULL call-back function pointer
>   mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
>   mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
>
>  arch/x86/platform/olpc/olpc-xo1-pm.c |   6 --
>  drivers/mfd/cs5535-mfd.c             | 124 +++++++++++++--------------
>  drivers/mfd/mfd-core.c               | 113 ++++--------------------
>  include/linux/mfd/core.h             |  20 -----
>  4 files changed, 79 insertions(+), 184 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
