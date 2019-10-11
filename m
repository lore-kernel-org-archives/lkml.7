Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C0C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9F3206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfJKPWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:22:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57907 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:22:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iIwkD-00044O-8R; Fri, 11 Oct 2019 17:22:17 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iIwkA-0004HX-Ik; Fri, 11 Oct 2019 17:22:14 +0200
Date:   Fri, 11 Oct 2019 17:22:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Rob Herring <robh@kernel.org>, mark.rutland@arm.com, marex@denx.de,
        devicetree@vger.kernel.org, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, angus@akkea.ca,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, manivannan.sadhasivam@linaro.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191011152214.v6lq6itwf5lp6j7q@pengutronix.de>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-3-andreas@kemnade.info>
 <20191011065609.6irap7elicatmsgg@pengutronix.de>
 <20191011094148.1376430e@aktux>
 <20191011142927.GA11490@bogus>
 <20191011170147.1b3c4b25@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011170147.1b3c4b25@kemnade.info>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:20:39 up 146 days, 21:38, 99 users,  load average: 0.06, 0.01,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-11 17:05, Andreas Kemnade wrote:
> On Fri, 11 Oct 2019 09:29:27 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote:
> > > On Fri, 11 Oct 2019 08:56:09 +0200
> > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >   
> > > > Hi Andreas,
> > > > 
> > > > On 19-10-10 21:23, Andreas Kemnade wrote:  
> > > > > The Netronix board E60K02 can be found some several Ebook-Readers,
> > > > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > > > is equipped with different SoCs requiring different pinmuxes.
> > > > > 
> > > > > For now the following peripherals are included:
> > > > > - LED
> > > > > - Power Key
> > > > > - Cover (gpio via hall sensor)
> > > > > - RC5T619 PMIC (the kernel misses support for rtc and charger
> > > > >   subdevices).
> > > > > - Backlight via lm3630a
> > > > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > > > 
> > > > > It is based on vendor kernel but heavily reworked due to many
> > > > > changed bindings.
> > > > > 
> > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > ---
> > > > > Changes in v3:
> > > > > - better led name
> > > > > - correct memory size
> > > > > - comments about missing devices
> > > > > 
> > > > > Changes in v2:
> > > > > - reordered, was 1/3
> > > > > - moved pinmuxes to their actual users, not the parents
> > > > >   of them
> > > > > - removed some already-disabled stuff
> > > > > - minor cleanups    
> > > > 
> > > > You won't change the muxing, so a this dtsi can be self contained?
> > > >   
> > > So you want me to put a big 
> > > #if defined(MX6SLL)   
> > 
> > Not sure what the comment meant, but no, don't do this. C defines in dts 
> > files are for symbolic names for numbers and assembling bitfields and 
> > that's it.
> 
> yes, that is also my opinion. For now, there is only one user
> of this .dtsi, but I have another one in preparation. That is the
> reason for splitting things between .dts and .dtsi to avoid such ugly
> ifdefs

Then IMHO the pnictrl-* entries shouldn't appear in the dsti.

Regards,
  Marco

> Regards,
> Andreas



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
