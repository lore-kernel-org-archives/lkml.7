Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6095920850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566717535;
	bh=u6TLqqJcw4RRZYE1Dwc3608YvdXfn/16/oY6owKULKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uNVOL8BF6Db7Zs8qTOhYgmSue7u9fRS+z3PL0vY4yhCpw3jebmF+WrFJWZY15hqTY
	 kSR/qMtP60tI76BfWLLcOPghwu/9i6VgKrJd/SP1fVPA7NXWv1lR2lv9OGrewimfKk
	 rIHfRVcPNg9eliH/flAB5nzkHG00GyRm9asRNzQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfHYHSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 03:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfHYHSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 03:18:53 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE5320850;
        Sun, 25 Aug 2019 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566717532;
        bh=u6TLqqJcw4RRZYE1Dwc3608YvdXfn/16/oY6owKULKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpqiCHhhQVcAodn5otYYU6uJQEXGEs0kEj6qlIrotDBfSjTrMiBtOTakQxQ4suz34
         7CHm6q3dDdR681aQ+qCZQxH7idgCMqIkQTKd2fuLLpkZf+PBv6VB+KR9xLX880OmrO
         k7W7bL4zTYZlwkQSeVDToLuJdqx0+t/qGkjrFm1Y=
Date:   Sun, 25 Aug 2019 09:18:40 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Use generic names for DT
 nodes
Message-ID: <20190825071839.GC5292@X250.getinternet.no>
References: <20190824002747.14610-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824002747.14610-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 05:27:47PM -0700, Andrey Smirnov wrote:
> The devicetree specification recommends using generic node names.
> 
> Some ZII dts files already follow such recommendation, but some don't,
> so use generic node names for consistency among the ZII dts files.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

It doesn't apply to my branch.

Shawn

> ---
>  arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> index 45a978defbdc..6edd682dbd29 100644
> --- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> +++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> @@ -417,7 +417,7 @@
>  	pinctrl-0 = <&pinctrl_dspi1>;
>  	status = "okay";
>  
> -	spi-flash@0 {
> +	flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		compatible = "jedec,spi-nor";
> @@ -430,7 +430,7 @@
>  		};
>  	};
>  
> -	spi-flash@1 {
> +	flash@1 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		compatible = "jedec,spi-nor";
> @@ -519,7 +519,7 @@
>  		#gpio-cells = <2>;
>  	};
>  
> -	lm75@48 {
> +	temp-sensor@48 {
>  		compatible = "national,lm75";
>  		reg = <0x48>;
>  	};
> @@ -534,7 +534,7 @@
>  		reg = <0x52>;
>  	};
>  
> -	ds1682@6b {
> +	elapsed-time-recorder@6b {
>  		compatible = "dallas,ds1682";
>  		reg = <0x6b>;
>  	};
> @@ -551,7 +551,7 @@
>  		reg = <0x38>;
>  	};
>  
> -	adt7411@4a {
> +	adc@4a {
>  		compatible = "adi,adt7411";
>  		reg = <0x4a>;
>  	};
> @@ -563,7 +563,7 @@
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	status = "okay";
>  
> -	gpio9: sx1503q@20 {
> +	gpio9: io-expander@20 {
>  		compatible = "semtech,sx1503q";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_sx1503_20>;
> @@ -574,12 +574,12 @@
>  		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
>  	};
>  
> -	lm75@4e {
> +	temp-sensor@4e {
>  		compatible = "national,lm75";
>  		reg = <0x4e>;
>  	};
>  
> -	lm75@4f {
> +	temp-sensor@4f {
>  		compatible = "national,lm75";
>  		reg = <0x4f>;
>  	};
> @@ -591,17 +591,17 @@
>  		reg = <0x23>;
>  	};
>  
> -	adt7411@4a {
> +	adc@4a {
>  		compatible = "adi,adt7411";
>  		reg = <0x4a>;
>  	};
>  
> -	at24c08@54 {
> +	eeprom@54 {
>  		compatible = "atmel,24c08";
>  		reg = <0x54>;
>  	};
>  
> -	tca9548@70 {
> +	i2c-mux@70 {
>  		compatible = "nxp,pca9548";
>  		pinctrl-names = "default";
>  		#address-cells = <1>;
> @@ -639,7 +639,7 @@
>  		};
>  	};
>  
> -	tca9548@71 {
> +	i2c-mux@71 {
>  		compatible = "nxp,pca9548";
>  		pinctrl-names = "default";
>  		reg = <0x71>;
> -- 
> 2.21.0
> 
