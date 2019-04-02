Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E110C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4616120883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfDBMpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:45:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52881 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfDBMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:45:40 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3647A60003;
        Tue,  2 Apr 2019 12:45:37 +0000 (UTC)
Date:   Tue, 2 Apr 2019 14:45:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10]
Message-ID: <20190402124536.GC3430@piout.net>
References: <20190402124016.20558-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402124016.20558-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard that series as this doesn't include the proper patches.

On 02/04/2019 14:40:06+0200, Alexandre Belloni wrote:
> This series add support for the sam9x60 clocks handled by the PMC.
> 
> The first four patches are preparatory patches to handle register layout
> and offset differences. Then, a driver for the new interface for PLLs is
> added and the final patch is the driver for the sam9x60 PMC.
> 
> changes in v2:
>  - rebased on v5.1-rc1
>  - changed the PLL_ACR handling to conform to the datasheet errata
> 
> Alexandre Belloni (7):
>   clk: at91: allow configuring peripheral PCR layout
>   clk: at91: allow configuring generated PCR layout
>   clk: at91: usb: Add sam9x60 support
>   clk: at91: master: Add sam9x60 support
>   clk: at91: add sam9x60 PLL driver
>   dt-bindings: clk: at91: add bindings for SAM9X60 pmc
>   clk: at91: add sam9x60 pmc driver
> 
> Claudiu Beznea (3):
>   clk: at91: sckc: add support to specify registers bit offsets
>   clk: at91: sckc: add support for SAM9X60
>   dt-bindings: clk: at91: add bindings for SAM9X60's slow clock
>     controller
> 
>  .../devicetree/bindings/clock/at91-clock.txt  |   6 +-
>  drivers/clk/at91/Makefile                     |   2 +
>  drivers/clk/at91/at91sam9x5.c                 |   9 +
>  drivers/clk/at91/clk-generated.c              |  48 +--
>  drivers/clk/at91/clk-master.c                 |   8 +-
>  drivers/clk/at91/clk-peripheral.c             |  46 +--
>  drivers/clk/at91/clk-sam9x60-pll.c            | 330 ++++++++++++++++++
>  drivers/clk/at91/clk-usb.c                    |  33 +-
>  drivers/clk/at91/dt-compat.c                  |  12 +-
>  drivers/clk/at91/pmc.h                        |  23 ++
>  drivers/clk/at91/sam9x60.c                    | 307 ++++++++++++++++
>  drivers/clk/at91/sama5d2.c                    |  10 +
>  drivers/clk/at91/sama5d4.c                    |   8 +
>  drivers/clk/at91/sckc.c                       | 142 ++++++--
>  include/linux/clk/at91_pmc.h                  |  12 +-
>  15 files changed, 895 insertions(+), 101 deletions(-)
>  create mode 100644 drivers/clk/at91/clk-sam9x60-pll.c
>  create mode 100644 drivers/clk/at91/sam9x60.c
> 
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
