Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED3BC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D072720862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558598514;
	bh=iGHQJBYwVcFjE73/eLXU8i02Shdf1r/OQvonS87T6bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GvrKUnr7E0NnBUdUO118hvTreI+o6B4/U+Pro1ymarnTzpMEzailNyAGHzlCe/ms0
	 keNS3DOa1ErJdBqgkgKC9WbglHtZeS8n6mVtmu0N/S0OmqBgIs3K8eUd1KKU4ibCHw
	 /SrOxdVO9wc2gXobuNefK1hUmtdEV8ixl4tM5u3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfEWIBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWIBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:01:52 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46FD20862;
        Thu, 23 May 2019 08:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558598511;
        bh=iGHQJBYwVcFjE73/eLXU8i02Shdf1r/OQvonS87T6bI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTaV/UQzvpTJ37ykpnlv2M57xZAIk4HIfVuw5Oh0W9cJK5eLkjrfRjjjLLaBWYkPj
         tP/A1I5UZte6ioC9PcP0TsabyKeOpt7PeABtvwHQahS62rNv73Ln9OP2R/spIOSkyF
         OlIUOqPpW/HgVyGawc5xkZ7k34yEDpugSW6hQ/AI=
Date:   Thu, 23 May 2019 16:00:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] arm64: dts: ls1028a: add flexspi nodes
Message-ID: <20190523080049.GI9261@dragon>
References: <20190515110924.13726-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515110924.13726-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:09:25AM +0000, Xiaowei Bao wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add fspi node property for LS1028A SoC for FlexSPI driver.
> Property added for the FlexSPI controller and for the connected
> slave device for the LS1028ARDB and LS1028AQDS target.
> This is having one SPI-NOR flash device, mt35xu02g connected at
> CS0.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - modify the commit message and the dts format.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |   15 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   15 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   12 ++++++++++++
>  3 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 5bcd491..6e12806 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -158,6 +158,21 @@
>  	};
>  };
>  
> +&fspi {

Keep the labeling node sort alphabetically.  That said, &fspi should be
added before &i2c0.

> +	status = "okay";

Please have newline between property and child node.

> +	mt35xu02g: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,m25p80";

Please start properties with compatible.

> +		m25p,fast-read;
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
> +		spi-rx-bus-width = <8>; /* 8 SPI Rx lines */
> +		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
> +	};
> +};
> +
>  &sai1 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 25d2370..5d39616 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -136,6 +136,21 @@
>  	};
>  };
>  
> +&fspi {
> +	status = "okay";
> +	mt35xu02g: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
> +		spi-rx-bus-width = <8>; /* 8 SPI Rx lines */
> +		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
> +	};
> +};
> +
>  &duart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index ba71a33..a27cd60 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -109,6 +109,18 @@
>  		};
>  	};
>  
> +	fspi: spi@20c0000 {

Are you sure you want to add this device node outside of 'soc' node?

> +		compatible = "nxp,lx2160a-fspi", "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x0 0x20c0000 0x0 0x10000>,
> +		    <0x0 0x20000000 0x0 0x10000000>;

Fix the indentation to git it aligned with above '<'.

> +		reg-names = "FSPI", "FSPI-memory";
> +		interrupts = <0 25 0x4>; /* Level high type */

interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;

Shawn

> +		clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +		clock-names = "fspi_en", "fspi";
> +	};
> +
>  	soc: soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> -- 
> 1.7.1
> 
