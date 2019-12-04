Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A596EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A6C2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575430755;
	bh=Ky6bsT95qtRty+Gu8aLwwJEri2buBfTIALVlR4MSuHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YbL2gWsCvyxJcZdgZXzdfvP9l/yp6izUF1QCL2cqgecE9rAhJ9wwCEzLm1wUHBTWT
	 9ATw+A9lNljq7FRbvMqWrre9JDJNRz59vxpqcibf83hiYsbmLJd0h9iqyWIbC4aJk0
	 eHnlA+q0j/1daE6w54aF6Ic/1/Zeof83vQH1v378=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfLDDjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 22:39:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfLDDjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 22:39:14 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCEC2068E;
        Wed,  4 Dec 2019 03:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575430753;
        bh=Ky6bsT95qtRty+Gu8aLwwJEri2buBfTIALVlR4MSuHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoxJiwxD8uWYFJuQIdSZ3Z/qxFfj6napAEMB5UEQuuoKTNw5QzVbAHMWTyi5qHFIQ
         3HEgJ/TAS/sVWDiTTdwcW7YnhlhG0WyNYn2vra2Ouql2RO3VuhcovLzqNHFrLPD6IW
         y/cmK3TplVD7kfhaI7p/ygSowbyXdES+F1W3z7zw=
Date:   Wed, 4 Dec 2019 11:39:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6sll: Add Rev A board support
Message-ID: <20191204033904.GA3365@dragon>
References: <1573033650-11848-1-git-send-email-Anson.Huang@nxp.com>
 <1573033650-11848-3-git-send-email-Anson.Huang@nxp.com>
 <20191204023920.GO9767@dragon>
 <AM6PR0402MB39111817A837FD03558B0E79F55D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0402MB39111817A837FD03558B0E79F55D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 02:52:11AM +0000, Anson Huang wrote:
> 
> 
> > Subject: Re: [PATCH 3/3] ARM: dts: imx6sll: Add Rev A board support
> > 
> > On Wed, Nov 06, 2019 at 05:47:30PM +0800, Anson Huang wrote:
> > > i.MX6SLL EVK Rev A board is same with latest i.MX6SLL EVK board except
> > > eMMC can ONLY run at HS200 mode, add support for this board.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/Makefile             |  1 +
> > >  arch/arm/boot/dts/imx6sll-evk-reva.dts | 12 ++++++++++++
> > >  2 files changed, 13 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/imx6sll-evk-reva.dts
> > >
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index 71f08e7..3845bbf 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -557,6 +557,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
> > >  	imx6sl-warp.dtb
> > >  dtb-$(CONFIG_SOC_IMX6SLL) += \
> > >  	imx6sll-evk.dtb \
> > > +	imx6sll-evk-reva.dtb \
> > >  	imx6sll-kobo-clarahd.dtb
> > >  dtb-$(CONFIG_SOC_IMX6SX) += \
> > >  	imx6sx-nitrogen6sx.dtb \
> > > diff --git a/arch/arm/boot/dts/imx6sll-evk-reva.dts
> > > b/arch/arm/boot/dts/imx6sll-evk-reva.dts
> > > new file mode 100644
> > > index 0000000..7ca2563
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx6sll-evk-reva.dts
> > > @@ -0,0 +1,12 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright 2016 Freescale Semiconductor, Inc.
> > > + * Copyright 2017-2019 NXP.
> > > + *
> > > + */
> > > +
> > > +#include "imx6sll-evk.dts"
> > > +
> > > +&usdhc2 {
> > > +	compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
> > 
> > It looks odd to me that we need to deal with a board level difference with a
> > SoC level compatible.  The USDHC compatible should be solely determined by
> > the IP programming model, not the board level capability.
> 
> So how to handle such scenario? Current usdhc driver uses SoC compatible to distinguish
> different functions of uSDHC IP, if some boards can NOT support dedicated function due to
> board design regardless of the IP inside, the easy way is just to downgrade the SoC compatible,
> or need uSDHC driver to provide some DT properties for such case? 

So you are saying this is a complete board design limitation, not SoC/IP
related?  In that case, IMO, we need a board level DT property to deal
with it.

Shawn
