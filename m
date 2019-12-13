Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B04AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7D1206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLMJED convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:04:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54256 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLMJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:04:03 -0500
Received: from beast.luon.net (unknown [IPv6:2001:470:78b1:0:40e2:7ff:fef4:3122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A12F528ECCE;
        Fri, 13 Dec 2019 09:04:00 +0000 (GMT)
Received: by beast.luon.net (Postfix, from userid 1000)
        id 63AE63E1F0D; Fri, 13 Dec 2019 10:03:57 +0100 (CET)
Message-ID: <a16cabd53ec24dfab7d8a53cab761f019a6d988f.camel@collabora.co.uk>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Enable egalax touch screen
From:   Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Dec 2019 10:03:57 +0100
In-Reply-To: <20191212162522.irg6pg4fhgxwkp53@pengutronix.de>
References: <20191212160220.2265521-1-sjoerd.simons@collabora.co.uk>
         <20191212160722.wgqjeeknvm257hwi@pengutronix.de>
         <e9c3d1d5f8b57d92e5823f74762a2de2b20f8e88.camel@collabora.co.uk>
         <20191212162522.irg6pg4fhgxwkp53@pengutronix.de>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-12 at 17:25 +0100, Marco Felsch wrote:
> On 19-12-12 17:22, Sjoerd Simons wrote:
> > On Thu, 2019-12-12 at 17:07 +0100, Marco Felsch wrote:
> > > Hi Sjoerd,
> > > 
> > > On 19-12-12 17:02, Sjoerd Simons wrote:
> > > > Sabrelite boards can have an lvds screen attached with a built-
> > > > in
> > > > i2c touch
> > > > screen. Enable this in the dtsi.
> > > 
> > > Can this be any screen available on the market?
> > 
> > I guess i should have been more clear here; This is the touchscreen
> > in
> > the hannstar display (already part of the dts) that was sold as an
> > accessoiry to the sabrelite.
> 
> That is more clear =) Pls can you add this to the commit message?

Ofcourse will do; You also made me dig up the model number etc so i'll
include that information.

> > Same as the screen that can be used on the boundary nitrogen6
> > boards
> > (which do have the touch part already enabled in the dts)
> > 
> > > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > > > ---
> > > > 
> > > >  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > > b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > > index 8468216dae9b..382b127b2251 100644
> > > > --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > > +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > > > @@ -416,6 +416,14 @@ &i2c3 {
> > > >  	pinctrl-names = "default";
> > > >  	pinctrl-0 = <&pinctrl_i2c3>;
> > > >  	status = "okay";
> > > > +
> > > > +	touchscreen@4 {
> > > > +		compatible = "eeti,egalax_ts";
> > > > +		reg = <0x04>;
> > > > +		interrupt-parent = <&gpio1>;
> > > > +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> > > > +		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> > > 
> > > The wakeup-gpio and the irq-line are sharing the same gpio line?
> 
> Lastly should we add a own pinctrl entry for the touchscreen?

Would probably make sense to do that indeed; Will have a look

Thanks for the review!

-- 
Sjoerd Simons
Collabora Ltd.
