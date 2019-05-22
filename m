Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F4BC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881C9208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfEVJd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:33:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45113 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEVJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:33:28 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hTNcf-0006MM-Fp; Wed, 22 May 2019 11:33:21 +0200
Message-ID: <1558517601.2624.32.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Chris Healy <cphealy@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 11:33:21 +0200
In-Reply-To: <20190522071227.31488-3-andrew.smirnov@gmail.com>
References: <20190522071227.31488-1-andrew.smirnov@gmail.com>
         <20190522071227.31488-3-andrew.smirnov@gmail.com>
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

Hi Andrey,

Am Mittwoch, den 22.05.2019, 00:12 -0700 schrieb Andrey Smirnov:
> Cabling used to connect devices to USBH1 on RDU2 does not meet USB
> spec cable quality and cable length requirements to operate at High
> Speed, so limit the port to Full Speed only.

Really? I thought this issue is specific to the RDU1, but you've been
looking at this USB stuff for a lot longer than me.

Regards,
Lucas

> Reported-by: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 5484e4b87975..3b37fe68d373 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -772,6 +772,7 @@
>  &usbh1 {
>  	vbus-supply = <&reg_5p0v_main>;
>  	disable-over-current;
> +	maximum-speed = "full-speed";
>  	status = "okay";
>  };
>  
