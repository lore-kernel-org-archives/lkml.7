Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17BBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EF621556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfLKKBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:01:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35027 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfLKKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:01:05 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ieynh-0002xu-4L; Wed, 11 Dec 2019 11:00:57 +0100
Message-ID: <c5fcb87bb36831776d17101e0e6e0e99b86f434c.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: davinci: select CONFIG_RESET_CONTROLLER
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Dec 2019 11:00:56 +0100
In-Reply-To: <CAMpxmJX0jAa4-52pT0rutPz9naRHb4nnZ=cDdvCMLxGh=3m_=A@mail.gmail.com>
References: <20191210195202.622734-1-arnd@arndb.de>
         <CAMpxmJX0jAa4-52pT0rutPz9naRHb4nnZ=cDdvCMLxGh=3m_=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 10:14 +0100, Bartosz Golaszewski wrote:
> wt., 10 gru 2019 o 20:52 Arnd Bergmann <arnd@arndb.de> napisał(a):
> > Selecting RESET_CONTROLLER is actually required, otherwise we
> > can get a link failure in the clock driver:
> > 
> > drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
> > psc.c:(.text+0x9a0): undefined reference to `devm_reset_controller_register'
> > drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> > psc-da850.c:(.text+0x24): undefined reference to `reset_controller_add_lookup'
> > 
> > Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v5")
> > Cc: <stable@vger.kernel.org> # v5.4
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/mach-davinci/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

