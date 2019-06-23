Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AAAC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E49D20840
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFWLes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:34:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:34:47 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf0la-0008KU-TC; Sun, 23 Jun 2019 13:34:39 +0200
Date:   Sun, 23 Jun 2019 13:34:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] clocksource/drivers/sysctr: Add an optional
 property
In-Reply-To: <DB3PR0402MB3916B3B871FDEA9BFC960C67F5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1906231331390.32342@nanos.tec.linutronix.de>
References: <20190621082838.12630-1-Anson.Huang@nxp.com> <alpine.DEB.2.21.1906231232520.32342@nanos.tec.linutronix.de> <DB3PR0402MB3916B3B871FDEA9BFC960C67F5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anson,

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sun, 23 Jun 2019, Anson Huang wrote:

> Hi, Thomas
> 	Thanks for the useful comment, I will resend the patch with improvement.
> 
> Anson.
> 
> > -----Original Message-----
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Sent: Sunday, June 23, 2019 6:47 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: daniel.lezcano@linaro.org; robh+dt@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; l.stach@pengutronix.de; Abel Vesa
> > <abel.vesa@nxp.com>; ccaione@baylibre.com; angus@akkea.ca;
> > andrew.smirnov@gmail.com; agx@sigxcpu.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 1/3] clocksource/drivers/sysctr: Add an optional
> > property

Also please fix your mailer to NOT copy the full mail header into the
reply. That's absolutely useless.

> > 
> > Anson,
> > 
> > On Fri, 21 Jun 2019, Anson.Huang@nxp.com wrote:
> > 
> > > Subject : [PATCH 1/3] clocksource/drivers/sysctr: Add an optional
> > > property

And finally please trim your replies, so the uninteresting parts are gone.

Thanks,

	tglx
