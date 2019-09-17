Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA30DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DAC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dw1Ynj6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfIQRTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:19:22 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44304 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfIQRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o09IJPFom4bA0IbsaraWZgb9r5yRyE3Qt6Bk2EdwWb8=; b=dw1Ynj6y/LKN5rrBNbZtIjKCK
        9eVTSd2XRe+Zqh8caSAZlFd6EBG1X2ssHlksjGHfDE2XmRJmm2M09K6ht37qFlKkvlAO6esN1Tm77
        A+L8P71ULx0HRllNqWoMZjWEfpgjRbEAdLVNM4Ee2Z2XmWy8LS1nAU3n+wurSAutM0/HVIUjvks09
        YgYfJnpSmrPw5SkaJ6//DWgEOQNl7JfMEOQBGoN3uFpLDynlIuEX2e99jgFZzXU8+3T2BjSj38EK5
        +4/CH9SHbQ9v3XQxWPu6nezl6vEcMbJFcIK+snstv8Isn9AXsK3sP4sRpUGDkkV6h7i//Ke5LjObE
        xuF9NVGUQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:33196)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAH8E-0003Ad-71; Tue, 17 Sep 2019 18:19:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAH8D-0001TX-7E; Tue, 17 Sep 2019 18:19:13 +0100
Date:   Tue, 17 Sep 2019 18:19:13 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     tinywrkb <tinywrkb@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Baruch Siach <baruch@tkos.co.il>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190917171913.GY25745@shell.armlinux.org.uk>
References: <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190917124101.GA1200564@arch-dsk-01>
 <20190917125434.GH20778@lunn.ch>
 <20190917133253.GA1210141@arch-dsk-01>
 <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
 <20190917170419.GX25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917170419.GX25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 06:04:19PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Sep 17, 2019 at 07:34:27PM +0300, tinywrkb wrote:
> > The patch didn't fix the issue.
> > 
> > # ethtool eth0
> > 
> > Settings for eth0:
> > 	Supported ports: [ TP MII ]
> > 	Supported link modes:   10baseT/Half 10baseT/Full
> > 	                        100baseT/Half 100baseT/Full
> > 	                        1000baseT/Full
> > 	Supported pause frame use: Symmetric
> > 	Supports auto-negotiation: Yes
> > 	Supported FEC modes: Not reported
> > 	Advertised link modes:  10baseT/Half 10baseT/Full
> > 	                        100baseT/Half 100baseT/Full
> > 	                        1000baseT/Full
> > 	Advertised pause frame use: Symmetric
> > 	Advertised auto-negotiation: Yes
> > 	Advertised FEC modes: Not reported
> > 	Link partner advertised link modes:  10baseT/Half 10baseT/Full
> > 	                                     100baseT/Half 100baseT/Full
> > 	                                     1000baseT/Full
> > 	Link partner advertised pause frame use: Symmetric
> > 	Link partner advertised auto-negotiation: Yes
> > 	Link partner advertised FEC modes: Not reported
> > 	Speed: 1000Mb/s
> > 	Duplex: Full
> > 	Port: MII
> > 	PHYAD: 0
> > 	Transceiver: internal
> > 	Auto-negotiation: on
> > 	Supports Wake-on: d
> > 	Wake-on: d
> > 	Link detected: yes
> > 
> > # mii-tool -v -v eth0
> > 
> > Using SIOCGMIIPHY=0x8947
> > eth0: negotiated 100baseTx-FD flow-control, link ok
> >   registers for MII PHY 0:
> >     3100 796d 004d d072 15e1 c5e1 000f 0000
> >     0000 0000 0800 0000 0000 0000 0000 a000
> >     0000 0000 0000 f420 082c 0000 04e8 0000
> >     3200 3000 0000 063d 0000 0000 0000 0000
> >   product info: vendor 00:13:74, model 7 rev 2
> >   basic mode:   autonegotiation enabled
> >   basic status: autonegotiation complete, link ok
> >   capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
> >   advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
> >   link partner: 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
> > 
> > # journalctl -b | egrep -i 'phy|eth|fec'|grep -v usb
> > 
> > kernel: Booting Linux on physical CPU 0x0
> > kernel: libphy: Fixed MDIO Bus: probed
> > kernel: libphy: fec_enet_mii_bus: probed
> > kernel: fec 2188000.ethernet eth0: registered PHC device 0
> > kernel: dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
> > kernel: Generic PHY 2188000.ethernet-1:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
> > kernel: fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> > kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> > systemd-networkd[242]: eth0: Gained carrier
> 
> Okay, so this is getting weird.
> 
> ethtool still shows that 1000baseT/Full is being advertised, yet the
> PHY disagrees:
> 
>      3100 796d 004d d072 15e1 c5e1 000f 0000
>      0000 0000 0800 0000 0000 0000 0000 a000
>           ^^^^
> Gigabit control register, bits 9 should be set, but it's clear.
> 
> Looking at the following registers, brings up another possibility what
> is going on:
> 
>      0000 0000 0000 f420 082c 0000 04e8 0000
>                     ^^^^ ^^^^
> 
> These two registers may provide a hint.  Of the first register, which
> is the interrupt status register, bit 5 is set, indicating that a
> "smartspeed downgrade occurred".  The second register is the smartspeed
> configuration, which basically says that the feature is enabled.
> 
> Smartspeed is designed to allow the link to come up if two-pair CAT5
> cable is used (are you using a 4-pair or 2-pair cable?) by making the
> link fall back to 100mbit, or with CAT3 cable, 10mbit speeds.  What
> isn't specified is whether it does this by clearing bits in the various
> advertisement registers.
> 
> Given what you've said so far, I'd suggest that this is indeed the
> case - when smartspeed is triggered, advertisement bits are cleared by
> the PHY without the kernel's knowledge, leading to the kernel getting
> the speed resolution incorrect after 5502b218e001.
> 
> There's another issue here - if smartspeed clears advertisement bits,
> then if you connect a 4-pair cable after having used a 2-pair cable,
> you'd still be limited to 100mbit.  The ethtool output will be just
> as confusing.
> 
> The only thing I can think we should do is to read-back the
> advertisement from the PHY whenever we read the rest of the status
> and update the phy->advertising mask, just like we do with the link
> partner advertisement.

This patch will disable smartspeed - could you see what happens, and
whether you can get the link to come up at all.  You might need to see
whether wiggling the RJ45 helps (I've had that sort of thing with some
cables.)

You might also need "ethtool -s eth0 advertise ffcf" after trying that
if it doesn't work to take the gigabit speeds out of the advertisement.

Thanks.

 drivers/net/phy/at803x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b3893347804d..85cf4a4a5e81 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -296,6 +296,11 @@ static int at803x_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Disable smartspeed */
+	ret = phy_modify(phydev, 0x14, BIT(5), 0);
+	if (ret < 0)
+		return ret;
+
 	/* The RX and TX delay default is:
 	 *   after HW reset: RX delay enabled and TX delay disabled
 	 *   after SW reset: RX delay enabled, while TX delay retains the

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
