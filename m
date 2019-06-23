Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED1C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E766E20656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFWMRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:17:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:17:40 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf1R6-0000UV-Ml; Sun, 23 Jun 2019 14:17:32 +0200
Date:   Sun, 23 Jun 2019 14:17:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anson.Huang@nxp.com
cc:     daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, ccaione@baylibre.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] clocksource: imx-sysctr: Add of_clk skip option
In-Reply-To: <20190623120434.19556-2-Anson.Huang@nxp.com>
Message-ID: <alpine.DEB.2.21.1906231413110.32342@nanos.tec.linutronix.de>
References: <20190623120434.19556-1-Anson.Huang@nxp.com> <20190623120434.19556-2-Anson.Huang@nxp.com>
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

On Sun, 23 Jun 2019, Anson.Huang@nxp.com wrote:

Again the short summary could be more informative. Instead of 'Add foo' you
could say:

    .....: Make timer work with platform driver model

That sums up the real meat of the patch. 'Add some option' is pretty
uninformative.

> On some i.MX8M platforms, clock driver uses platform driver
> model and it is NOT ready during timer initialization phase,
> the clock operations will fail and system counter driver will
> fail too. As all the i.MX8M platforms' system counter clock
> are from OSC which is always enabled, so it is no need to enable
> clock for system counter driver, the ONLY thing is to pass
> clock frequence to driver.
> 
> This patch adds an option of skipping of_clk operation for
> system counter driver, an optional property "clock-frequency"
> is introduced to pass the frequency value to system counter
> driver and indicate driver to skip of_clk operations.

The comments to the changelog of patch 1 apply here as well :)

Hint: 'This patch'

Thanks,

	tglx


