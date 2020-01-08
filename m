Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAD8C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0E02070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgAHKJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:09:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60421 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:09:17 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ip8Gv-0004w2-FY; Wed, 08 Jan 2020 11:09:05 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1ip8Gu-0000aF-Te; Wed, 08 Jan 2020 11:09:04 +0100
Date:   Wed, 8 Jan 2020 11:09:04 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     support.opensource@diasemi.com, linux@roeck-us.net,
        robh+dt@kernel.org, lee.jones@linaro.org,
        stwiss.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com
Cc:     devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Explicit disable da9062 watchdog during suspend
Message-ID: <20200108100904.m26jskuhv7ldqaa2@pengutronix.de>
References: <20200108095704.23233-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108095704.23233-1-m.felsch@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:07:32 up 54 days,  1:26, 46 users,  load average: 0.02, 0.03,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-01-08 10:57, Marco Felsch wrote:
> Hi,
> 
> this v2 contains all review comments made on [1]. Furthermore the series
> includes a fix patch which is need to parse the devicetree.

I forgot to add the -v2 to my git command anyway this is realy a v2.
Sorry for the noise.

Regards,
  Marco

> [1] https://www.spinics.net/lists/linux-watchdog/msg17044.html
> 
> Regards,
>   Marco
> 
> Marco Felsch (3):
>   mfd: da9062: fix watchdog compatible string
>   dt-bindings: watchdog: da9062: add suspend disable option
>   watchdog: da9062: add power management ops
> 
>  .../bindings/watchdog/da9062-wdt.txt          |  5 +++
>  drivers/mfd/da9062-core.c                     |  2 +-
>  drivers/watchdog/da9062_wdt.c                 | 37 +++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
> 
> -- 
> 2.20.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
