Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2CCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C076422527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfLLQZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:25:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33939 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfLLQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:25:27 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ifRHH-0006AE-6g; Thu, 12 Dec 2019 17:25:23 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1ifRHG-0007WR-Md; Thu, 12 Dec 2019 17:25:22 +0100
Date:   Thu, 12 Dec 2019 17:25:22 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Enable egalax touch screen
Message-ID: <20191212162522.irg6pg4fhgxwkp53@pengutronix.de>
References: <20191212160220.2265521-1-sjoerd.simons@collabora.co.uk>
 <20191212160722.wgqjeeknvm257hwi@pengutronix.de>
 <e9c3d1d5f8b57d92e5823f74762a2de2b20f8e88.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c3d1d5f8b57d92e5823f74762a2de2b20f8e88.camel@collabora.co.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:24:04 up 27 days,  7:42, 37 users,  load average: 0.03, 0.03,
 0.05
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-12 17:22, Sjoerd Simons wrote:
> On Thu, 2019-12-12 at 17:07 +0100, Marco Felsch wrote:
> > Hi Sjoerd,
> > 
> > On 19-12-12 17:02, Sjoerd Simons wrote:
> > > Sabrelite boards can have an lvds screen attached with a built-in
> > > i2c touch
> > > screen. Enable this in the dtsi.
> > 
> > Can this be any screen available on the market?
> 
> I guess i should have been more clear here; This is the touchscreen in
> the hannstar display (already part of the dts) that was sold as an
> accessoiry to the sabrelite.

That is more clear =) Pls can you add this to the commit message?

> 
> Same as the screen that can be used on the boundary nitrogen6 boards
> (which do have the touch part already enabled in the dts)
> 
> > 
> > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > > ---
> > > 
> > >  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > index 8468216dae9b..382b127b2251 100644
> > > --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > @@ -416,6 +416,14 @@ &i2c3 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_i2c3>;
> > >  	status = "okay";
> > > +
> > > +	touchscreen@4 {
> > > +		compatible = "eeti,egalax_ts";
> > > +		reg = <0x04>;
> > > +		interrupt-parent = <&gpio1>;
> > > +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> > > +		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> > 
> > The wakeup-gpio and the irq-line are sharing the same gpio line?

Lastly should we add a own pinctrl entry for the touchscreen?

Regards,
  Marco

> > 
> > Regards,
> >   Marco 
> > 
> > > +	};
> > >  };
> > >  
> > >  &iomuxc {
> > > -- 
> > > 2.24.0
> > > 
> > > 
> > > 
> -- 
> Sjoerd Simons
> Collabora Ltd.
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
