Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7856C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FF0205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfHVKEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:04:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58739 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfHVKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:04:02 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i0jwj-00045d-JA; Thu, 22 Aug 2019 12:03:57 +0200
Message-ID: <1566468231.3653.8.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] arm64: imx8mq: add imx8mq iomux-gpr field defines
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Date:   Thu, 22 Aug 2019 12:03:51 +0200
In-Reply-To: <20190821174208.GA9486@bogon.m.sigxcpu.org>
References: <cover.1565367567.git.agx@sigxcpu.org>
         <e0562d8bb4098dc4cdb4023b41fb75b312be22a5.1565367567.git.agx@sigxcpu.org>
         <CAK8P3a3Vrd+sttJrQwD-jA9p_egG4x-hc41eGK8H-_aVm-uoYw@mail.gmail.com>
         <20190813101057.GB10751@bogon.m.sigxcpu.org>
         <CAK8P3a1q9G8VKgNKh+6khzoW3bFTVR_Zorygy=Qqsq-PYzM4=g@mail.gmail.com>
         <20190821174208.GA9486@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 19:42 +0200, Guido Günther wrote:
> Hi,
> On Tue, Aug 13, 2019 at 01:07:52PM +0200, Arnd Bergmann wrote:
> > On Tue, Aug 13, 2019 at 12:10 PM Guido Günther <agx@sigxcpu.org> wrote:
> > > On Tue, Aug 13, 2019 at 10:08:44AM +0200, Arnd Bergmann wrote:
> > > > On Fri, Aug 9, 2019 at 6:24 PM Guido Günther <agx@sigxcpu.org> wrote:
> > > > > 
> > > > > This adds all the gpr registers and the define needed for selecting
> > > > > the input source in the imx-nwl drm bridge.
> > > > > 
> > > > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > > > > +
> > > > > +#define IOMUXC_GPR0    0x00
> > > > > +#define IOMUXC_GPR1    0x04
> > > > > +#define IOMUXC_GPR2    0x08
> > > > > +#define IOMUXC_GPR3    0x0c
> > > > > +#define IOMUXC_GPR4    0x10
> > > > > +#define IOMUXC_GPR5    0x14
> > > > > +#define IOMUXC_GPR6    0x18
> > > > > +#define IOMUXC_GPR7    0x1c
> > > > 
> > > > (more of the same)
> > > > 
> > > > huh?
> > > 
> > > These are the names from the imx8MQ reference manual (general purpose
> > > registers, they lump together all sorts of things), it's the same on
> > > imx6/imx7):
> > > 
> > >     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > >     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mfd/syscon/imx7-iomuxc-gpr.h
> > > 
> > > > > +/* i.MX8Mq iomux gpr register field defines */
> > > > > +#define IMX8MQ_GPR13_MIPI_MUX_SEL              BIT(2)
> > > > 
> > > > I think this define should probably be local to the pinctrl driver, to
> > > > ensure that no other drivers fiddle with the registers manually.
> > > 
> > > The purpose of these bits is for a driver to fiddle with them to select
> > > the input source. Similar on imx7 it's already used for e.g. the phy
> > > refclk in the pci controller:
> > > 
> > >     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-imx6.c#n638
> > 
> > That one should likely use either the clk interface or the phy
> > interface instead.
> > 
> > > The GPRs are not about pad configuration but gather all sorts of things
> > > (section 8.2.4 of the imx8mq reference manual): pcie setup, dsi related
> > > bits so I don't think this should be done via a pinctrl
> > > driver. Should we handle that differently than on imx6/7?
> > 
> > It would be nice to fix the existing code as well, but for the moment,
> > I only think we should not add more of that.
> > 
> > Generally speaking, we can use syscon to do random things that don't
> > have a subsystem of their own, but we should not use it to do things
> > that have an existing driver framework like pinctrl, clock, reset, phy
> > etc.
> 
> Since it's not an external pin i opted to use MUX_MMIO instead which
> seems like a good fit here. Does that make sense?

Yes, I agree. The i.MX6 display subsystem predates the mux framework,
otherwise I would have used it for the LVDS and HDMI muxes in the first
place. We should probably switch imx-drm over as well, in a backwards
compatible fashion. The &mux definitions are already there in
arch/arm/boot/dts/imx6q.dtsi.

regards
Philipp
