Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A61C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6E321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfDWHbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:31:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40553 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDWHbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:31:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hIptx-0006tY-37; Tue, 23 Apr 2019 09:31:37 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hIptl-0007Uk-Ag; Tue, 23 Apr 2019 09:31:25 +0200
Date:   Tue, 23 Apr 2019 09:31:25 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Message-ID: <20190423073125.hd76umcjnfheohgb@pengutronix.de>
References: <20190422193542.2853-1-daniel.baluta@nxp.com>
 <20190422193542.2853-3-daniel.baluta@nxp.com>
 <20190423051738.tmyto7nvm4w5zt4r@pengutronix.de>
 <CAEnQRZD5506EdkO5ESwWe+=J-uEeZw9m47_XNj8DUHy4Hck78g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZD5506EdkO5ESwWe+=J-uEeZw9m47_XNj8DUHy4Hck78g@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:26:24 up 94 days, 12:08, 74 users,  load average: 0.12, 0.09,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 19-04-23 09:22, Daniel Baluta wrote:
> Hi Marco,
> 
> On Tue, Apr 23, 2019 at 8:19 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi Daniel,
> >
> > On 19-04-22 19:36, Daniel Baluta wrote:
> > > i.MX8MM has one wm8524 audio codec connected with
> > > SAI3 digital audio interface.
> > >
> > > This patch uses simple-card machine driver in order
> > > to enable wm8524 codec.
> > >
> > > We need to set:
> > >       * SAI3 pinctrl configuration
> > >       * clock hierarchy
> > >       * codec node
> > >       * simple-card configuration
> > >
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 48 ++++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > index 2d5d89475b76..207b13266a96 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > @@ -37,6 +37,35 @@
> > >               gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > >               enable-active-high;
> > >       };
> > > +
> > > +     wm8524: audio-codec {
> > > +             #sound-dai-cells = <0>;
> > > +             compatible = "wlf,wm8524";
> > > +             wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
> >
> > I would mux the gpio where I use them.
> 
> I'm not sure I understand this. Can you provide an example.

Just adding a princtrl-0 and pinctrl-names entry to mux the gpio here
rather than within the sai node.

> >
> > > +     };
> > > +
> > > +     sound-wm8524 {
> > > +             compatible = "simple-audio-card";
> > > +             simple-audio-card,name = "wm8524-audio";
> > > +             simple-audio-card,format = "i2s";
> > > +             simple-audio-card,frame-master = <&cpudai>;
> > > +             simple-audio-card,bitclock-master = <&cpudai>;
> > > +             simple-audio-card,widgets =
> > > +                     "Line", "Left Line Out Jack",
> > > +                     "Line", "Right Line Out Jack";
> > > +             simple-audio-card,routing =
> > > +                     "Left Line Out Jack", "LINEVOUTL",
> > > +                     "Right Line Out Jack", "LINEVOUTR";
> > > +
> > > +             cpudai: simple-audio-card,cpu {
> > > +                     sound-dai = <&sai3>;
> > > +             };
> > > +
> > > +             link_codec: simple-audio-card,codec {
> >
> > Can you drop that phandle?
> 
> I see your point here. But for symmetry and consistency with
> imx8mm-evk I would prefer
> to keep it like that.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mq-evk.dts?h=for-next#n59
> 

Got your point but I think that the evk dts will be used as base for
future dts. Instead of keep them here I would send a patch to drop the
phandle in the imx8mq-evk.dts since it isn't necessary.

Regards,
  Marco
