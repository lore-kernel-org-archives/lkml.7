Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408DBC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A283217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563359623;
	bh=jSaDID9hgYfnliGptlwXumcvM/zIQPwcjviS3KOK0iM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bH+ypnofprz0RxQAne6DhJPSIrEEMf8I6ZZuk+2aXZV6owfav3gyzJWtATy8qNn1q
	 FY9TNZz4DwOI34neDGs8x7hrojgq5+ng6vtoOEpDsCcKm8tsB5ECluPjtc9uI+Wb82
	 V3O6TM9ucqAzgZuhUnYdMLRfLhgcLPQHB/zXJJkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfGQKdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfGQKdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:33:41 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56E821848;
        Wed, 17 Jul 2019 10:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563359621;
        bh=jSaDID9hgYfnliGptlwXumcvM/zIQPwcjviS3KOK0iM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EeA60zFQcj611TQd7C6MujlhxW6JLU1lGaIiFIcdmkRVWf+gZjyhg2nDEGKnNXenN
         ym2YnxH4ohgCWo5ZO52McWzudtbRePzKY6mDN30ZEvgHneZ+VCs0p26Cu7I7Js2OyA
         Nr24bdmBAm6J8u+tsgoe2kWlvRuvFSmKhGry5fH8=
Received: by mail-lf1-f51.google.com with SMTP id q26so16069247lfc.3;
        Wed, 17 Jul 2019 03:33:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUiE9/p0HIyhTUwW8AkzEe3FFtbTAr7P/dOEX1D9QAMjzGZPM9X
        pjrF7x/If0CRdWvgEVGqOp8SdWnvNZX8a8XLDJk=
X-Google-Smtp-Source: APXvYqzfd8qQfJ47ARKH7ZjU+7AbaDNvBG2A0KFFMMr0HRO82EOOxLdt1QfT4GOhtDlngwx+wXKbAfJRQeeskhxBGWA=
X-Received: by 2002:ac2:514b:: with SMTP id q11mr17797614lfd.33.1563359619184;
 Wed, 17 Jul 2019 03:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124458eucas1p2df56f2e0c7a1a0a9144a4d5fbdb471a9@eucas1p2.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-31-l.luba@partner.samsung.com>
In-Reply-To: <20190715124417.4787-31-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:33:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdD-g1A+LKp1Nmmho2MVRxERfXb+Q3WsBrN=7YbnVufMQ@mail.gmail.com>
Message-ID: <CAJKOXPdD-g1A+LKp1Nmmho2MVRxERfXb+Q3WsBrN=7YbnVufMQ@mail.gmail.com>
Subject: Re: [PATCH v1 30/50] ARM: dts: exynos: add bus_isp266 into Exynos5800
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
> The Exynos5420 SoC had one clock for two lines while Exynos5422/5800 have
> dedicated clock tree for the ACLK266_ISP. The max frequency is 300MHz so
> it shares the OPP table with bus_gen. The bus is added here and is enabled
> in .dts file for proper board.

Squash it with 48 please.

BR,
Krzysztof

>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5800.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
> index 57d3b319fd65..3b9200db43b6 100644
> --- a/arch/arm/boot/dts/exynos5800.dtsi
> +++ b/arch/arm/boot/dts/exynos5800.dtsi
> @@ -131,3 +131,13 @@
>  &mfc {
>         compatible = "samsung,mfc-v8";
>  };
> +
> +&soc {
> +               bus_isp266: bus_isp266 {
> +                       compatible = "samsung,exynos-bus";
> +                       clocks = <&clock CLK_DOUT_ACLK266_ISP>;
> +                       clock-names = "bus";
> +                       operating-points-v2 = <&bus_gen_opp_table>;
> +                       status = "disabled";
> +               };
> +};
> --
> 2.17.1
>
