Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A88C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685542086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559716679;
	bh=nBdxQcgsl55tdFVJsUcQMLtU2Dv9DO6ibXfHPVMrREE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X08V19rYkEwmG0Zrv9Ww5soNGRNlpIlDEDB0muX2JlMBMOht9o1LM5A+wuxK8l+0s
	 tIR5i5oYSrS+t2ZN/Cas3ht68p3p6msBtQgDA2DEfBo10AapmPqLlHegM7JBAuSjJL
	 9hTM1+k4kdBmg3RIU6urnF814ZAXzZqw7xc26+X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFEGh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50973 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFEGh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:37:58 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE7A2075B;
        Wed,  5 Jun 2019 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559716677;
        bh=nBdxQcgsl55tdFVJsUcQMLtU2Dv9DO6ibXfHPVMrREE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmkNnpCxD3BDra2zyezFe5+AQt5n1xFexhouAFiUgRINOXfn1rH7bC4pY/okgz8jy
         gojBkSw2gZTSLM3DFI6hWNxyp6nloGD9g6pXMEpvqG8QJlqt9afk78hmO/aOpIQFFx
         aqR5drVM/8Mv2uW7WF4BSXuwBrWmlYDPsXeHKCW0=
Date:   Wed, 5 Jun 2019 14:37:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Add temperature sensor node
Message-ID: <20190605063741.GH29853@dragon>
References: <20190528022633.40124-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528022633.40124-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:26:33AM +0800, Yuantian Tang wrote:
> Add nxp sa56004 chip node for temperature monitor.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v2:
> 	- change the node name and add vcc-supply
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 15 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 6571d0483c7a..f12e4f510d6e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -47,6 +47,15 @@
>  		regulator-always-on;
>  	};
>  
> +	sb_3v3: regulator-sb3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v3_vbus";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	sound {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,format = "i2s";
> @@ -147,6 +156,12 @@
>  				compatible = "atmel,24c512";
>  				reg = <0x57>;
>  			};
> +
> +			temperature-sensor@4c {

Keep these i2c devices sort in unit-address order.

Shawn

> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +				vcc-supply = <&sb_3v3>;
> +			};
>  		};
>  
>  		i2c@5 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 235ca3a83dc3..e64c28983ec9 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -43,6 +43,15 @@
>  		regulator-always-on;
>  	};
>  
> +	sb_3v3: regulator-sb3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v3_vbus";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	sound {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,format = "i2s";
> @@ -132,6 +141,12 @@
>  				compatible = "nxp,pcf2129";
>  				reg = <0x51>;
>  			};
> +
> +			temperature-sensor@4c {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +				vcc-supply = <&sb_3v3>;
> +			};
>  		};
>  	};
>  };
> -- 
> 2.17.1
> 
