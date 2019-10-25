Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDACA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E91A21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="g1AI5EI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408996AbfJYKJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:09:42 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:41088 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404388AbfJYKJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YYQQNgawfccK6LNWtTEklH/kQejW+Vx5ShbN7nqdkXE=; b=g1AI5EI/tOmWF44gvc7zJhVYaK
        9dv7t1flx81eGGZ8vAulAcP0qOGEc64dcnLVQQB8ohYNsoMVM4k593XxxYQL9MDDCOBktLl84eRzC
        sRtu1C3zaqRHlTjv/8C/+9hUtNFLVjyiz+sO8CygFxAuRV/Jq56burH1rspqn1xphy7E=;
Received: from p200300ccff09ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iNwX9-0000h4-Iy; Fri, 25 Oct 2019 12:09:30 +0200
Date:   Fri, 25 Oct 2019 12:09:25 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Shawn Guo <shawnguo@kernel.org>
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
Message-ID: <20191025120925.327e70fd@aktux>
In-Reply-To: <20191025091401.GL3208@dragon>
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
        <20191025091401.GL3208@dragon>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Fri, 25 Oct 2019 17:14:04 +0800
Shawn Guo <shawnguo@kernel.org> wrote:

> On Sun, Oct 13, 2019 at 05:56:44PM +0200, Andreas Kemnade wrote:
> > On Fri, 11 Oct 2019 18:56:33 +0200
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> > > On 19-10-11 18:19, Andreas Kemnade wrote:  
> > > > On Fri, 11 Oct 2019 17:22:14 +0200
> > > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > >     
> > > > > On 19-10-11 17:05, Andreas Kemnade wrote:    
> > > > > > On Fri, 11 Oct 2019 09:29:27 -0500
> > > > > > Rob Herring <robh@kernel.org> wrote:
> > > > > >       
> > > > > > > On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote:      
> > > > > > > > On Fri, 11 Oct 2019 08:56:09 +0200
> > > > > > > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > > > > >         
> > > > > > > > > Hi Andreas,
> > > > > > > > > 
> > > > > > > > > On 19-10-10 21:23, Andreas Kemnade wrote:        
> > > > > > > > > > The Netronix board E60K02 can be found some several Ebook-Readers,
> > > > > > > > > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > > > > > > > > is equipped with different SoCs requiring different pinmuxes.
> > > > > > > > > > 
> > > > > > > > > > For now the following peripherals are included:
> > > > > > > > > > - LED
> > > > > > > > > > - Power Key
> > > > > > > > > > - Cover (gpio via hall sensor)
> > > > > > > > > > - RC5T619 PMIC (the kernel misses support for rtc and charger
> > > > > > > > > >   subdevices).
> > > > > > > > > > - Backlight via lm3630a
> > > > > > > > > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > > > > > > > > 
> > > > > > > > > > It is based on vendor kernel but heavily reworked due to many
> > > > > > > > > > changed bindings.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > > > > > > ---
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - better led name
> > > > > > > > > > - correct memory size
> > > > > > > > > > - comments about missing devices
> > > > > > > > > > 
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - reordered, was 1/3
> > > > > > > > > > - moved pinmuxes to their actual users, not the parents
> > > > > > > > > >   of them
> > > > > > > > > > - removed some already-disabled stuff
> > > > > > > > > > - minor cleanups          
> > > > > > > > > 
> > > > > > > > > You won't change the muxing, so a this dtsi can be self contained?
> > > > > > > > >         
> > > > > > > > So you want me to put a big 
> > > > > > > > #if defined(MX6SLL)         
> > > > > > > 
> > > > > > > Not sure what the comment meant, but no, don't do this. C defines in dts 
> > > > > > > files are for symbolic names for numbers and assembling bitfields and 
> > > > > > > that's it.      
> > > > > > 
> > > > > > yes, that is also my opinion. For now, there is only one user
> > > > > > of this .dtsi, but I have another one in preparation. That is the
> > > > > > reason for splitting things between .dts and .dtsi to avoid such ugly
> > > > > > ifdefs      
> > > > > 
> > > > > Then IMHO the pnictrl-* entries shouldn't appear in the dsti.
> > > > >     
> > > > hmm, maybe now I understand your idea:
> > > > You do not want only to have
> > > > 
> > > >   pinctrl_lm3630a_bl_gpio: lm3630a_bl_gpio_grp {
> > > >                         fsl,pins = <
> > > >                                 MX6SLL_PAD_EPDC_PWR_CTRL3__GPIO2_IO10   0x10059 /* HWEN */    
> > > >                         >;    
> > > >                 };
> > > > in dts, but also  do not have these in .dtsi:
> > > > 
> > > >                 pinctrl-names = "default";
> > > >                 pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
> > > > 
> > > > and instead have in dts:
> > > > &lm3630a {
> > > >  	pinctrl-names = "default";
> > > >         pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
> > > > 	
> > > > };
> > > > 
> > > > 
> > > > just to make sure I get it right before doing the restructuring work. That way of structuring things did not come to my mind, but then the .dtsi is self-contained.    
> > > 
> > > That is what I mean but wait for Shawn's comments. It's just my opinion
> > > that .dtsi and .dts files should be self-contained.  
> > 
> > for files like the imx6sll.dtsi, I would clearly agree, here it might
> > hide errors like missing pinmuxes in the dts, so it is not so clear.
> > But if there is is consensus about .dtsi being self-contained I will not
> > refuse to restructurize my work.  
> 
> Yes, I would appreciate the effort of keep .dtsi being self-contained.

ok, then I will restructurize as proposed and create a v4 this weekend.

Regards,
Andreas
