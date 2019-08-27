Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D24C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B01204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfH0P2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:28:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42427 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfH0P2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:28:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so17313505qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 08:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3ksHcNSIabovy1lG4Hu34xi55zJA9WDe2gc7j1lkZM=;
        b=XXoeiususcAAy4FGAOr0VQsMrEsQngAuAEOdSb/bTr9n7RxJbBd2fuGf4Olb/h3sxk
         luvII4KJKiQFWwvSffDLW/YiXa3f1/YDdLGao8qN9DO1+clmRbRUZXI9lvVCBAUIKd2C
         u5VMrIhP26vOo97lVAcJm4lBUj/tcbXK6EdLxybJPDW7GmRfdgVeM+IjRZeOi+W8AoVz
         eAYz9iSdmoEmd36pGveyHQf9Oe+OgkjyjWytoNBdif1tm3feG88VqVnfqs3RoPqyY9UL
         4m6jsY9izQwd/3DdsDIFbZhOs/jT56LFsX/CG18TexjU/IBcu2EDPalNA4RmOZMME3qy
         uO6Q==
X-Gm-Message-State: APjAAAV+n16Ixtm5EJ7R7/gzESrpQz6YgBeM7/FTXp6q4eQ/+EViMYux
        ndlLJHL8rruS+JRFkXZle/8UDwpJbqdz9Q2+F+k=
X-Google-Smtp-Source: APXvYqyhxki76SYI4cr4BqFQDRo2aBbKnaP65WQLVFj2ojTY81JAvnMBeeKCPrBMK0vEnccPy5+Yyu2CBie2/njlyOw=
X-Received: by 2002:a37:bd44:: with SMTP id n65mr22220560qkf.286.1566919687788;
 Tue, 27 Aug 2019 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190823125331.5070-1-enric.balletbo@collabora.com>
 <20190823125331.5070-12-enric.balletbo@collabora.com> <910312bc-d4f1-b587-b6f2-e832b13d7237@collabora.com>
In-Reply-To: <910312bc-d4f1-b587-b6f2-e832b13d7237@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 17:27:51 +0200
Message-ID: <CAK8P3a1ScpJCVEPWiVo+Kc=Ec=c_uhidAt44i==RH+YN5Y+U=Q@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm/arm64: defconfig: Update configs to use the
 new CROS_EC options
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:52 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 23/8/19 14:53, Enric Balletbo i Serra wrote:
> > Recently we refactored the CrOS EC drivers moving part of the code from
> > the MFD subsystem to the platform chrome subsystem. During this change
> > we needed to rename some config options, so, update the defconfigs
> > accordingly.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > ---
>
>
> For some reason I reduced too much the recipients from the get_maintainers
> script and I missed the defconfig maintainers. Sorry about that, so cc'ing Arnd,
> Olof, Will and Catalin
>
> To give you some context the full series can be found here [1].
>
> All the patches in the series are acked and will go through the MFD tree (Lee
> Jones). This specific patch is still missing some acks from arm/arm64 defconfigs
> and if you are agree can go through the Lee's tree with your acks, otherwise can
> go through another tree.

Defconfig changes often cause merge conflicts, so I'd prefer to have
this merged through the arm-soc tree. Can you resend the latest patch
with the Acks to 'soc@kernel.org' to get it into our patchwork?

       Arnd
