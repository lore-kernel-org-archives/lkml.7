Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896E5C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500DD218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Asg2a24U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfIQWoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:44:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47982 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfIQWoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7b1wJptxiHP2scckURIjOmEh0c/YmoNLFDbh3F0rfxY=; b=Asg2a24U7IY3rANxoXt2+wltm
        m4BI026Bdd22mXvJkt2UXp94C55QflsA/rs33RyaINyaWzcO9uXqfjKVXAaVPgxRJIT21PPoiAfJ9
        j1dMzCcb9TlEveByYS8fDslbVqop315z9JEUY/DbAvLPGwTHIpyGt/zitpTfkBTBjPq7smIoTR4Q6
        PiYmZWRHyj9YMe9H0UHSEro3Dcn6zeQsxGpZn9qhtBkRKQI48wAKEydLBVu79QCVHsdsSRsZsD7PQ
        A+HTe54ZbvUWwkkqjqHnml3lnZmYKmhKWTMgeLm6EsdmIwv6aqSAui5UThMMwUtsbON73nwNE+3dG
        sHwNgkDvw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40812)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAMCP-0004XQ-1e; Tue, 17 Sep 2019 23:43:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAMCJ-0001fl-Hf; Tue, 17 Sep 2019 23:43:47 +0100
Date:   Tue, 17 Sep 2019 23:43:47 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     tinywrkb <tinywrkb@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Baruch Siach <baruch@tkos.co.il>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190917224347.GD25745@shell.armlinux.org.uk>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190917124101.GA1200564@arch-dsk-01>
 <20190917125434.GH20778@lunn.ch>
 <20190917133253.GA1210141@arch-dsk-01>
 <20190917223013.GC25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917223013.GC25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 11:30:13PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Sep 17, 2019 at 04:32:53PM +0300, tinywrkb wrote:
> > Here's the output of # mii-tool -v -v eth0 
> > 
> > * linux-test-5.1rc1-a2703de70942-without_bad_commit
> > 
> > Using SIOCGMIIPHY=0x8947
> > eth0: negotiated 100baseTx-FD flow-control, link ok
> >   registers for MII PHY 0:
> >     3100 796d 004d d072 15e1 c5e1 000f 0000
> >     0000 0000 0800 0000 0000 0000 0000 a000
> >     0000 0000 0000 f420 082c 0000 04e8 0000
> >     3200 3000 0000 063d 0000 0000 0000 0000
> 
> I'll also mention some other discrepencies that I've just spotted in
> this register set.
> 
> The BMSR is 0x796d.  Bit 2 is the link status, which is indicating
> that link is up.  Bit 5 indicates negotiation complete, which it
> claims it is.
> 
> The PHY has a second status register at 0x11 which gives real time
> information.  That is 0x0000.  Bit 10 indicates link up, and is
> indicating that the link is down.  Bit 11 is saying that the speed
> and duplex is not resolved either.
> 
> So, there's contradictory information being reported by this PHY.
> 
> This brings up several questions:
> 1. what is the _true_ state of the link?  Is the link up or down?
> 
> 2. what does the link partner think is the current link state and
>    results of negotiation?
> 
> 3. should we be reading the register at 0x11 to determine the
>    negotiation results and link state (maybe logically anding the
>    present state with the BMSR link state)?
> 
> 
> Compare that to a correctly functioning AR8035 such as I have in my
> cubox-i4 connected to a Netgear GS116 switch:
> 
>    3100 796d 004d d072 15e1 c5e1 000d 2001
>    0000 0200 3c00 0000 0000 4007 b29a a000
>    0862 bc1c 0000 0000 082c 0000 07e8 0000
>    3200 3000 0000 063e 0000 0005 2d47 8100.
> 
> BMSR is again 0x796d.  The PHY specific status register this time
> is 0xbc1c, which indicates 1G, full duplex, resolved, link up, no
> smartspeed downgrade, tx/rx pause.
> 
> The register at 0x10 is a control register, which is strangely also
> different between our two.  Apparently in your PHY configuration,
> auto-MDI crossover mode is disabled, you are forced to MDI mode.
> On hardware reset, this register contains 0x0862, as per my
> example above, but yours is zero.
> 
> I don't think the difference in register 0x10 can be explained away
> by operation of the smartspeed feature - so maybe my theory about
> the advertisement registers being cleared by the PHY is wrong.  The
> question is: how is 0x10 getting reset to zero in your setup?  Maybe
> something has corrupted the configuration of the PHY in ways that
> Linux doesn't know how to reprogram?
> 
> Have you tried power-cycling the cubox-i?

Hopefully one last thing, which will explain why you may not be able
to get an IP address even with some of these tweaks I've been getting
you to try.  Do you have either none or both of these commits in your
kernel?

0672d22a1924 ("ARM: dts: imx: Fix the AR803X phy-mode")
6d4cd041f0af ("net: phy: at803x: disable delay only for RGMII mode")

I think you'll have the latter but not the former.  You will need the
former if you have the latter.

I think this thread is a good illustration why breaking existing DT
compatibility - even for the sake of fixing a bug - is just bad news.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
