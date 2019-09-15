Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7643BC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A20206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ejAuYKri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfIOOP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 10:15:59 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37894 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIOOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Sr4NPjbaVlU3bIjCr/wLaVw22kxZgLPWY1ICbkVA1E=; b=ejAuYKriiw0ypu1l5nnqcttS6
        MiWBKPSdxCxGdMVB9/al4vXj112vBRD0cuHJPaiatLYAMHUBcQLBRPSFl0+96FAppAm3O0eWKmFpC
        zywvJPGd/r2BrPAI9ktCun9v3RJWF8lOpKAyEZjuKid7L2dXRW3PdrGmOF5CeeD/KLObbsOz12vi/
        g370Xe5UaVlMn9NEUc0XgE/51m5xV8AQBpHlzu378KPkHcWjlWAWYPQ/GjQP4lf+Y23hbo7pf/pwI
        mtIw5HHT4zqpPHaRDKhf/c/1s0vm7E2fY58d+0wFSMT7+blpYsipsRAQNNgDMm6e2ug4FOhvKGScx
        MHz5+8HTQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:60556)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i9VJh-0006iN-Kd; Sun, 15 Sep 2019 15:15:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i9VJg-0007pT-J2; Sun, 15 Sep 2019 15:15:52 +0100
Date:   Sun, 15 Sep 2019 15:15:52 +0100
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
Message-ID: <20190915141552.GD25745@shell.armlinux.org.uk>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190915140639.GC25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915140639.GC25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 03:06:39PM +0100, Russell King - ARM Linux admin wrote:
> On Sun, Sep 15, 2019 at 03:56:52PM +0200, Andrew Lunn wrote:
> > > Tinywrkb confirmed to me in private communication that revert of
> > > 5502b218e001 fixes Ethernet for him on effected system.
> > > 
> > > He also referred me to an old Cubox-i spec that lists 10/100 Ethernet
> > > only for i.MX6 Solo/DualLite variants of Cubox-i. It turns out that
> > > there was a plan to use a different 10/100 PHY for Solo/DualLite
> > > SOMs. This plan never materialized. All SolidRun i.MX6 SOMs use the same
> > > AR8035 PHY that supports 1Gb.
> > > 
> > > Commit 5502b218e001 might be triggering a hardware issue on the affected
> > > Cubox-i. I could not reproduce the issue here with Cubox-i and a Dual
> > > SOM variant running v5.3-rc8. I have no Solo/DualLite variant handy at
> > > the moment.
> > 
> > Could somebody with an affected device show us the output of ethtool
> > with and without 5502b218e001. Does one show 1G has been negotiated,
> > and the other 100Mbps? If this is true, how does it get 100Mbps
> > without that patch? We are missing a piece of the puzzle.
> 
> Hang on.  5502b218e001 is in 5.2 already - it was merged as part of the
> v5.1 merge window.  That means my imx6 Solo Hummingboard is already
> running it with the AR8035 PHY, and it works fine.
> 
> # dmesg
> ...
> OF: fdt: Machine model: SolidRun HummingBoard Solo/DualLite
> ...
> # ethtool eth0
> Settings for eth0:
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>         Advertised pause frame use: Symmetric
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Link partner advertised link modes:  10baseT/Half 10baseT/Full
>                                              100baseT/Half 100baseT/Full
>                                              1000baseT/Full
>         Link partner advertised pause frame use: Symmetric
>         Link partner advertised auto-negotiation: Yes
>         Link partner advertised FEC modes: Not reported
>         Speed: 1000Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 0
>         Transceiver: internal
>         Auto-negotiation: on
>         Supports Wake-on: d
>         Wake-on: d
>         Link detected: yes

For some further testing, by changing the advertisment on the DSA
switch (other end of this platform's link):

        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
...
        Speed: 100Mb/s
        Duplex: Full
===============
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half
...
        Speed: 100Mb/s
        Duplex: Half
===============
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
...
        Speed: 10Mb/s
        Duplex: Full
===============
        Link partner advertised link modes:  10baseT/Half
...
        Speed: 10Mb/s
        Duplex: Half

So it looks like the commit works as it should.  So there's something
else going on.

Note that the FEC does *not* support 1000baseT/Half.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
