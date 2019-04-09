Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAFBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66D920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDIH2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:28:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:4987 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfDIH2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:28:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 00:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,328,1549958400"; 
   d="scan'208";a="289953460"
Received: from lyang61-mobl3.ccr.corp.intel.com ([10.255.30.213])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2019 00:28:32 -0700
Message-ID: <1554794910.2178.6.camel@intel.com>
Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
From:   Zhang Rui <rui.zhang@intel.com>
To:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Tue, 09 Apr 2019 15:28:30 +0800
In-Reply-To: <DB3PR0402MB39161C8A34E6D45FF9003A8FF52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
         <20190227235455.GA15211@bogus>
         <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
         <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <DB3PR0402MB39166061B0712B30E443DA07F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <AM6PR0402MB39111B82FAE76449785EDF90F54A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
         <DB3PR0402MB3916A75C03F131ED3B69A455F55F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <DB3PR0402MB39161C8A34E6D45FF9003A8FF52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 二, 2019-04-09 at 05:28 +0000, Anson Huang wrote:
> Ping...
> Can anyone provide some suggestion about how to proceed next?
> 
Hi, Eduardo,

I guess you will comment on this patch, right?
Or else I will take the patch following Rob' suggestion.

thanks,
rui


> Best Regards!
> Anson Huang
> 
> > 
> > -----Original Message-----
> > From: Anson Huang
> > Sent: 2019年3月26日 10:45
> > To: 'Rob Herring' <robh@kernel.org>; 'edubezval@gmail.com'
> > <edubezval@gmail.com>
> > Cc: 'mark.rutland@arm.com' <mark.rutland@arm.com>;
> > 'shawnguo@kernel.org' <shawnguo@kernel.org>; 's.hauer@pengutronix.d
> > e'
> > <s.hauer@pengutronix.de>; 'kernel@pengutronix.de'
> > <kernel@pengutronix.de>; 'festevam@gmail.com' <festevam@gmail.com>;
> > 'catalin.marinas@arm.com' <catalin.marinas@arm.com>;
> > 'will.deacon@arm.com' <will.deacon@arm.com>; 'rui.zhang@intel.com'
> > <rui.zhang@intel.com>; 'edubezval@gmail.com' <edubezval@gmail.com>;
> > 'daniel.lezcano@linaro.org' <daniel.lezcano@linaro.org>; Aisheng
> > Dong
> > <aisheng.dong@nxp.com>; 'ulf.hansson@linaro.org'
> > <ulf.hansson@linaro.org>; 'sboyd@kernel.org' <sboyd@kernel.org>;
> > Daniel
> > Baluta <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>;
> > 'horms+renesas@verge.net.au' <horms+renesas@verge.net.au>;
> > 'heiko@sntech.de' <heiko@sntech.de>; 'arnd@arndb.de' <arnd@arndb.de
> > >;
> > 'maxime.ripard@bootlin.com' <maxime.ripard@bootlin.com>;
> > 'bjorn.andersson@linaro.org' <bjorn.andersson@linaro.org>;
> > 'jagan@amarulasolutions.com' <jagan@amarulasolutions.com>;
> > 'enric.balletbo@collabora.com' <enric.balletbo@collabora.com>;
> > 'marc.w.gonzalez@free.fr' <marc.w.gonzalez@free.fr>; 'olof@lixom.ne
> > t'
> > <olof@lixom.net>; 'devicetree@vger.kernel.org'
> > <devicetree@vger.kernel.org>; 'linux-kernel@vger.kernel.org'
> > <linux-
> > kernel@vger.kernel.org>; 'linux-arm-kernel@lists.infradead.org'
> > <linux-arm-
> > kernel@lists.infradead.org>; 'linux-pm@vger.kernel.org' <linux-
> > pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal
> > binding
> > 
> > Ping...
> > 
> > Hi, Eduardo
> > 	What is your opinion about where to put the HW resource ID in
> > DT?
> > 
> > Best Regards!
> > Anson Huang
> > 
> > > 
> > > -----Original Message-----
> > > From: Anson Huang
> > > Sent: 2019年3月13日 16:12
> > > To: 'Rob Herring' <robh@kernel.org>; 'edubezval@gmail.com'
> > > <edubezval@gmail.com>
> > > Cc: 'mark.rutland@arm.com' <mark.rutland@arm.com>;
> > > 'shawnguo@kernel.org' <shawnguo@kernel.org>;
> > 's.hauer@pengutronix.de'
> > > 
> > > <s.hauer@pengutronix.de>; 'kernel@pengutronix.de'
> > > <kernel@pengutronix.de>; 'festevam@gmail.com' <festevam@gmail.com
> > > >;
> > > 'catalin.marinas@arm.com' <catalin.marinas@arm.com>;
> > > 'will.deacon@arm.com' <will.deacon@arm.com>; 'rui.zhang@intel.com
> > > '
> > > <rui.zhang@intel.com>; 'edubezval@gmail.com' <edubezval@gmail.com
> > > >;
> > > 'daniel.lezcano@linaro.org' <daniel.lezcano@linaro.org>; Aisheng
> > > Dong
> > > <aisheng.dong@nxp.com>; 'ulf.hansson@linaro.org'
> > > <ulf.hansson@linaro.org>; 'sboyd@kernel.org' <sboyd@kernel.org>;
> > > Daniel Baluta <daniel.baluta@nxp.com>; Andy Gross
> > > <andy.gross@linaro.org>; 'horms+renesas@verge.net.au'
> > > <horms+renesas@verge.net.au>; 'heiko@sntech.de' <heiko@sntech.de>
> > > ;
> > > 'arnd@arndb.de' <arnd@arndb.de>; 'maxime.ripard@bootlin.com'
> > > <maxime.ripard@bootlin.com>; 'bjorn.andersson@linaro.org'
> > > <bjorn.andersson@linaro.org>; 'jagan@amarulasolutions.com'
> > > <jagan@amarulasolutions.com>; 'enric.balletbo@collabora.com'
> > > <enric.balletbo@collabora.com>; 'marc.w.gonzalez@free.fr'
> > <marc.w.gonzalez@free.fr>; 'olof@lixom.net'
> > > 
> > > <olof@lixom.net>; 'devicetree@vger.kernel.org'
> > > <devicetree@vger.kernel.org>; 'linux-kernel@vger.kernel.org'
> > > <linux-
> > > kernel@vger.kernel.org>; 'linux-arm-kernel@lists.infradead.org'
> > > <linux-arm- kernel@lists.infradead.org>; 'linux-pm@vger.kernel.or
> > > g'
> > > <linux- pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > > Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal
> > > binding
> > > 
> > > Ping...
> > > Hi, Eduardo
> > > 	Can you take a look at this thread? Thanks.
> > > 
> > > 
> > > Best Regards!
> > > Anson Huang
> > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Anson Huang
> > > > Sent: 2019年3月6日 13:27
> > > > To: 'Rob Herring' <robh@kernel.org>; 'edubezval@gmail.com'
> > > > <edubezval@gmail.com>
> > > > Cc: 'mark.rutland@arm.com' <mark.rutland@arm.com>;
> > > > 'shawnguo@kernel.org' <shawnguo@kernel.org>;
> > > 's.hauer@pengutronix.de'
> > > > 
> > > > <s.hauer@pengutronix.de>; 'kernel@pengutronix.de'
> > > > <kernel@pengutronix.de>; 'festevam@gmail.com'
> > <festevam@gmail.com>;
> > > 
> > > > 
> > > > 'catalin.marinas@arm.com' <catalin.marinas@arm.com>;
> > > > 'will.deacon@arm.com' <will.deacon@arm.com>; 'rui.zhang@intel.c
> > > > om'
> > > > <rui.zhang@intel.com>; 'edubezval@gmail.com'
> > <edubezval@gmail.com>;
> > > 
> > > > 
> > > > 'daniel.lezcano@linaro.org' <daniel.lezcano@linaro.org>;
> > > > Aisheng
> > > > Dong <aisheng.dong@nxp.com>; 'ulf.hansson@linaro.org'
> > > > <ulf.hansson@linaro.org>; 'sboyd@kernel.org' <sboyd@kernel.org>
> > > > ;
> > > > Daniel Baluta <daniel.baluta@nxp.com>; Andy Gross
> > > > <andy.gross@linaro.org>; 'horms+renesas@verge.net.au'
> > > > <horms+renesas@verge.net.au>; 'heiko@sntech.de' <heiko@sntech.d
> > > > e>;
> > > > 'arnd@arndb.de' <arnd@arndb.de>; 'maxime.ripard@bootlin.com'
> > > > <maxime.ripard@bootlin.com>; 'bjorn.andersson@linaro.org'
> > > > <bjorn.andersson@linaro.org>; 'jagan@amarulasolutions.com'
> > > > <jagan@amarulasolutions.com>; 'enric.balletbo@collabora.com'
> > > > <enric.balletbo@collabora.com>; 'marc.w.gonzalez@free.fr'
> > > <marc.w.gonzalez@free.fr>; 'olof@lixom.net'
> > > > 
> > > > <olof@lixom.net>; 'devicetree@vger.kernel.org'
> > > > <devicetree@vger.kernel.org>; 'linux-kernel@vger.kernel.org'
> > > > <linux-
> > > > kernel@vger.kernel.org>; 'linux-arm-kernel@lists.infradead.org'
> > > > <linux-arm- kernel@lists.infradead.org>; 'linux-pm@vger.kernel.
> > > > org'
> > > > <linux- pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal
> > > > binding
> > > > 
> > > > Ping...
> > > > 
> > > > Hi, Eduardo
> > > > 	Looks like we are going around in circle, can we make
> > > > decision of
> > > > which direction to go?
> > > > 
> > > > Best Regards!
> > > > Anson Huang
> > > > 
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Anson Huang
> > > > > Sent: 2019年3月1日 9:41
> > > > > To: 'Rob Herring' <robh@kernel.org>; edubezval@gmail.com
> > > > > Cc: mark.rutland@arm.com; shawnguo@kernel.org;
> > > > s.hauer@pengutronix.de;
> > > > > 
> > > > > kernel@pengutronix.de; festevam@gmail.com;
> > > catalin.marinas@arm.com;
> > > > 
> > > > > 
> > > > > will.deacon@arm.com; rui.zhang@intel.com; edubezval@gmail.com
> > > > > ;
> > > > > daniel.lezcano@linaro.org; Aisheng Dong <aisheng.dong@nxp.com
> > > > > >;
> > > > > ulf.hansson@linaro.org; sboyd@kernel.org; Daniel Baluta
> > > > > <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>;
> > > > > horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb.de;
> > > > > maxime.ripard@bootlin.com; bjorn.andersson@linaro.org;
> > > > > jagan@amarulasolutions.com; enric.balletbo@collabora.com;
> > > > > marc.w.gonzalez@free.fr; olof@lixom.net;
> > > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > linux-arm-kernel@lists.infradead.org;
> > > > > linux- pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > > > > Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add
> > > > > thermal
> > > > > binding
> > > > > 
> > > > > Hi, Rob/Eduardo
> > > > > 
> > > > > Best Regards!
> > > > > Anson Huang
> > > > > 
> > > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Rob Herring [mailto:robh@kernel.org]
> > > > > > Sent: 2019年2月28日 22:49
> > > > > > To: Anson Huang <anson.huang@nxp.com>
> > > > > > Cc: mark.rutland@arm.com; shawnguo@kernel.org;
> > > > > s.hauer@pengutronix.de;
> > > > > > 
> > > > > > kernel@pengutronix.de; festevam@gmail.com;
> > > > catalin.marinas@arm.com;
> > > > > 
> > > > > > 
> > > > > > will.deacon@arm.com; rui.zhang@intel.com; edubezval@gmail.c
> > > > > > om;
> > > > > > daniel.lezcano@linaro.org; Aisheng Dong <aisheng.dong@nxp.c
> > > > > > om>;
> > > > > > ulf.hansson@linaro.org; sboyd@kernel.org; Daniel Baluta
> > > > > > <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>
> > > > > > ;
> > > > > > horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb.de;
> > > > > > maxime.ripard@bootlin.com; bjorn.andersson@linaro.org;
> > > > > > jagan@amarulasolutions.com; enric.balletbo@collabora.com;
> > > > > > marc.w.gonzalez@free.fr; olof@lixom.net;
> > > > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > linux- pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > > > > > Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add
> > > > > > thermal
> > > > > > binding
> > > > > > 
> > > > > > On Wed, Feb 27, 2019 at 6:48 PM Anson Huang
> > > <anson.huang@nxp.com>
> > > > 
> > > > > 
> > > > > > 
> > > > > > wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > Hi, Rob
> > > > > > > 
> > > > > > > Best Regards!
> > > > > > > Anson Huang
> > > > > > > 
> > > > > > > > 
> > > > > > > > -----Original Message-----
> > > > > > > > From: Rob Herring [mailto:robh@kernel.org]
> > > > > > > > Sent: 2019年2月28日 7:55
> > > > > > > > To: Anson Huang <anson.huang@nxp.com>
> > > > > > > > Cc: mark.rutland@arm.com; shawnguo@kernel.org;
> > > > > > > > s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > > > festevam@gmail.com;
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > catalin.marinas@arm.com; will.deacon@arm.com;
> > > > > rui.zhang@intel.com;
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > edubezval@gmail.com; daniel.lezcano@linaro.org; Aisheng
> > > > > > > > Dong
> > > > > > > > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org;
> > > > > > > > sboyd@kernel.org; Daniel Baluta <daniel.baluta@nxp.com>
> > > > > > > > ;
> > > > > > > > Andy Gross <andy.gross@linaro.org>;
> > > > > > > > horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb
> > > > > > > > .de;
> > > > > > > > maxime.ripard@bootlin.com; bjorn.andersson@linaro.org;
> > > > > > > > jagan@amarulasolutions.com; enric.balletbo@collabora.co
> > > > > > > > m;
> > > > > > > > marc.w.gonzalez@free.fr; olof@lixom.net;
> > > > > > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.or
> > > > > > > > g;
> > > > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > > > linux- pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.
> > > > > > > > com>
> > > > > > > > Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add
> > > > > > > > thermal binding
> > > > > > > > 
> > > > > > > > On Wed, Feb 27, 2019 at 08:46:21AM +0000, Anson Huang
> > > > > > > > wrote:
> > > > > > > > > 
> > > > > > > > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core
> > > > > > > > > inside
> > > > > > > > > as system controller, the system controller is in
> > > > > > > > > charge
> > > > > > > > > of system power, clock and thermal sensors etc.
> > > > > > > > > management, Linux kernel has to communicate with
> > > > > > > > > system
> > > > > > > > > controller via MU (message unit) IPC to get
> > > > > > > > > temperature
> > > > > > > > > from thermal sensors, this patch adds binding doc for
> > > > > > > > > i.MX
> > > > > > > > > system controller thermal
> > > > driver.
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > > > > > > ---
> > > > > > > > > Changes since V9:
> > > > > > > > >     - change #thermal-sensor-cells value in example
> > > > > > > > > to 1,
> > > > > > > > > since there are
> > > > > > > > other
> > > > > > > > > 
> > > > > > > > >       thermal sensors inside system controller, it is
> > > > > > > > > just
> > > > > > > > > because there are
> > > > > > > > still
> > > > > > > > > 
> > > > > > > > >       some issue, so system controller does NOT
> > > > > > > > > expose
> > > > > > > > > them for now,
> > > > > > > > they could
> > > > > > > > > 
> > > > > > > > >       be exposed later, so it should be 1 from HW
> > > > > > > > > perspective.
> > > > > > > > > ---
> > > > > > > > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt   
> > > > > > > > > | 21
> > > > > > > > +++++++++++++++++++++
> > > > > > > > > 
> > > > > > > > >  1 file changed, 21 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git
> > > > > > > > > a/Documentation/devicetree/bindings/arm/freescale/fsl
> > > > > > > > > ,scu.
> > > > > > > > > tx
> > > > > > > > > t
> > > > > > > > > b/Documentation/devicetree/bindings/arm/freescale/fsl
> > > > > > > > > ,scu.
> > > > > > > > > tx t index 72d481c..855270b 100644
> > > > > > > > > ---
> > > > > > > > > a/Documentation/devicetree/bindings/arm/freescale/fsl
> > > > > > > > > ,scu.
> > > > > > > > > tx
> > > > > > > > > t
> > > > > > > > > +++
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > +++ tx
> > > > > > > > > +++ t
> > > > > > > > > @@ -122,6 +122,21 @@ RTC bindings based on SCU
> > > > > > > > > Message
> > > > > Protocol
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Required properties:
> > > > > > > > >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> > > > > > > > > 
> > > > > > > > > +Thermal bindings based on SCU Message Protocol
> > > > > > > > > +--------------------------------------------------
> > > > > > > > > -------
> > > > > > > > > +--
> > > > > > > > > +-
> > > > > > > > > +
> > > > > > > > > +Required properties:
> > > > > > > > > +- compatible:                      Should be :
> > > > > > > > > +                             "fsl,imx8qxp-sc-
> > > > > > > > > thermal"
> > > > > > > > > +                           followed by
> > > > > > > > > +"fsl,imx-sc-thermal";
> > > > > > > > > +
> > > > > > > > > +- #thermal-sensor-cells:   See
> > > > > > > > Documentation/devicetree/bindings/thermal/thermal.txt
> > > > > > > > > 
> > > > > > > > > +                           for a description.
> > > > > > > > > +
> > > > > > > > > +- imx,sensor-resource-id:  A single integer for
> > > > > > > > > single
> > > > > > > > > +thermal zone's
> > > > > > > > resource ID or
> > > > > > > > > 
> > > > > > > > > +                           an array of integers to
> > > > > > > > > + specify each thermal
> > > > > > > > zone's sensor
> > > > > > > > > 
> > > > > > > > > +                           resource ID.
> > > > > > > > Can't you put the resource ids in the thermal-sensor
> > > > > > > > cells?
> > > > > > > > Why do you need to list them here?
> > > > > > > For the thermal-sensor cells, if you meant the argument
> > > > > > > of
> > > > > > > tsens phandle, then the reason is that argument is for
> > > > > > > sensor
> > > > > > > index starting from 0, previous I use it for our resource
> > > > > > > ID,
> > > > > > > but it looks confused, since user will think there are
> > > > > > > many
> > > > > > > sensors there per
> > > > > Eduardo's comment.
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > +                       thermal-sensors = <&tsens 0>;
> > > > > > > 
> > > > > > > If you meant putting it in each thermal sensor node
> > > > > > > instead of
> > "tsens"
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > node, then in previous patch series, I put this "
> > > > > > > imx,sensor-resource-id " property in each thermal sensor
> > > > > > > node,
> > > > > > > but the thermal sensor nodes are parsed by common thermal
> > > > > > > framework, thermal driver will need to find the thermal
> > > > > > > zone
> > > > > > > node and go through every child node to get the resource
> > > > > > > id
> > > > > > > again, so Eduardo suggested to put it in
> > > > > > our platform tsens node, that makes our thermal driver code
> > > > > > much
> > > > > > more simple.
> > > > > > 
> > > > > > The phandle args are meant to be an id typically. There's
> > > > > > absolutely no requirement they are 0-N based. They often
> > > > > > are
> > > > > > because things like interrupts are 0-N or clocks have no
> > > > > > h/w id.
> > > > > > If you already have an id,
> > > > use it.
> > > > > 
> > > > > > 
> > > > > > Don't invent your own.
> > > > > At the beginning, I put the HW resource ID in the "tsens"
> > > > > phandle
> > > > > argument of "thermal-sensors" node, see  below patch I sent
> > > > > before, the benefit is I do NOT need to add new property for
> > > > > passing HW resource ID to driver, the disadvantage is, I have
> > > > > to
> > > > > parse the thermal_zones' each child node and get the HW
> > > > > resource
> > > > > ID from phandle argument(searing thermal_zones node and go
> > > > > through
> > > > > all its child node, and get the phandle argument), they are
> > > > > by
> > > > > default ONLY parsed by thermal core driver. When we register
> > > > > thermal zone, we have to pass the HW resource ID when calling
> > > > > devm_thermal_zone_of_sensor_register(), if we add our own
> > > > > property
> > > > > to pass the HW resource ID, then no need to do so, we just
> > > > > pass
> > > > > the index 0-N for each thermal sensors in devicetree which
> > > > > also
> > > > > with phandle
> > > > argument 0- N. So using our own property makes the driver much
> > > > more
> > > > simple.
> > > > > 
> > > > > 
> > > > > So, @Eduardo, which direction I should go? Looks like Rob
> > > > > suggests
> > > > > just put the HW resource ID in the phandle argument like what
> > > > > I
> > > > > did at the beginning, can you advise?
> > > > > 
> > > > > Thanks,
> > > > > Anson.
> > > > > 
> > > > > https://patchwork.kernel.org/patch/10703849/
> > > > > > 
> > > > > > +	thermal_zones: thermal-zones {
> > > > > > +		cpu-thermal0 {
> > > > > > +			polling-delay-passive = <250>;
> > > > > > +			polling-delay = <2000>;
> > > > > > +			thermal-sensors = <&tsens 355>;
> > > > > > +			trips {
> > > > > > +				cpu_alert0: trip0 {
> > > > > > +					temperature =
> > > > > > <107000>;
> > > > > > +					hysteresis =
> > > > > > <2000>;
> > > > > > +					type = "passive";
> > > > > > +				};
> > > > > > 
> > > > > > 
> > > > > > Rob
