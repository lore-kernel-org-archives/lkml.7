Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7AEC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7AE20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE2I1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:27:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34567 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfE2I1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:27:34 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hVtvm-0006WQ-1o; Wed, 29 May 2019 10:27:30 +0200
Message-ID: <1559118449.4039.18.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] ARM: dts: imx6: rdu2: Disable WP for USDHC2 and
 USDHC3
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Chris Healy <cphealy@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 May 2019 10:27:29 +0200
In-Reply-To: <20190529071843.24767-2-andrew.smirnov@gmail.com>
References: <20190529071843.24767-1-andrew.smirnov@gmail.com>
         <20190529071843.24767-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 29.05.2019, 00:18 -0700 schrieb Andrey Smirnov:
> RDU2 production units come with resistor connecting WP pin to
> correpsonding GPIO DNPed for both SD card slots. Drop any WP related
> configuration and mark both slots with "disable-wp".
> 
> > Reported-by: Chris Healy <cphealy@gmail.com>
> > Reviewed-by: Chris Healy <cphealy@gmail.com>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 07e21d1e5b4c..04d4d4d7e43c 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -658,7 +658,7 @@
> >  	pinctrl-0 = <&pinctrl_usdhc2>;
> >  	bus-width = <4>;
> >  	cd-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
> > -	wp-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> > +	disable-wp;
> >  	vmmc-supply = <&reg_3p3v_sd>;
> >  	vqmmc-supply = <&reg_3p3v>;
> >  	no-1-8-v;
> @@ -671,7 +671,7 @@
> >  	pinctrl-0 = <&pinctrl_usdhc3>;
> >  	bus-width = <4>;
> >  	cd-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> > -	wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
> > +	disable-wp;
> >  	vmmc-supply = <&reg_3p3v_sd>;
> >  	vqmmc-supply = <&reg_3p3v>;
> >  	no-1-8-v;
> @@ -1096,7 +1096,6 @@
> > >  			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
> > >  			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
> > >  			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
> > > -			MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x40010040
> > >  			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x40010040
> >  		>;
> >  	};
> @@ -1109,7 +1108,6 @@
> > >  			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
> > >  			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
> > >  			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
> > > -			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x40010040
> > >  			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x40010040
>  
> >  		>;
