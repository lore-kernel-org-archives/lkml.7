Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9444C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA05520828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfCSKZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:25:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51715 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfCSKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:25:08 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6Bvc-0006B6-Qs; Tue, 19 Mar 2019 11:25:04 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6Bvb-0002HL-RB; Tue, 19 Mar 2019 11:25:03 +0100
Date:   Tue, 19 Mar 2019 11:25:03 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V6 0/5] Add i.MX7ULP EVK PWM backlight support
Message-ID: <20190319102503.q6svn7s6yz7hw2zd@pengutronix.de>
References: <1552979097-5814-1-git-send-email-Anson.Huang@nxp.com>
 <20190319081446.m5eboi4v54er3niv@pengutronix.de>
 <DB3PR0402MB39165E52E113BAB7B66AFB24F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39165E52E113BAB7B66AFB24F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:11:38AM +0000, Anson Huang wrote:
> Hi,
> 
> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > From: Uwe Kleine-König [mailto:u.kleine-koenig@pengutronix.de]
> > Sent: 2019年3月19日 16:15
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: thierry.reding@gmail.com; robh+dt@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux@armlinux.org.uk; stefan@agner.ch;
> > otavio@ossystems.com.br; Leonard Crestez <leonard.crestez@nxp.com>;
> > schnitzeltony@gmail.com; jan.tuerk@emtrion.com; Robin Gong
> > <yibin.gong@nxp.com>; linux-pwm@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH RESEND V6 0/5] Add i.MX7ULP EVK PWM backlight
> > support
> > 
> > On Tue, Mar 19, 2019 at 07:09:56AM +0000, Anson Huang wrote:
> > > i.MX7ULP EVK board has MIPI-DSI display, its backlight is supplied by
> > > TPM PWM module, this patch set enables i.MX7ULP TPM PWM driver
> > support
> > > and also add backlight support for MIPI-DSI display.
> > 
> > Given that you actually changed something compared to v6, this is not a
> > resend but v7. Also I suggest to practise a bit of patience before sending out
> > a new revision to prevent people still looking at the previous round. I just
> > gave feedback to the original v6 which you obviously didn't address :-|
> > 
> > Also a highlevel changelog for the series (here something like: "Properly
> > separate dt changes into soc-specific and machine-specific changes") is
> > helpful.
> 
> OK, will pay attention to that, the resend is just because the patch content is NOT
> Changed, just re-organize the DT patch.
> 
> Also, I understand that sending the patch version too quickly will result in too many
> Patch version in this thread, but I just want to address the comments ASAP when I
> Have time, hope that does NOT bother reviewer too much...

A middle way is to provide a git-tree somewhere and in reply to a review
just say: I updated the patches according to your feedback, but will
wait a bit more for further feedback before resending. If you're
interested the current work in progress can be found at git://... in the
xyz branch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
