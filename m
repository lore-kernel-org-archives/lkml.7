Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB0C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F61208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568301854;
	bh=bRaXhV1u0cqjpneEfhxR0gG6jEgN+4VgFtV5kQmun/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h6H5mSPLyx1652GxWNkgBykWPGZKLnH6EflLDrp++VssHStlx4HDaZSXhThlAcwJj
	 xBf01l5JGKf0W8YaILuq4t0pt9quIlW7AmkT8tBxM0uuGd24mitdNxrWTjNA9GdUwT
	 t3IZqwzYVUyYg1m312uI0fcecjf0OHEIsJeVFesU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbfILPYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 11:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732566AbfILPYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:24:13 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08401208E4;
        Thu, 12 Sep 2019 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568301852;
        bh=bRaXhV1u0cqjpneEfhxR0gG6jEgN+4VgFtV5kQmun/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BOE9DB4Hdw8cFXsW8x4PrxOriKSxadypHRCWo9c+8DF4THz81DVUtk483uO5ORPzU
         OaLkgoRm353ROAUE/udmVbtoWdkTZLXqZ7iW/Yo/zxJHisX4nPJJqGq1CQXn3GEvME
         f2BjDhaErqYGtKEl5xPi+yP5/XWiPeBPEPCx+CHU=
Received: by mail-lj1-f173.google.com with SMTP id 7so23973376ljw.7;
        Thu, 12 Sep 2019 08:24:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXfFubCAB4Cx7X9OS/Y3MzG1asQwflM37fDfDEL+mbbf8qwFE4S
        zdrSUMeJ0TH6FSCHxcNi0vQ/l/gA3x3agWmQ8OY=
X-Google-Smtp-Source: APXvYqxNABr3C+bOkO4dMzZfH+5jApAxIf5kJBygimzlc/o72h0wDnjOUeJugcSqbVL+mn2fyQlF/zKszB/tIXv5Pfs=
X-Received: by 2002:a2e:b601:: with SMTP id r1mr8067680ljn.80.1568301850169;
 Thu, 12 Sep 2019 08:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190912151829eucas1p216ca28e56f62e7f484c46ce30581200a@eucas1p2.samsung.com>
 <20190911133310.8365-1-m.falkowski@samsung.com> <20190912151756.27173-1-m.falkowski@samsung.com>
In-Reply-To: <20190912151756.27173-1-m.falkowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 12 Sep 2019 17:23:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcs5K46U9mF8evCpbEap_j0Sd5kUk-xiWjwyihAL7te=Q@mail.gmail.com>
Message-ID: <CAJKOXPcs5K46U9mF8evCpbEap_j0Sd5kUk-xiWjwyihAL7te=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: exynos: remove obsolete IRQ lines
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 at 17:18, Maciej Falkowski <m.falkowski@samsung.com> wrote:
>
> In commit 7222e8db2d506197ee183de0f9b76b3ad97e8c18 (iommu/exynos: Fix build
> errors) Exynos3250 iommu driver stopped supporting two IRQ lines.
> The second IRQ line in DTS is ignored and is not needed.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - change commit message to proper version
> - add proper recipients

Thanks, you fixed it before I replied with comments. Except the
subject also the commit SHA should be shorter. The guide is here:
https://elixir.bootlin.com/linux/v5.3-rc8/source/Documentation/process/submitting-patches.rst#L183

No need to resend, I'll fix it while applying. However this will be
after merge window.

Best regards,
Krzysztof

> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 784818490376..190d9160a5d1 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -314,8 +314,7 @@
>                 sysmmu_jpeg: sysmmu@11a60000 {
>                         compatible = "samsung,exynos-sysmmu";
>                         reg = <0x11a60000 0x1000>;
> -                       interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-names = "sysmmu", "master";
>                         clocks = <&cmu CLK_SMMUJPEG>, <&cmu CLK_JPEG>;
>                         power-domains = <&pd_cam>;
> @@ -355,8 +354,7 @@
>                 sysmmu_fimd0: sysmmu@11e20000 {
>                         compatible = "samsung,exynos-sysmmu";
>                         reg = <0x11e20000 0x1000>;
> -                       interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-names = "sysmmu", "master";
>                         clocks = <&cmu CLK_SMMUFIMD0>, <&cmu CLK_FIMD0>;
>                         power-domains = <&pd_lcd0>;
> @@ -507,8 +505,7 @@
>                 sysmmu_mfc: sysmmu@13620000 {
>                         compatible = "samsung,exynos-sysmmu";
>                         reg = <0x13620000 0x1000>;
> -                       interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-names = "sysmmu", "master";
>                         clocks = <&cmu CLK_SMMUMFC_L>, <&cmu CLK_MFC>;
>                         power-domains = <&pd_mfc>;
> --
> 2.17.1
>
