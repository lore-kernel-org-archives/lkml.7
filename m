Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9CC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDAP03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:26:29 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55981 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAP03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:26:29 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E4A47240005;
        Mon,  1 Apr 2019 15:26:23 +0000 (UTC)
Date:   Mon, 1 Apr 2019 17:26:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 4/4] rtc: imx-sc: add rtc alarm support
Message-ID: <20190401152622.GL3430@piout.net>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
 <1552878291-22866-4-git-send-email-Anson.Huang@nxp.com>
 <20190401131130.GE3430@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401131130.GE3430@piout.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 15:11:30+0200, Alexandre Belloni wrote:
> On 18/03/2019 03:10:06+0000, Anson Huang wrote:
> > Add i.MX system controller RTC alarm support, the RTC alarm
> > is implemented via SIP(silicon provider) runtime service call
> > and ARM-Trusted-Firmware will communicate with system controller
> > via MU(message unit) IPC to set RTC alarm. When RTC alarm fires,
> > system controller will generate a common MU irq event and notify
> > system controller RTC driver to handle the irq event.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > No function changes, just update imx_scu_irq_register_notifier() function name
> > according to SCU IRQ function name change.
> > ---
> >  drivers/rtc/rtc-imx-sc.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> > 
> Applied, thanks.
> 

Actually, that is not the one I applied.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
