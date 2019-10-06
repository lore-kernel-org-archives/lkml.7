Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F0C4740A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 03:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C6D222C8
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 03:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570332041;
	bh=dzBdTkEiVVG6N8ABBCkJr3jDV3ZGX6Z7RHeYhfxkK2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jaM2W1UWBEWZKhUkpvJ0UczuJZnHXEn+YBj9veCNSs2B0wODrQm77T0y7eA8UUM97
	 V9S1kJS3F8H1hSqAjAC2PneTouuhsmzS9e+cr8MFu/zK8eNMQhl5Ln2rx7KBhPFwWv
	 xU7zXLhe19OWvRJTN6XVW2iuArtwEar0bYY2Y73I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfJFDUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 23:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfJFDUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 23:20:39 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48DE6222C0;
        Sun,  6 Oct 2019 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570332038;
        bh=dzBdTkEiVVG6N8ABBCkJr3jDV3ZGX6Z7RHeYhfxkK2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkYxZqhwCqTCMuy2dDzBQ8HTOiYLjcaQfEfB7SalRfLDFNVFVUjTsGhYnT1ZDx1Z0
         uVstFhOZmUPpYBwCa8XqVUPdtonvkQoOUIKAN73TSe8ptn6stNY4OBYgI3tG/NcCQB
         gKyDtyvkZgAxz3XEFTwqyg1bZ9/VhErEven15gN4=
Date:   Sun, 6 Oct 2019 11:20:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ashish Kumar <Ashish.Kumar@nxp.com>
Cc:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: Add FlexSPI support for NXP LS1028
Message-ID: <20191006032019.GP7150@dragon>
References: <1568118055-9740-1-git-send-email-Ashish.Kumar@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568118055-9740-1-git-send-email-Ashish.Kumar@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:50:51PM +0530, Ashish Kumar wrote:
> Add fspi node property for LS1028A SoC for FlexSPI driver.
> Property added for FlexSPI controller and for the connected
> slave device for the LS1028ARDB and LS1028AQDS target.
> RDB and QDS is having one SPI-NOR flash device, mt35xu02g
> connected at CS0.
> This flash device "mt35xu02g" is tested for octal read
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>

When you send a patch series, the patches should be numbered properly
and preferably with a cover-letter.

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 15 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 15 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 13 +++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 5e14e5a..5d46993 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -103,6 +103,21 @@
>  	status = "okay";
>  };
>  
> +&fspi {
> +	status = "okay";

Have a newline between properties and child node..

> +	flash0: mt35xu02g@0 {

Use a generic node name and specific label name.

> +		compatible = "micron,mt35xu02g", "jedec,spi-nor";

"micron,mt35xu02g" is undocumented.

Shawn

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
> +		spi-rx-bus-width = <8>; /* 8 SPI Rx lines */
> +		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 1a69221..f33cb2e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -96,6 +96,21 @@
>  	status = "okay";
>  };
>  
> +&fspi {
> +	status = "okay";
> +	flash0: mt35xu02g@0 {
> +		compatible = "micron,mt35xu02g", "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
> +		spi-rx-bus-width = <8>; /* 8 SPI Rx lines */
> +		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index b139b29..4aa1825 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -174,6 +174,19 @@
>  			clocks = <&sysclk>;
>  		};
>  
> +		fspi: spi@20c0000 {
> +			compatible = "nxp,lx2160a-fspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x20c0000 0x0 0x10000>,
> +			      <0x0 0x20000000 0x0 0x10000000>;
> +			reg-names = "fspi_base", "fspi_mmap";
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "fspi_en", "fspi";
> +			status = "disabled";
> +		};
> +
>  		i2c0: i2c@2000000 {
>  			compatible = "fsl,vf610-i2c";
>  			#address-cells = <1>;
> -- 
> 2.7.4
> 
