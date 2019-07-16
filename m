Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B4C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4690F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfGPP6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:58:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52773 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:58:16 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hnPqC-00053c-JT; Tue, 16 Jul 2019 17:58:08 +0200
Message-ID: <1563292685.2676.12.camel@pengutronix.de>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Add sai3 and sai6 nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andra Danciu <andradanciu1997@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>, andrew.smirnov@gmail.com,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 16 Jul 2019 17:58:05 +0200
In-Reply-To: <CAEnQRZCoOyyZVs0=BjXB5=wYe3XW9GOF9JvwjhSU9BsChh08uA@mail.gmail.com>
References: <20190702132353.18632-1-andradanciu1997@gmail.com>
         <9ea5109f8645c3f27a9e350c5f9b2d4c@www.akkea.ca>
         <CAEnQRZDCpPju7xBBY9=e0dWt=A9c3t3g88pEw+teoZmmOiiKXQ@mail.gmail.com>
         <9e196ce51eac9ce9c327198c4a2911a8@www.akkea.ca>
         <CAEnQRZCoOyyZVs0=BjXB5=wYe3XW9GOF9JvwjhSU9BsChh08uA@mail.gmail.com>
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

Hi Daniel,

Am Mittwoch, den 03.07.2019, 16:25 +0300 schrieb Daniel Baluta:
> > On Wed, Jul 3, 2019 at 4:12 PM Angus Ainslie <angus@akkea.ca> wrote:
> > 
> > Hi Daniel,
> > 
> > On 2019-07-03 07:10, Daniel Baluta wrote:
> > > > > > On Wed, Jul 3, 2019 at 4:01 PM Angus Ainslie <angus@akkea.ca> wrote:
> > > > 
> > > > Hi Andra,
> > > > 
> > > > I tried this out on linux-next and I'm not able to record or play
> > > > sound.
> > > > 
> > > > I also added the sai2 entry to test out our devkit and get a PCM
> > > > timeout
> > > > with that.
> > > 
> > > Hi Angus,
> > > 
> > > There are still lots of SAI patches that need to be upstream. Me and
> > > Andra
> > > will be working on that over this summer.
> > > 
> > > > 
> > > > On 2019-07-02 07:23, Andra Danciu wrote:
> > > > > SAI3 and SAI6 nodes are used to connect to an external codec.
> > > > > They have 1 Tx and 1 Rx dataline.
> > > > > 
> > > > > > > > > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > > > > > > > > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > > > > ---
> > > > > Changes since v2:
> > > > >       - removed multiple new lines
> > > > > 
> > > > > Changes since v1:
> > > > >       - Added sai3 node because we need it to enable audio on pico-pi-8m
> > > > >       - Added commit description
> > > > > 
> > > > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29
> > > > > +++++++++++++++++++++++++++++
> > > > >  1 file changed, 29 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > index d09b808eff87..736cf81b695e 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > @@ -278,6 +278,20 @@
> > > > >                       #size-cells = <1>;
> > > > >                       ranges = <0x30000000 0x30000000 0x400000>;
> > > > > 
> > > > > > > > > > +                     sai6: sai@30030000 {
> > > > > +                             compatible = "fsl,imx8mq-sai",
> > > > 
> > > > I don't find this compatible string in sound/soc/fsl/fsl_sai.c. Aren't
> > > > the registers at a different offset from "fsl,imx6sx-sai".
> > > 
> > > Yes, you are right on this. We are trying to slowly push all our
> > > internal-tree
> > > patches to mainline. Obviously, with started with low hanging fruits,
> > > DTS
> > > nodes and small SAI fixes.
> > > 
> > > Soon, we will start to send patches for SAI IP ipgrade for imx8.
> > > 
> > > > 
> > > > How is this supposed to work ?
> > > > 
> > > 
> > > For the moment it won't work unless we will upstream all our SAI
> > > internal patches.
> > > But we will get there hopefully this summer.
> > > 
> > 
> > Shouldn't a working driver be upstream before enabling it in the
> > devicetree ?
> 
> I see your point here and maybe your suggestion is the ideal
> way to do things.
> 
> Anyhow, I don't see a problem with adding the node in dts
> because CONFIG_FSL_SAI is not set in the default config.
> 
> We try to speedup the upstreaming process giving the fact
> that SAI patches will go through audio maintainer's tree and
> the DTS patches will most likely go through Shawn's tree.

I've also looked at adding audio support to one of the custom boards I
have here and was caught a bit off guard by the fact that the SAI
driver is totally broken for i.MX8M due to missing patches, as I
assumed the necessary bits are in place before the DT patches are
landed. It's certainly not how things are usually done.

This also means the DT description of the SAI nodes is wrong, as they
are actually not compatible to the "fsl,imx6sx-sai". The register
layout is moved around, so there is no point in claiming any backwards
compat with the old SAI version.

Do you have an ETA when the necessary patches for the i.MX8M SAI will
be available for test and review?

Regards,
Lucas

