Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D97CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4406820867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572090943;
	bh=lpBqhBANauiN5UjByiLbpVHMRnCeuRYvpYYqm1oL4LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pmVjccS536eYecPVrR0mz5Xzn8L7tPy1K3OehobY/yRDLsWiHQoPFNgAXW850pW/c
	 Bubummh0GQZkMLfRy2kPDc6ESWNvtQ5EkE3wBOOFHpY10heQ8uiH5CPerOzlQL5nSU
	 AJehxn12KDfaYHD/cIBATiov/KtVvfjWozgxjP0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJZLzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfJZLzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:55:41 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29222070B;
        Sat, 26 Oct 2019 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572090941;
        bh=lpBqhBANauiN5UjByiLbpVHMRnCeuRYvpYYqm1oL4LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bnm8ct2/gE7F8AM0lmeF4dg+ROuNoYJtrIVKrc6OXPyNhfqpeSpeMHgbxgQ1QsAwo
         hk12AVYkNFiFJMzXmWRrgg2d6d4cuDoldUbsx0UIuOuJV93B58Iwrel85GubZm4GXB
         WvDhNHJPdqpoLgj2Ij3nlMMG2f4BG1+Ey3huOuzw=
Date:   Sat, 26 Oct 2019 19:55:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: zii-ultra: Add node for accelerometer
Message-ID: <20191026115524.GJ14401@dragon>
References: <20191015152654.26726-1-andrew.smirnov@gmail.com>
 <20191015152654.26726-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015152654.26726-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 08:26:53AM -0700, Andrey Smirnov wrote:
> Add I2C node for accelerometer present on both Zest and RMB3 boards.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org,
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../boot/dts/freescale/imx8mq-zii-ultra.dtsi   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> index 21eb52341ba8..8395c5a73ba6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> @@ -262,6 +262,18 @@
>  	pinctrl-0 = <&pinctrl_i2c1>;
>  	status = "okay";
>  
> +	accel@1c {

s/accel/accelerometer

I fixed it up and applied the series.

Shawn

> +		compatible = "fsl,mma8451";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_accel>;
> +		reg = <0x1c>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "INT2";
> +		vdd-supply = <&reg_gen_3p3>;
> +		vddio-supply = <&reg_gen_3p3>;
> +	};
> +
>  	ucs1002: charger@32 {
>  		compatible = "microchip,ucs1002";
>  		pinctrl-names = "default";
> @@ -522,6 +534,12 @@
>  };
>  
>  &iomuxc {
> +	pinctrl_accel: accelgrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20		0x41
> +		>;
> +	};
> +
>  	pinctrl_fec1: fec1grp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> -- 
> 2.21.0
> 
