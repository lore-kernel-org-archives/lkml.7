Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10532C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8462084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfDLIlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:41:21 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40789 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfDLIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:41:21 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C633520003;
        Fri, 12 Apr 2019 08:41:16 +0000 (UTC)
Date:   Fri, 12 Apr 2019 10:41:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Message-ID: <20190412084116.GS3578@piout.net>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
 <1554785675-8090-2-git-send-email-Anson.Huang@nxp.com>
 <20190411073252.GC3050@dragon>
 <DB3PR0402MB3916B67E6DA995AB70C29799F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB4211816EDBEF23F7B330CCCB80280@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB39162D194A2B5B79211C1774F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39162D194A2B5B79211C1774F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 02:32:54+0000, Anson Huang wrote:
> > > 	As i.MX SCU general irq function is picked up by Shawn, could you
> > > please also pick up below i.MX SC RTC alarm support patch ?
> > > 	https://patchwork.kernel.org/patch/10890525/
> > >
> > 
> > No, it can't go through Alexandre's tree due to dependency issue.
> > 
> > Shawn,
> > Do you think you can pick it up? Alexandre already gave the Ack.
> > 
> > AFAIK there's no other SCU RTC patches since v5.1-rc1 in Alexandre's tree.
> 
> Yes, need to make sure the dependency is handled, the RTC alarm patch MUST be picked up
> ONLY when scu irq patch is ready, NOT sure how to handle this case for such scenario?
> 

Either it goes through arm-soc or if it can wait one release, I pick it
up for 5.3. The other solution involves immutable branch but I don't
think this is necessary.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
