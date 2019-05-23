Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0F2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB9F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558616028;
	bh=SERTH+SFKq066tXekGq7+Iv3lNmb4A+1H2XMyUB7QOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MQvVfgyMs92TSFZ55POdtAi/vKo3KzfIZmsJ2c4mZLkMZhz5l0qs3Hz4nGg9H7a8s
	 jEHdvglg9bCRHaO0hgSfw3klgKrMnG1UfN2hjOYikcOrDWFTfGQDe3d5mAFR9seMgF
	 My2tyvznPHSBvleVsa9t8S07PwbcfSRzgmoEC1OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfEWMxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfEWMxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:53:47 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5323B20879;
        Thu, 23 May 2019 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558616026;
        bh=SERTH+SFKq066tXekGq7+Iv3lNmb4A+1H2XMyUB7QOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RogaUuUKOP+axkjXcbYomNJxH4WFwd0Sek1udq9ymI5uj6yE9DoRvkP5VhAObPZ+w
         CJRFnlyTjaVy+vRj+oYupgt2hE5bFh21xGlbwfEu5QYtC4AvyOzp1FasrCLBvY6AGm
         iIL2hgvrzMhytD4LpYXEe7r16V/vcLvp1QbIuxMI=
Date:   Thu, 23 May 2019 20:52:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH V3 RESEND 3/4] defconfig: arm64: enable i.MX8 SCU octop
 driver
Message-ID: <20190523125235.GV9261@dragon>
References: <20190522020040.30283-1-peng.fan@nxp.com>
 <20190522020040.30283-3-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522020040.30283-3-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:47:05AM +0000, Peng Fan wrote:
> Build in CONFIG_NVMEM_IMX_OCOTP_SCU.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Please do not use base64 encoding for patch posting.

Shawn

> ---
> 
> V3:
>  No change
> V2:
>  rename patch title, add review tag
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 979a95c915b6..32b85102b857 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -748,6 +748,7 @@ CONFIG_HISI_PMU=y
>  CONFIG_QCOM_L2_PMU=y
>  CONFIG_QCOM_L3_PMU=y
>  CONFIG_NVMEM_IMX_OCOTP=y
> +CONFIG_NVMEM_IMX_OCOTP_SCU=y
>  CONFIG_QCOM_QFPROM=y
>  CONFIG_ROCKCHIP_EFUSE=y
>  CONFIG_UNIPHIER_EFUSE=y
> -- 
> 2.16.4
> 
