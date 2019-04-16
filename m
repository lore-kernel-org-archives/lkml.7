Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083BAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F682064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfDPQzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:55:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37307 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfDPQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:55:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hGRN4-0006f4-2I; Tue, 16 Apr 2019 18:55:46 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hGRN1-00050E-Th; Tue, 16 Apr 2019 18:55:43 +0200
Date:   Tue, 16 Apr 2019 18:55:43 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/2] Add support for the Purism Librem5 devkit
Message-ID: <20190416165543.hbowm2zejjdxzwc3@pengutronix.de>
References: <20190415235343.16565-1-angus@akkea.ca>
 <20190416075834.6wurd6nq4ow5woyn@pengutronix.de>
 <665773559cd9449a27fc9bc40cf73792@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665773559cd9449a27fc9bc40cf73792@www.akkea.ca>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 18:54:25 up 87 days, 21:36, 74 users,  load average: 0.18, 0.09,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-16 09:38, Angus Ainslie wrote:
> On 2019-04-16 00:58, Marco Felsch wrote:
> > Hi Agnus,
> > 
> > On 19-04-15 16:53, Angus Ainslie (Purism) wrote:
> > > The Librem5 devkit is based on the imx8mq from NXP. This is a default
> > > devicetree to boot the board to a command prompt.
> > 
> > You should also provide a patch which adds the devicetree to the yaml
> > file, see: Documentation/devicetree/bindings/arm/fsl.yaml.
> > 
> 
> Sure, what is that yaml file for ?

Thats for Rob's the validation: https://lwn.net/Articles/771621/

Regards,
  Marco

> 
> Angus
> 
> > Thanks,
> >   Marco
> > 
> > > 
> > > Changes since v3:
> > > 
> > > Freshly sorted and pressed nodes.
> > > Change the backlight to an interpolated scale.
> > > Dropped i2c2.
> > > Dropped devkit version number to match debian MR.
> > > 
> > > Changes since v2:
> > > 
> > > Fixed incorrect phy-supply for the fsl-fec.
> > > Dropped unused regulator property.
> > > Fixup Makefile for linux-next.
> > > 
> > > Changes since v1:
> > > 
> > > Dropped config file.
> > > Updated the board compatible label.
> > > Changed node names to follow naming conventions.
> > > Added a more complete regulator hierachy.
> > > Removed unused nodes.
> > > Removed unknown devices.
> > > Fixed comment style.
> > > Dropped undocumented properties.
> > > 
> > > Angus Ainslie (Purism) (2):
> > >   arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
> > >   dt-bindings: Add an entry for Purism SPC
> > > 
> > >  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
> > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > >  .../dts/freescale/imx8mq-librem5-devkit.dts   | 822
> > > ++++++++++++++++++
> > >  3 files changed, 824 insertions(+)
> > >  create mode 100644
> > > arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > > 
> > > --
> > > 2.17.1
> > > 
> > > 
> > > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
