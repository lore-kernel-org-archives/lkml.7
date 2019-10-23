Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C7CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7764521906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391979AbfJWN0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:26:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389928AbfJWN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:26:38 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MwgKC-1i459K22OI-00y8o6; Wed, 23 Oct 2019 15:26:36 +0200
Received: by mail-qt1-f177.google.com with SMTP id t8so14694157qtc.6;
        Wed, 23 Oct 2019 06:26:36 -0700 (PDT)
X-Gm-Message-State: APjAAAU1tvN3jqPtS6ucrhW9U06BIr3ClfPYQaluNbMdSL//yT2QUilw
        b1F0gqKyccXbW3wxleHV7NHLemhJpqC7XBMf18s=
X-Google-Smtp-Source: APXvYqxAZ5sW4MUn7hs0uPvxFoT5m55RrQo24Ahjlcek7m7qX3oExJe4OpV4BiqYQAQiBrLzW5XHJy3sKNWlb5r7mmE=
X-Received: by 2002:ad4:5011:: with SMTP id s17mr8084805qvo.210.1571837195091;
 Wed, 23 Oct 2019 06:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-3-arnd@arndb.de> <20191023124648.GE11048@pi3>
In-Reply-To: <20191023124648.GE11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:26:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0_iYkpK45HmLGYObEXkYbCjDjoDdZXS5Eybw9hPYC=CQ@mail.gmail.com>
Message-ID: <CAK8P3a0_iYkpK45HmLGYObEXkYbCjDjoDdZXS5Eybw9hPYC=CQ@mail.gmail.com>
Subject: Re: [PATCH 03/36] usb: gadget: s3c: use platform resources
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JyBlGR1sxo3dSE4MR9v+8MBkEF3qa+6oFZyj0ASbrjNJ6n+xWVC
 /HFwzZHk+sodjDeC+bxfXLB4Lki30kkwdHymlKEErsDd6BB/AY+FtN/DcRmgg8I2ZPDpIeo
 Ngkswh39yISPn0npljPSCbvACe0GdYZuK3ykFcsbxr9ebKcvLYJ5eZJfdNPcjufGYiaQrpc
 L2XIKN5aeOPXMkhtSVTVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HFWpun0t+3g=:NxVkhyXE3OtsUPvDwwMAIR
 PuJ+d2zVUDR3Dt9OLm8pMLjyMcKi3uVFgdVIKxJRrXzaaC/yNHnKq0GGnbQO990GKE0cM5duE
 1y7LYaQfIHfaMREaSnwbztWFzxA6sogqkfJfpH+VZkunckkPtckHSZmYpNmHNparBmYPVkjUR
 oqU3tgyW9CnpsTA/v7MVNkMnYNsL8KPQ0fArt9h0+snflLoOP4sto5i+luTF8JyPXhihEA+WK
 CMF1xu6oTAY9A6+uADIgJN3IeYXQ1nBrKxdRJ38JVbfvr3OO/vcuEbfnoAPiFR83hLGHPgS3m
 M+/iMIttssravt9Tss7WO2/XY9cuYv+luHnfS2m1feZfX8Emn8F+zEtYzsNCHRSD0T8gBf/qj
 d/Olt60SnjyWyeJri+FQdhMh0KSWbUuFarKo3coO/STnGUXi65Q2/YLoo+WOUyHjr47lTuq0r
 WfDiFYKpiUtoClX+jAwBz70/Xq8ptxj6/32OqbDmFj6RPvhjDxMVgLdYx42/WKoP8Fghr50Ns
 y6Cm39RDfHVLDW2k2epE9Z7VkuzLlT60zDvDADdx+0qx0ywjj7G4Rq9Pq3kwnOMTwDNb3JYNK
 jbr98iOiYjFy4rYKujQUtDEsl4voujOLyjzcXiQbYm+4SKUQOFwvmNUOYdammPbE3CIiHaBc5
 TZT+pLQSS/7xo3YpqwkJnPUhrk17NH8UM522vc6e257kUMjPICOCdIHp/bQtyQXPKcaAqAzjw
 WArvsEV1xP2fiXrMvbhNsprSpGQLXNoYQSxVlPu/gFn/X96wQfF5eIfTHHd33j3tH7Bo+Y22Z
 9/UVNkSviqCTnnILmYGNx6s/+D3Y6muGFTzV9zxxuGe3iYJdLoH8/pWIzgm6VsWCeYoQEjqC1
 lEX2tLg/lSHY2IgoKEdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 2:47 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Oct 10, 2019 at 10:29:47PM +0200, Arnd Bergmann wrote:
> > The resources are correctly initialized, so just use them
> > instead of relying on hardcoded data from platform headers.
>
> Generic comment to all patches - you seem to break commit msg lines
> slightly too early. In certain cases it makes them unnecessarily longer.
> Maybe your editor has to be fixed to wrap at 75 column.

I tend to use '/usr//bin/fmt' with the default setting. I think the idea of that
default is that an email reply with added '>' characters doesn't immediately
have to reflow the text.

       Arnd
