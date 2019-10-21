Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BAECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0292089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571636253;
	bh=rYGQeqsJPmotORjTgIXMR9GiDSnyQMdFlYoFFuDkjIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aW8rTuNZcx0816kMK4YyMjT3qzIq80CHm7YBPMXg85FHTMhc9o81CsLDZ+Vtmm8wP
	 gNjwnM1UY9Yj2HPol61G3CfuPOIXNxt35CNJlzbhxeTDtrNo+cawuHDLtFdpY3OMxX
	 BJDMJwCTvZ7FdQMAUm9IhHekiAZym1lhJg+5IO3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfJUFhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfJUFhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:37:31 -0400
Received: from localhost (unknown [122.167.89.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E232086D;
        Mon, 21 Oct 2019 05:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571636251;
        bh=rYGQeqsJPmotORjTgIXMR9GiDSnyQMdFlYoFFuDkjIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcSvVDq2D+Z9ItAp5g2FBjhLRY4YTAtCMZFmkn1l1uErNzh7j+HwDr5rUdM/snzvy
         BzJ6h/NJb18FXsHdgMcTNH3i4ET/jT7VBHC3H66OzFRPr6ckheBLy8UHESO5Ur3lJ5
         8mvJByyyLMHbLlV4AgsX22aXZ2mPDgBmUelrpsYA=
Date:   Mon, 21 Oct 2019 11:07:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm watchdog driver
Message-ID: <20191021053725.GC2654@vkoul-mobl>
References: <20191021035603.4186317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021035603.4186317-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-19, 20:56, Bjorn Andersson wrote:
> Enable the driver for the watchdog found in the application processor
> subsystem on most modern Qualcomm platforms.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

With this and the node patch, I was able to test wdt on db845c:

Tested-by: Vinod Koul <vkoul@kernel.org>


> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4591bf1303da..f3d95f77fb0d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -463,6 +463,7 @@ CONFIG_IMX2_WDT=y
>  CONFIG_IMX_SC_WDT=m
>  CONFIG_MESON_GXBB_WATCHDOG=m
>  CONFIG_MESON_WATCHDOG=m
> +CONFIG_QCOM_WDT=m
>  CONFIG_RENESAS_WDT=y
>  CONFIG_UNIPHIER_WATCHDOG=y
>  CONFIG_BCM2835_WDT=y
> -- 
> 2.23.0

-- 
~Vinod
