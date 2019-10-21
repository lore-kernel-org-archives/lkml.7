Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0ACCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893782070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfJUJuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:50:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38393 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfJUJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:50:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMUKM-0003je-1U; Mon, 21 Oct 2019 11:50:14 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMUKL-00040z-BG; Mon, 21 Oct 2019 11:50:13 +0200
Date:   Mon, 21 Oct 2019 11:50:13 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
Message-ID: <20191021095013.3lm2slv6glqx5nnh@pengutronix.de>
References: <1571649512-24041-1-git-send-email-peng.fan@nxp.com>
 <20191021094420.wmy5w2tp532dibqm@pengutronix.de>
 <AM0PR04MB448170DA0486707775C3DABA88690@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB448170DA0486707775C3DABA88690@AM0PR04MB4481.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:47:55 up 156 days, 16:06, 98 users,  load average: 0.06, 0.09,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-21 09:46, Peng Fan wrote:
> > Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for
> > fec1
> > 
> > Hi,
> > 
> > On 19-10-21 09:21, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > We should not rely on U-Boot to configure the phy reset.

nitpick: s/U-Boot/bootloader/ ?

> > > So introduce phy-reset-gpios property to let Linux handle phy reset
> > > itself.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > index faefb7182af1..e4d66f7db09d 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > @@ -80,6 +80,7 @@
> > >  	pinctrl-0 = <&pinctrl_fec1>;
> > >  	phy-mode = "rgmii-id";
> > >  	phy-handle = <&ethphy0>;
> > > +	phy-reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> > 
> > Where is the pinctrl done?
> 
> https://elixir.bootlin.com/linux/v5.4-rc2/source/arch/arm64/boot/dts/freescale/imx8mm-evk.dts#L328

Thanks :)

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de> 

Regards,
  Marco 

> Regards,
> Peng.
> 
> > 
> > Regards,
> >   Marco
> > 
> > >  	fsl,magic-packet;
> > >  	status = "okay";
> > >
> > > --
> > > 2.16.4
> > >
> > >
> > >
> > 
> > --
> > Pengutronix e.K.                           |
> > |
> > Industrial Linux Solutions                 |
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.p
> > engutronix.de%2F&amp;data=02%7C01%7Cpeng.fan%40nxp.com%7Cb40bb6
> > 4c5e39449ade4808d7560b43ca%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> > 7C0%7C0%7C637072478688921047&amp;sdata=xZI60uyyQ%2BkX%2Fpf07n
> > CgVhGt1ApYBKSnndGB3Dk2578%3D&amp;reserved=0  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> > |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> > +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
