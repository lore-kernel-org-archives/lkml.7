Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDCCC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C172182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563359473;
	bh=w1TbVMvUz2tK6FJesNjUIqjiZRhlXxyRUlrQtX3Zs/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ja1obZ14v0FXBKPtKWU1F2LVsFpmSv8VHZt4Vl9faAYKdNm++Cgu4ry2dq91sp6ya
	 Odvz6CHlwLO+Q4B2OS0Mm3Rz8BRmxu1w1C7EO6lt9fSJhMTRZeCFtA7dJOUKpFJOs8
	 jCc6zNj4S9FBOAB2LSYrqX09u7EIlkxz4ExXukjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfGQKbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfGQKbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:31:12 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377922184B;
        Wed, 17 Jul 2019 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563359471;
        bh=w1TbVMvUz2tK6FJesNjUIqjiZRhlXxyRUlrQtX3Zs/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1aRaZgzMNwMc/cSnLPza1zZd8YLsXbjs8yBoKnyqbgvVFefJs7HEgdAk9k2xSEOvr
         XUWnVRi6oroq7hDBml2YU8Es7DBdc4b3baiyr7cVFWvcTgsDL2WGXNEL92hwRVKOsv
         t5FZ7capFlHWNOZBKFPhMEfomGeykqsK4zlnreJ8=
Received: by mail-lj1-f172.google.com with SMTP id h10so23106754ljg.0;
        Wed, 17 Jul 2019 03:31:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUEUhQwl0msMt2C1QDsxHEGdcVaTt5XvaujeBdhd61yOz9nFk0e
        HPAvI7bb0btZyVMBxSFw1P0n0fIV4VSls96czCk=
X-Google-Smtp-Source: APXvYqwzoJ1Cxx4+M2lANaxvQqdCL3041mmaU3c52UP1ABWgSTNdykCbwT/nVHS71aYau/97TYX1+5b60Eo6CrIfc68=
X-Received: by 2002:a2e:50e:: with SMTP id 14mr20713536ljf.5.1563359469475;
 Wed, 17 Jul 2019 03:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124459eucas1p2a1d8795e57a82704ff221567a8810485@eucas1p2.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-32-l.luba@partner.samsung.com>
In-Reply-To: <20190715124417.4787-32-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:30:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf1tZMLPT9pJrM5wM5wUEMdw1iEPVjaz6K3iq17KdbAxw@mail.gmail.com>
Message-ID: <CAJKOXPf1tZMLPT9pJrM5wM5wUEMdw1iEPVjaz6K3iq17KdbAxw@mail.gmail.com>
Subject: Re: [PATCH v1 31/50] ARM: dts: exynos: align lowest OPP in bus_jpeg
 in Exynos5420
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
> Make the lowest OPP frequency possible to set using a clock divider keeping
> in mind the master clock rate.

As in previous patch - lowest->slowest. I think OPPs are not
associated with the height or altitude but speed (slow/fast). You
could also add "frequency" which would make it also correct and
specific but slightly longer in title.

Best regards,
Krzysztof

>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index f2e2e77a86d6..0be799f843dc 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1250,7 +1250,7 @@
>                         compatible = "operating-points-v2";
>
>                         opp00 {
> -                               opp-hz = /bits/ 64 <75000000>;
> +                               opp-hz = /bits/ 64 <100000000>;
>                         };
>                         opp01 {
>                                 opp-hz = /bits/ 64 <150000000>;
> --
> 2.17.1
>
