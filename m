Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C2AC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6226B218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfGEICo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:02:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59333 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfGEICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:02:43 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hjJAu-0001cv-SN; Fri, 05 Jul 2019 10:02:32 +0200
Message-ID: <1562313748.4291.3.camel@pengutronix.de>
Subject: Re: [PATCH V3 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Fri, 05 Jul 2019 10:02:28 +0200
In-Reply-To: <DB3PR0402MB39167B9A3CFAE6D8798B3CAEF5F50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704094416.4757-1-Anson.Huang@nxp.com>
         <1562235363.6641.10.camel@pengutronix.de>
         <DB3PR0402MB39167B9A3CFAE6D8798B3CAEF5F50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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

Hi Anson,

On Fri, 2019-07-05 at 00:26 +0000, Anson Huang wrote:
> Hi, Philipp
> 
> > On Thu, 2019-07-04 at 17:44 +0800, Anson.Huang@nxp.com wrote:
> > > From: Anson Huang <Anson.Huang@nxp.com>
> > > 
> > > i.MX8MM can reuse i.MX8MQ's reset driver, update the compatible
> > > property and related info to support i.MX8MM.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V2:
> > > 	- Add separate line for i.MX8MM in case anything different later for
> > 
> > i.MX8MM.
> > > ---
> > >  Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > index 13e0951..c2489e4 100644
> > > --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > @@ -8,6 +8,7 @@ Required properties:
> > >  - compatible:
> > >  	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
> > >  	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
> > > +	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src",
> > 
> > "syscon"
> > >  - reg: should be register base and length as documented in the
> > >    datasheet
> > >  - interrupts: Should contain SRC interrupt @@ -46,5 +47,6 @@ Example:
> > > 
> > > 
> > >  For list of all valid reset indices see
> > > -<dt-bindings/reset/imx7-reset.h> for i.MX7 and
> > > -<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
> > > +<dt-bindings/reset/imx7-reset.h> for i.MX7,
> > > +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
> > > +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MM
> > 
> > The last line is misleading, as that file contains reset indices that are invalid
> > for i.MX8MM.
> 
> What is your suggestion about this line?

I would prefer to add an imx8mm-reset.h with only the existing reset
bits, using the IMX8MM_RESET_ prefix. That would make it easy to spot
errors in the dtsi (anything starting with IMX8MQ_ is potentially
wrong).

> Just NOT change it?

The change is good in principle. It just should point to an imx8mm-
reset.h with only the existing resets on i.MX8MM, or imx8mq-reset.h
should be modified to actually make clear which resets are valid on
i.MX8MM.

> Or adding a new file imx8mm-reset.h but still use the IMX8MQ_RESET_ as
> prefix ?

I don't think you should redefine the same macros in imx8mm-reset.h. In
this case using IMX8MM_RESET_ would be better.

> Or keep what I changed, but adding some comments in those macros that
> i.MX8MM does NOT support?

That would be acceptable as well.

regards
Philipp
