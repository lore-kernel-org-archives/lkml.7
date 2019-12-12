Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF414C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994E72467A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfLLKlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:41:51 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfLLKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:41:50 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M4sD3-1igBOV2XEl-00214f for <linux-kernel@vger.kernel.org>; Thu, 12 Dec
 2019 11:41:48 +0100
Received: by mail-qt1-f173.google.com with SMTP id g17so1838763qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:41:48 -0800 (PST)
X-Gm-Message-State: APjAAAUoaoG9q5UilucHOPn6XBjbhoNiTwCIPIJPbvgVnE3q+wlEeTGy
        WXtGrwQEm/9iGKNkz+EUBM3p974k8rBSoi9gB14=
X-Google-Smtp-Source: APXvYqx1qrhJ+ZLEtmXG5NHyXLPObQKIYvH94tn9l2YlTaR7V4qRxqgCwC/Mys/F8s6u6Mb1U7HeaoE+R2W7PWRDd0c=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr6752546qte.204.1576147307532;
 Thu, 12 Dec 2019 02:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-2-arnd@arndb.de>
 <20191212101654.GA12950@willie-the-truck>
In-Reply-To: <20191212101654.GA12950@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 11:41:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2BrURQ=w0ux1v+76mANZhqpxeZhdT4u7-_w16zrssDXQ@mail.gmail.com>
Message-ID: <CAK8P3a2BrURQ=w0ux1v+76mANZhqpxeZhdT4u7-_w16zrssDXQ@mail.gmail.com>
Subject: Re: [PATCH 01/24] compat: ARM64: always include asm-generic/compat.h
To:     Will Deacon <will@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WZ8y0+uK6sDA4hVKO/dlo23gH8I4AjDhraWWuj7mQALg8Ii+szU
 LNrJJFR1QSHLxaJrxRfQ4zkRSmeMqXaHe5yX6RVHFGn3IzYiGQlUhhE2oKS3ngf9s5P0hSq
 QUWcEXd7G3QSqUDIpT+X+AvGkYbkdZPavYTbLVsbChlwHAnu040/WzonAavHqkIHjc/Q4tp
 SEi/X+N9myxg1enF3UdYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UIkeoW66Iww=:gqQY3AASFlC/IIhrWQdSHy
 pQvt4ff/GTfauc7HgEcXx7HPNcnpkdbZT0IdNflUx+k7HLm4ZQHKL04PFfuBnQRPr2NOW9um6
 5rbv6a+IIe2cANPOsq8eOT4raGfWBKCgVnCu1A3xa7nb6cDcXRpdF2PlUPG+8AQcdegObxQ0G
 q9ebNcn/abeIgTanGEHkSM1JibkufSnw3K3JwkyUq8wWZqxFebyg32zmVhTs6ibdPJw+xknl+
 xjsSSs2VCcLmUbtkV1qOv3RvX+pZFK2FJbfSoBNmrNpmpG2TJwN2is4Uarj28Ekr8H/h4gp9d
 iKkNr4qquiz63AEtpE4MicBXeHXJb58QXe9fEpndly5wYxl4+L7A0KKJ3xet+80EtihGxQ5xz
 +jt+6gopjtud8Hkbka7uU975rFI4jkJwwUmf0CqKl1+V4bzSR5RVj5NHYuQaj9woO6Q43pDii
 urtYuPzdDJCDXhfIdRfpQQ9dDaglhdmZfmJ5FhzoKp3eM08uooxRwRu4FRBOLg2/BIENpWdXx
 RpFtxJHmIcNiJY+zEM6f1br9ZClt7+M2M1gvrxlc8eG2pHs4ve4Pn5+UsGKl7cZ6tQ+Jz6WdT
 p9Z5Ydtf8jCVJgGfHJ6/DKrPi1UfZLcQgkwY+SLE21IKdAT9QDk2jBaEBsX82ZsMNrAeOAnRC
 087rxDEPtDIyk/dPLFMFoT99XL+UmNPJrdfxT6MzDKFOSQdbxy+l9QumU4woFQmnRKdoeTpsO
 lZ9sR2T9NYX0tFEX1PalBPxoqEdnEAOpMU7ZC+8Vm9XizhT+Mgp/yDCmZ6EHuovJ9y9OFnM7d
 My09VhFveY/uw4oLaxzFTxvIM1P+oR/tR20ymiaydrGMbA0uL5p/cIzizZ/HEAX0Ugf+F87Fw
 eHRtkDLIa2sZsE889FDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:17 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Dec 11, 2019 at 09:42:35PM +0100, Arnd Bergmann wrote:
> > In order to use compat_* type defininitions in device drivers
> > outside of CONFIG_COMPAT, move the inclusion of asm-generic/compat.h
> > ahead of the #ifdef.
> >
> > All other architectures already do this.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/include/asm/compat.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

> (Please let me know if you'd prefer this patch to be routed via the arm64
> tree).

No, it needs to stay together with patch 02/24. The later patches in the
series are independent of those two though.

     Arnd
