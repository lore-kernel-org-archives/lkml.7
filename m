Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CB9C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104472089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559787517;
	bh=jPhjz3SJtpJ0/jkTHGUxExTd7E6N9MYmbVa4lf1c1qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zKx9OOuLTe8O9ZW03J7goY35Ht9UavTwdH4ty2jXp/28VN0TC9BgYQ4njAMqOAwsy
	 DN5pcgbUcoMkvoHgmwd46eLdpRe4MsQj2z4KVvHkeCgQsyevYlHMwVVdLUPwm0vwHq
	 nSgSfZx/4YBftzzJYsUqzH3mNhMEZh3Uusp54fOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFFCSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfFFCSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:18:35 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44EF2075B;
        Thu,  6 Jun 2019 02:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559787515;
        bh=jPhjz3SJtpJ0/jkTHGUxExTd7E6N9MYmbVa4lf1c1qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tx77BCu7F5RhelD9SSq0df4I0jWlsUT2lOTZRjCwaZqODpKUomkIQ26UWy8PfrQI1
         eF/o76e5/W7yMBm40XVBo01ZxwtOAq+2sP3IpFZaNPZk2JU4+9rPg2sBPODr+0ea9i
         RHb1wgcbAdGs8NkMV7xMZNOlMXV6wbbjeIErV08k=
Date:   Thu, 6 Jun 2019 10:18:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, viresh.kumar@linaro.org, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mm: Move gic node into soc node
Message-ID: <20190606021803.GW29853@dragon>
References: <20190603015020.41410-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603015020.41410-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:50:20AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> GIC is inside of SoC from architecture perspective, it should
> be located inside of soc node in DT.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

It doesn't apply to my imx/dt64 branch.  Please generate it against that
branch for my for-next.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index dc99f45..429312e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -169,15 +169,6 @@
>  		clock-output-names = "clk_ext4";
>  	};
>  
> -	gic: interrupt-controller@38800000 {
> -		compatible = "arm,gic-v3";
> -		reg = <0x0 0x38800000 0 0x10000>, /* GIC Dist */
> -		      <0x0 0x38880000 0 0xC0000>; /* GICR (RD_base + SGI_base) */
> -		#interrupt-cells = <3>;
> -		interrupt-controller;
> -		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> @@ -739,6 +730,15 @@
>  			dma-names = "rx-tx";
>  			status = "disabled";
>  		};
> +
> +		gic: interrupt-controller@38800000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x38800000 0x10000>, /* GIC Dist */
> +			      <0x38880000 0xc0000>; /* GICR (RD_base + SGI_base) */
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  
>  	usbphynop1: usbphynop1 {
> -- 
> 2.7.4
> 
