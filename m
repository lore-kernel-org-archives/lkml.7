Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B5ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90E721D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504399AbfJYMPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:15:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56379 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504376AbfJYMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:15:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iNyUn-0003GB-Qv; Fri, 25 Oct 2019 14:15:09 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iNyUm-0002Xw-N4; Fri, 25 Oct 2019 14:15:08 +0200
Date:   Fri, 25 Oct 2019 14:15:08 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        darshak.patel@einfochips.com, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, prajose.john@einfochips.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add devicetree binding for Thor96
 Board
Message-ID: <20191025121508.s6gl77cydd74aaju@pengutronix.de>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
 <20191024144235.3182-2-manivannan.sadhasivam@linaro.org>
 <20191025062659.fyze6zt4jg6uzqxz@pengutronix.de>
 <20191025071927.GA19873@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025071927.GA19873@mani>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:13:43 up 160 days, 18:31, 100 users,  load average: 0.21, 0.13,
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

Hi Manivannan,

On 19-10-25 12:49, Manivannan Sadhasivam wrote:
> 
> Hi Marco,
> 
> On Fri, Oct 25, 2019 at 08:26:59AM +0200, Marco Felsch wrote:
> > Hi Manivannan,
> > 
> > On 19-10-24 20:12, Manivannan Sadhasivam wrote:
> > > Add devicetree binding for Thor96 Board from Einfochips. This board is
> > > one of the 96Boards Consumer Edition platform powered by NXP i.MX8MQ SoC.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index 1b4b4e6573b5..8016174d5e49 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -239,6 +239,7 @@ properties:
> > >          items:
> > >            - enum:
> > >                - boundary,imx8mq-nitrogen8m # i.MX8MQ NITROGEN Board
> > > +              - einfochips,imx8mq-thor96  # i.MX8MQ Thor96 Board
> > 
> > Do we need to add a vendor patch too?
> > 
> 
> Do you mean a patch for adding vendor prefix? If yes, then I have added it
> already for AI_ML board and it is in mainline now!
> 
> https://elixir.bootlin.com/linux/v5.4-rc2/source/Documentation/devicetree/bindings/vendor-prefixes.yaml#L276

Ah, okay thanks for the hint. Feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Regards,
  Marco

> Thanks,
> Mani
> 
> > Regards,
> >   Marco
> > 
> > >                - fsl,imx8mq-evk            # i.MX8MQ EVK Board
> > >                - purism,librem5-devkit     # Purism Librem5 devkit
> > >                - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
> > > -- 
> > > 2.17.1
> > > 
> > > 
> > > 
> > 
> > -- 
> > Pengutronix e.K.                           |                             |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
