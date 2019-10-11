Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CDFC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038FD21835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfJKQ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:56:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55813 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfJKQ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:56:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iIyDW-00056W-7D; Fri, 11 Oct 2019 18:56:38 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iIyDR-0007Kv-OH; Fri, 11 Oct 2019 18:56:33 +0200
Date:   Fri, 11 Oct 2019 18:56:33 +0200
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
Message-ID: <20191011165633.5ty3yux4ljrcycux@pengutronix.de>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-3-andreas@kemnade.info>
 <20191011065609.6irap7elicatmsgg@pengutronix.de>
 <20191011094148.1376430e@aktux>
 <20191011142927.GA11490@bogus>
 <20191011170147.1b3c4b25@kemnade.info>
 <20191011152214.v6lq6itwf5lp6j7q@pengutronix.de>
 <20191011181938.185f2a00@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011181938.185f2a00@kemnade.info>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 18:54:48 up 146 days, 23:12, 97 users,  load average: 0.08, 0.10,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-11 18:19, Andreas Kemnade wrote:
> On Fri, 11 Oct 2019 17:22:14 +0200
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > On 19-10-11 17:05, Andreas Kemnade wrote:
> > > On Fri, 11 Oct 2019 09:29:27 -0500
> > > Rob Herring <robh@kernel.org> wrote:
> > >   
> > > > On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote:  
> > > > > On Fri, 11 Oct 2019 08:56:09 +0200
> > > > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > >     
> > > > > > Hi Andreas,
> > > > > > 
> > > > > > On 19-10-10 21:23, Andreas Kemnade wrote:    
> > > > > > > The Netronix board E60K02 can be found some several Ebook-Readers,
> > > > > > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > > > > > is equipped with different SoCs requiring different pinmuxes.
> > > > > > > 
> > > > > > > For now the following peripherals are included:
> > > > > > > - LED
> > > > > > > - Power Key
> > > > > > > - Cover (gpio via hall sensor)
> > > > > > > - RC5T619 PMIC (the kernel misses support for rtc and charger
> > > > > > >   subdevices).
> > > > > > > - Backlight via lm3630a
> > > > > > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > > > > > 
> > > > > > > It is based on vendor kernel but heavily reworked due to many
> > > > > > > changed bindings.
> > > > > > > 
> > > > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > > > ---
> > > > > > > Changes in v3:
> > > > > > > - better led name
> > > > > > > - correct memory size
> > > > > > > - comments about missing devices
> > > > > > > 
> > > > > > > Changes in v2:
> > > > > > > - reordered, was 1/3
> > > > > > > - moved pinmuxes to their actual users, not the parents
> > > > > > >   of them
> > > > > > > - removed some already-disabled stuff
> > > > > > > - minor cleanups      
> > > > > > 
> > > > > > You won't change the muxing, so a this dtsi can be self contained?
> > > > > >     
> > > > > So you want me to put a big 
> > > > > #if defined(MX6SLL)     
> > > > 
> > > > Not sure what the comment meant, but no, don't do this. C defines in dts 
> > > > files are for symbolic names for numbers and assembling bitfields and 
> > > > that's it.  
> > > 
> > > yes, that is also my opinion. For now, there is only one user
> > > of this .dtsi, but I have another one in preparation. That is the
> > > reason for splitting things between .dts and .dtsi to avoid such ugly
> > > ifdefs  
> > 
> > Then IMHO the pnictrl-* entries shouldn't appear in the dsti.
> > 
> hmm, maybe now I understand your idea:
> You do not want only to have
> 
>   pinctrl_lm3630a_bl_gpio: lm3630a_bl_gpio_grp {
>                         fsl,pins = <
>                                 MX6SLL_PAD_EPDC_PWR_CTRL3__GPIO2_IO10   0x10059 /* HWEN */
>                         >;
>                 };
> in dts, but also  do not have these in .dtsi:
> 
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
> 
> and instead have in dts:
> &lm3630a {
>  	pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
> 	
> };
> 
> 
> just to make sure I get it right before doing the restructuring work. That way of structuring things did not come to my mind, but then the .dtsi is self-contained.

That is what I mean but wait for Shawn's comments. It's just my opinion
that .dtsi and .dts files should be self-contained.

Regards,
  Marco

> Regards,
> Andreas



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
