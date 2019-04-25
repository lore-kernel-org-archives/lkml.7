Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEBFC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE741206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfDYVKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:10:13 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51329 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDYVKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:10:13 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E7FAE20000C;
        Thu, 25 Apr 2019 21:10:09 +0000 (UTC)
Date:   Thu, 25 Apr 2019 23:10:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
Message-ID: <20190425211009.GP14604@piout.net>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com>
 <20190402125056.21509-8-alexandre.belloni@bootlin.com>
 <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com>
 <20190425203139.GO14604@piout.net>
 <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 13:58:10-0700, Stephen Boyd wrote:
> > IIRC two clocks are used by the clocksource and having it as a platform
> > device make the clocksource driver fail with -EPROBE_DEFER.
> > 
> 
> Ok. I'll add a comment in the driver. It needs to be
> CLK_OF_DECLARE_DRIVER() because it's used somewhere else too? Or it can
> be CLK_OF_DECLARE() instead?

It is coming from that comment:
https://lore.kernel.org/lkml/153573753043.93865.2420370848457480370@swboyd.mtv.corp.google.com/

Maybe I misinterpreted it.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
