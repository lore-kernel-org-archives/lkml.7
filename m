Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B9C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573232067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W3RKu9YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfIQREd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:04:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44108 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfIQREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kq0CocEY9i4/5e+2igO8Cik75CQMtIKP4GgD17cUQo4=; b=W3RKu9YPCV8TsiO0pKS6tbgX4
        6OBHY3CDKjT+9eFudvercZJOcgz3vv584J0P65B9IMswiyIiic+AuoqdJdVqVMkDnmK5gLqlucfLG
        lW2u5U9nEPUj+VECWwMlbb1+2Wgckt5VeQLKquPObMGA7MBg37Dekn9z5Ulqx8orTsjBwRpSQdy1u
        ZnuJIvM8C/zOaBB8b2WGypZ0TmrUPvwkOC2xpAp1qCsg52hhGCWpbrDCWHktzULRGnWqXkdN0N1wi
        j0/cHkDAnPxXs5yeolO/poFT1sSFyHFziscsBI8QquESxddTcJfKPWQxvL3gPLcrW7fwRMFggl3Bf
        yuUEbrFag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44848)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAGtr-00035z-Fx; Tue, 17 Sep 2019 18:04:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAGtn-0001SK-M8; Tue, 17 Sep 2019 18:04:19 +0100
Date:   Tue, 17 Sep 2019 18:04:19 +0100
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
Message-ID: <20190917170419.GX25745@shell.armlinux.org.uk>
References: <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190917124101.GA1200564@arch-dsk-01>
 <20190917125434.GH20778@lunn.ch>
 <20190917133253.GA1210141@arch-dsk-01>
 <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917163427.GA1475935@arch-dsk-01>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 07:34:27PM +0300, tinywrkb wrote:
> The patch didn't fix the issue.
> 
> # ethtool eth0
> 
> Settings for eth0:
> 	Supported ports: [ TP MII ]
> 	Supported link modes:   10baseT/Half 10baseT/Full
> 	                        100baseT/Half 100baseT/Full
> 	                        1000baseT/Full
> 	Supported pause frame use: Symmetric
> 	Supports auto-negotiation: Yes
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  10baseT/Half 10baseT/Full
> 	                        100baseT/Half 100baseT/Full
> 	                        1000baseT/Full
> 	Advertised pause frame use: Symmetric
> 	Advertised auto-negotiation: Yes
> 	Advertised FEC modes: Not reported
> 	Link partner advertised link modes:  10baseT/Half 10baseT/Full
> 	                                     100baseT/Half 100baseT/Full
> 	                                     1000baseT/Full
> 	Link partner advertised pause frame use: Symmetric
> 	Link partner advertised auto-negotiation: Yes
> 	Link partner advertised FEC modes: Not reported
> 	Speed: 1000Mb/s
> 	Duplex: Full
> 	Port: MII
> 	PHYAD: 0
> 	Transceiver: internal
> 	Auto-negotiation: on
> 	Supports Wake-on: d
> 	Wake-on: d
> 	Link detected: yes
> 
> # mii-tool -v -v eth0
> 
> Using SIOCGMIIPHY=0x8947
> eth0: negotiated 100baseTx-FD flow-control, link ok
>   registers for MII PHY 0:
>     3100 796d 004d d072 15e1 c5e1 000f 0000
>     0000 0000 0800 0000 0000 0000 0000 a000
>     0000 0000 0000 f420 082c 0000 04e8 0000
>     3200 3000 0000 063d 0000 0000 0000 0000
>   product info: vendor 00:13:74, model 7 rev 2
>   basic mode:   autonegotiation enabled
>   basic status: autonegotiation complete, link ok
>   capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
>   advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
>   link partner: 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
> 
> # journalctl -b | egrep -i 'phy|eth|fec'|grep -v usb
> 
> kernel: Booting Linux on physical CPU 0x0
> kernel: libphy: Fixed MDIO Bus: probed
> kernel: libphy: fec_enet_mii_bus: probed
> kernel: fec 2188000.ethernet eth0: registered PHC device 0
> kernel: dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
> kernel: Generic PHY 2188000.ethernet-1:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
> kernel: fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> systemd-networkd[242]: eth0: Gained carrier

Okay, so this is getting weird.

ethtool still shows that 1000baseT/Full is being advertised, yet the
PHY disagrees:

     3100 796d 004d d072 15e1 c5e1 000f 0000
     0000 0000 0800 0000 0000 0000 0000 a000
          ^^^^
Gigabit control register, bits 9 should be set, but it's clear.

Looking at the following registers, brings up another possibility what
is going on:

     0000 0000 0000 f420 082c 0000 04e8 0000
                    ^^^^ ^^^^

These two registers may provide a hint.  Of the first register, which
is the interrupt status register, bit 5 is set, indicating that a
"smartspeed downgrade occurred".  The second register is the smartspeed
configuration, which basically says that the feature is enabled.

Smartspeed is designed to allow the link to come up if two-pair CAT5
cable is used (are you using a 4-pair or 2-pair cable?) by making the
link fall back to 100mbit, or with CAT3 cable, 10mbit speeds.  What
isn't specified is whether it does this by clearing bits in the various
advertisement registers.

Given what you've said so far, I'd suggest that this is indeed the
case - when smartspeed is triggered, advertisement bits are cleared by
the PHY without the kernel's knowledge, leading to the kernel getting
the speed resolution incorrect after 5502b218e001.

There's another issue here - if smartspeed clears advertisement bits,
then if you connect a 4-pair cable after having used a 2-pair cable,
you'd still be limited to 100mbit.  The ethtool output will be just
as confusing.

The only thing I can think we should do is to read-back the
advertisement from the PHY whenever we read the rest of the status
and update the phy->advertising mask, just like we do with the link
partner advertisement.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
