Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F78C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117FF21848
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563359164;
	bh=6ZNHeUjYuFQvwhrizsFFiOMOLAXaj7gSQIwq8zSpTAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BXXx61wcoO5MdMRGkuSN35x5iJVQdyH43zWiE8jS7U4DPfaoiTcF/iJKCASfCvpza
	 hl9xlx7sBF4wLCZPcqKyF8PjB5CuADYRJMXy3+X0GdOOI/rVBj4rU87p3zTSb8iiOf
	 5i9/r1/t20NCEm66gyHH+/8kWHYGlAuu8jRLb6RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfGQK0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQK0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:26:02 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF6E21848;
        Wed, 17 Jul 2019 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563359162;
        bh=6ZNHeUjYuFQvwhrizsFFiOMOLAXaj7gSQIwq8zSpTAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pngu4lq7W1y/+7EN4IucarRpmRnEYrCvK0QN/7WhL7xpSdddYI2M7CzpAcibsyN0C
         /Va+7loYPp+zR1or36eLxfLO0BFJZVX9un2oUHcv7X6/e7p5SAGTvZ8a15LR7imL4V
         Qr80/bW9NTISoEq1ORMwAWLkH09fRSWMPSL0aHRM=
Received: by mail-lj1-f170.google.com with SMTP id p17so23102625ljg.1;
        Wed, 17 Jul 2019 03:26:01 -0700 (PDT)
X-Gm-Message-State: APjAAAX/P7xhe2l8vhyNfDKkCgE5wcEDkRxne/RKUDWJi27cDqWwchbt
        DFDOigFQVgwa01mF2jkCmvdCF/c8D8wU+3Rvh40=
X-Google-Smtp-Source: APXvYqyvg4XjQv6SY7ijdQp1cHJGuHEqi7FxlzWlNF0TzqNk1YWygMDN7/OybFeXVFj7TbU7p4IRgf/XVeDzaeXH91Q=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr20847944ljw.13.1563359160319;
 Wed, 17 Jul 2019 03:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf@eucas1p1.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-38-l.luba@partner.samsung.com>
In-Reply-To: <20190715124417.4787-38-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:25:48 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfrGgAczQ-=1aE453RpJ9BN10ZDmFcrEMPkNyF6GcGtNA@mail.gmail.com>
Message-ID: <CAJKOXPfrGgAczQ-=1aE453RpJ9BN10ZDmFcrEMPkNyF6GcGtNA@mail.gmail.com>
Subject: Re: [PATCH v1 37/50] ARM: dts: exynos: change parent and rate of
 bus_fsys in Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 at 14:45, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The FSYS bus OPP table has been aligned to the new parent rate. This patch
> sets the proper parent and picks the init frequency before the devfreq
> governor starts working. It sets also parent rate (DPLL to 1200MHz).

1. I see what the patch is doing, but please write why you are doing
this. What problem are you solving here?
2. Commit title is wrong - it is not Exynos 5422 but Odroid XU3/XU4
family of boards.

>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index d460041f716c..6a82dd175b8a 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -72,6 +72,11 @@
>
>  &bus_fsys {
>         devfreq = <&bus_wcore>;
> +       assigned-clocks = <&clock CLK_MOUT_ACLK200_FSYS>,
> +                         <&clock CLK_DOUT_ACLK200_FSYS>,
> +                         <&clock CLK_FOUT_DPLL>;
> +       assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>;
> +       assigned-clock-rates = <0>, <240000000>,<1200000000>;

Here and in all other patches:
I am not entirely sure that this should be here. It looks like
property of the SoC. Do we expect that buses will be configured to
different clock rates between different boards? Since the OPP tables
are shared (they are property of the SoC, not board) then I would
assume that default frequency is shared as well.

Best regards,
Krzysztof
