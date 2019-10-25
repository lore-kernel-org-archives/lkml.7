Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC7C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8986221D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571994864;
	bh=3r7YuR6KqKAbgF30VcFbrSfSQsVVA9/SMsTQ81rjTeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jdMZEF7NS7HlJODR/Ku62O+oMvm2/iP2SpVO4tDivHOlRU/n0Mvyu/gf5ZDRDg9cm
	 LL1NcC7RqEuw1w1FG91spPVKE/Csp/YDnGAInfOmoCrUd/++UfRjy0PkjWL4/LFUyj
	 X0Vt5WwCu59ED3yHE3bBaueDV4vRJn4GdPniU3h4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408495AbfJYJOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407248AbfJYJOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:14:23 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10EE821929;
        Fri, 25 Oct 2019 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571994861;
        bh=3r7YuR6KqKAbgF30VcFbrSfSQsVVA9/SMsTQ81rjTeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqR2fnmleW3Eff1LuRkdblVI98d/gUF6Yur2voSItgmeCtms5xacuNlOikafTWrsD
         cro6HbvT8PsqkaU74OVrgAJ/wwKKGuxXM8cDHTOWPdbQ79wtFBd36MYVe1QLBwmvcJ
         sahcvogiCaPkY4p6p9RYCbgkyKnPBsQOfi8+oOAo=
Date:   Fri, 25 Oct 2019 17:14:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, festevam@gmail.com,
        Rob Herring <robh@kernel.org>, mark.rutland@arm.com,
        marex@denx.de, devicetree@vger.kernel.org,
        andrew.smirnov@gmail.com, s.hauer@pengutronix.de, angus@akkea.ca,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, manivannan.sadhasivam@linaro.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191025091401.GL3208@dragon>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-3-andreas@kemnade.info>
 <20191011065609.6irap7elicatmsgg@pengutronix.de>
 <20191011094148.1376430e@aktux>
 <20191011142927.GA11490@bogus>
 <20191011170147.1b3c4b25@kemnade.info>
 <20191011152214.v6lq6itwf5lp6j7q@pengutronix.de>
 <20191011181938.185f2a00@kemnade.info>
 <20191011165633.5ty3yux4ljrcycux@pengutronix.de>
 <20191013175644.4fc264d0@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013175644.4fc264d0@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 05:56:44PM +0200, Andreas Kemnade wrote:
> On Fri, 11 Oct 2019 18:56:33 +0200
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > On 19-10-11 18:19, Andreas Kemnade wrote:
> > > On Fri, 11 Oct 2019 17:22:14 +0200
> > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >   
> > > > On 19-10-11 17:05, Andreas Kemnade wrote:  
> > > > > On Fri, 11 Oct 2019 09:29:27 -0500
> > > > > Rob Herring <robh@kernel.org> wrote:
> > > > >     
> > > > > > On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote:    
> > > > > > > On Fri, 11 Oct 2019 08:56:09 +0200
> > > > > > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > > > >       
> > > > > > > > Hi Andreas,
> > > > > > > > 
> > > > > > > > On 19-10-10 21:23, Andreas Kemnade wrote:      
> > > > > > > > > The Netronix board E60K02 can be found some several Ebook-Readers,
> > > > > > > > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > > > > > > > is equipped with different SoCs requiring different pinmuxes.
> > > > > > > > > 
> > > > > > > > > For now the following peripherals are included:
> > > > > > > > > - LED
> > > > > > > > > - Power Key
> > > > > > > > > - Cover (gpio via hall sensor)
> > > > > > > > > - RC5T619 PMIC (the kernel misses support for rtc and charger
> > > > > > > > >   subdevices).
> > > > > > > > > - Backlight via lm3630a
> > > > > > > > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > > > > > > > 
> > > > > > > > > It is based on vendor kernel but heavily reworked due to many
> > > > > > > > > changed bindings.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > > > > > ---
> > > > > > > > > Changes in v3:
> > > > > > > > > - better led name
> > > > > > > > > - correct memory size
> > > > > > > > > - comments about missing devices
> > > > > > > > > 
> > > > > > > > > Changes in v2:
> > > > > > > > > - reordered, was 1/3
> > > > > > > > > - moved pinmuxes to their actual users, not the parents
> > > > > > > > >   of them
> > > > > > > > > - removed some already-disabled stuff
> > > > > > > > > - minor cleanups        
> > > > > > > > 
> > > > > > > > You won't change the muxing, so a this dtsi can be self contained?
> > > > > > > >       
> > > > > > > So you want me to put a big 
> > > > > > > #if defined(MX6SLL)       
> > > > > > 
> > > > > > Not sure what the comment meant, but no, don't do this. C defines in dts 
> > > > > > files are for symbolic names for numbers and assembling bitfields and 
> > > > > > that's it.    
> > > > > 
> > > > > yes, that is also my opinion. For now, there is only one user
> > > > > of this .dtsi, but I have another one in preparation. That is the
> > > > > reason for splitting things between .dts and .dtsi to avoid such ugly
> > > > > ifdefs    
> > > > 
> > > > Then IMHO the pnictrl-* entries shouldn't appear in the dsti.
> > > >   
> > > hmm, maybe now I understand your idea:
> > > You do not want only to have
> > > 
> > >   pinctrl_lm3630a_bl_gpio: lm3630a_bl_gpio_grp {
> > >                         fsl,pins = <
> > >                                 MX6SLL_PAD_EPDC_PWR_CTRL3__GPIO2_IO10   0x10059 /* HWEN */  
> > >                         >;  
> > >                 };
> > > in dts, but also  do not have these in .dtsi:
> > > 
> > >                 pinctrl-names = "default";
> > >                 pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
> > > 
> > > and instead have in dts:
> > > &lm3630a {
> > >  	pinctrl-names = "default";
> > >         pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
> > > 	
> > > };
> > > 
> > > 
> > > just to make sure I get it right before doing the restructuring work. That way of structuring things did not come to my mind, but then the .dtsi is self-contained.  
> > 
> > That is what I mean but wait for Shawn's comments. It's just my opinion
> > that .dtsi and .dts files should be self-contained.
> 
> for files like the imx6sll.dtsi, I would clearly agree, here it might
> hide errors like missing pinmuxes in the dts, so it is not so clear.
> But if there is is consensus about .dtsi being self-contained I will not
> refuse to restructurize my work.

Yes, I would appreciate the effort of keep .dtsi being self-contained.

Shawn
