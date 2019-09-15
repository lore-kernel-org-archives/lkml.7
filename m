Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860CC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7641F214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jrUraqf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfIOO7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 10:59:01 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38382 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfIOO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T41zXqwFTZnFv5jJR7KFp66Sn49JT2O0ng3vIKC9TcM=; b=jrUraqf0BunV/bVTalwUfGsXl
        kQN3xs2aAa4h3ASgd5vPy4H9TqN0u4LkJD7be6oTxYi7FHmBXvzxVNO8tuS7XegMnK458PkR57bCS
        oKl26FkLNQTwUHL6UaNFWL9PNPQvmEIEzj7dQUvillQflEVPPzvebPUi7UjEG1WTW49laJEfjZ0oN
        iDRmfmbNvvNPw65dblbxRAwApS3ln7KCJeF3PTKvwVgpqBZOg+ONJre5AZzY8Q1Nqyd/7HHefXAFl
        zGkufuh+fR/7WgKO4mjErl31rw1c5GVJ9vza6nnm26tryeIc97eV+x1A9QZaEMPduVhakP79Ztcr0
        Xl7MeFkbg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:39856)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i9VzI-0006t2-Fj; Sun, 15 Sep 2019 15:58:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i9VzA-0007rp-Gw; Sun, 15 Sep 2019 15:58:44 +0100
Date:   Sun, 15 Sep 2019 15:58:44 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        tinywrkb <tinywrkb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190915145844.GE25745@shell.armlinux.org.uk>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190915140639.GC25745@shell.armlinux.org.uk>
 <20190915141552.GD25745@shell.armlinux.org.uk>
 <20190915144252.GA17261@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915144252.GA17261@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 04:42:52PM +0200, Andrew Lunn wrote:
> > > OF: fdt: Machine model: SolidRun HummingBoard Solo/DualLite
> > > ...
> > > # ethtool eth0
> > > Settings for eth0:
> > >         Supported ports: [ TP MII ]
> > >         Supported link modes:   10baseT/Half 10baseT/Full
> > >                                 100baseT/Half 100baseT/Full
> > >                                 1000baseT/Full
> > >         Supported pause frame use: Symmetric
> > >         Supports auto-negotiation: Yes
> > >         Supported FEC modes: Not reported
> > >         Advertised link modes:  10baseT/Half 10baseT/Full
> > >                                 100baseT/Half 100baseT/Full
> > >                                 1000baseT/Full
> > >         Advertised pause frame use: Symmetric
> > >         Advertised auto-negotiation: Yes
> > >         Advertised FEC modes: Not reported
> > >         Link partner advertised link modes:  10baseT/Half 10baseT/Full
> > >                                              100baseT/Half 100baseT/Full
> > >                                              1000baseT/Full
> > >         Link partner advertised pause frame use: Symmetric
> > >         Link partner advertised auto-negotiation: Yes
> > >         Link partner advertised FEC modes: Not reported
> > >         Speed: 1000Mb/s
> > >         Duplex: Full
> > >         Port: MII
> > >         PHYAD: 0
> > >         Transceiver: internal
> > >         Auto-negotiation: on
> > >         Supports Wake-on: d
> > >         Wake-on: d
> > >         Link detected: yes
> 
> > Note that the FEC does *not* support 1000baseT/Half.
> 
> Hi Russell
> 
> fec_main.c has code to mask it out. And it is not listed in the modes
> you have above. So as you say, this all looks to be working.
> 
> I'm wondering if there is an older variant of the hardware with
> 100Mbps magnetics, and the boot loader is setting something in the
> PHY? It could be we are now stomping over that?

Not according to Rabeeh, the SolidRun CTO:

< rabeeh> all i.MX6 based machines from SolidRun are 1Gbps phys
< rabeeh> i thought that we fixed that information, documentation wise;
          but seems not

Even the Carrier1 board that pre-dates Hummingboards had the AR8035
with 1G magnetics.

The schematics I have for the Cubox-i state that the RJ45 jack (which
contains the magnetics) is to be "Gigabit".

There was a 10/100M option for the microsom, which is selected by where
a resistor pack is fitted, having the effect of configuring the AR8035
differently.  I seem to recall the 10/100M option in the early days was
to use a different Atheros PHY.

However, I'm not aware of 10/100M option making it into production, and
Rabeeh's comment (who was involved in the design) confirms that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
