Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27C9218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfCUMnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:43:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34673 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfCUMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:43:15 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h6x2O-0005BL-5C; Thu, 21 Mar 2019 13:43:12 +0100
Message-ID: <1553172191.4806.38.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>, Abel Vesa <abel.vesa@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <Support.Opensource@diasemi.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 21 Mar 2019 13:43:11 +0100
In-Reply-To: <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
         <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
         <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
         <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
         <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
         <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 21.03.2019, 08:17 -0300 schrieb Fabio Estevam:
> Hi Abel,
> 
> > On Thu, Mar 21, 2019 at 5:42 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> 
> > > It seems we have other boards that need to be fixed and we can not
> > > have an old dtb with functional Ethernet with a new kernel.
> > > 
> > > Does anyone know if this issue is AR8031 specific?
> > 
> > I can confirm the same fix is works on imx6sx too.
> 
> imx6sx-sabresd also uses an AR8031 Ethernet PHY.
> 
> I also tested that changing the phy-mode to "rgmii-id" fixes Ethernet
> on pico-imx7d with AR8035.
> 
> So yes, we currently have lots of broken dtb's in mainline and I am
> wondering what is the proper fix here.

Fix the DT. It's unfortunate the a kernel and DT bug canceled each
other out, but if the DT is clearly broken and fixing it in a backward
compatible way is not really feasible, I would argue that we should
treat a DT bug like any other bug.

Regards,
Lucas
