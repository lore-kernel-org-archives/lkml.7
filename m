Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B49DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28666206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfGOKzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:55:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42465 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbfGOKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:55:44 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hmydq-0006Ux-KD; Mon, 15 Jul 2019 12:55:34 +0200
Message-ID: <1563188134.2307.8.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mq-librem5: Enable MIPI D-PHY
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Jul 2019 12:55:34 +0200
In-Reply-To: <f80df8fcae320eb6eb4937fb5a07799fc610adae.1563187253.git.agx@sigxcpu.org>
References: <cover.1563187253.git.agx@sigxcpu.org>
         <f80df8fcae320eb6eb4937fb5a07799fc610adae.1563187253.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
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

Am Montag, den 15.07.2019, 12:43 +0200 schrieb Guido Günther:
> This enables the Mixel MIPI D-PHY on the Librem 5 devkit
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Acked-by: Angus Ainslie (Purism) <angus@akkea.ca>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 5179e22f5126..683a11035643 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -174,6 +174,10 @@
>  	assigned-clock-rates = <786432000>, <722534400>;
>  };
>  
> +&dphy {
> +	status = "okay";
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
