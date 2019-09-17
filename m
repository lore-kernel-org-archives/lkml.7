Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7457C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7C72171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u1tOKegF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfIQVmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:42:19 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47296 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfIQVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Abx4F+jwfMTtLUNyxvhKvVfgeehUhHffQfO59dPVzBw=; b=u1tOKegFJUc9oNAXUMrowBe6t
        iSId7UHGw8DY7GFuW0EYnNtI5SS6w4mX6cD8gSmefCRb+N824LNIPTzXf1/4YGG0BFfzxQqMoObSZ
        LfMACLLy+j9oFRNcw+MdfXOYe4T+e3KF4tW7S2fgYgGprjml5pz292h05s+6Jor5vQc4grFhCQwVF
        ucHSFoeguoJbs1R74HGKDwjPvCG1cB2OavYY7cIsOTxrPlGtd514CzqYPKSPV2tmxkNWh/GarOWB2
        lCrmanipMghHbtgJk2wvBcoQbKmY5/HFYg9eGdcpOPdGmYGmV9PfYsMjNLowLg2UTeTraZI1use1/
        55U7FD6hw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44930)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iALEb-0004Hs-3X; Tue, 17 Sep 2019 22:42:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iALEX-0001dO-MT; Tue, 17 Sep 2019 22:42:01 +0100
Date:   Tue, 17 Sep 2019 22:42:01 +0100
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
Message-ID: <20190917214201.GB25745@shell.armlinux.org.uk>
References: <20190915135652.GC3427@lunn.ch>
 <20190917124101.GA1200564@arch-dsk-01>
 <20190917125434.GH20778@lunn.ch>
 <20190917133253.GA1210141@arch-dsk-01>
 <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
 <20190917170419.GX25745@shell.armlinux.org.uk>
 <20190917171913.GY25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917171913.GY25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 06:19:13PM +0100, Russell King - ARM Linux admin wrote:
> whether you can get the link to come up at all.  You might need to see
> whether wiggling the RJ45 helps (I've had that sort of thing with some
> cables.)
> 
> You might also need "ethtool -s eth0 advertise ffcf" after trying that
> if it doesn't work to take the gigabit speeds out of the advertisement.
> 
> Thanks.
> 
>  drivers/net/phy/at803x.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index b3893347804d..85cf4a4a5e81 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -296,6 +296,11 @@ static int at803x_config_init(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Disable smartspeed */
> +	ret = phy_modify(phydev, 0x14, BIT(5), 0);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* The RX and TX delay default is:
>  	 *   after HW reset: RX delay enabled and TX delay disabled
>  	 *   after SW reset: RX delay enabled, while TX delay retains the

Hi,

Could you try this patch instead - it seems that the PHY needs to be
soft-reset for the write to take effect, and _even_ for the clearance
of the bit to become visible in the register.

I'm not expecting this on its own to solve anything, but it should at
least mean that the at803x doesn't modify the advertisement registers
itself.  It may mean that the link doesn't even come up without forcing
the advertisement via the ethtool command I mentioned before.

Thanks.

 drivers/net/phy/at803x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b3893347804d..69a58c0e6b42 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -296,6 +296,16 @@ static int at803x_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Disable smartspeed */
+	ret = phy_modify(phydev, 0x14, BIT(5), 0);
+	if (ret < 0)
+		return ret;
+
+	/* Must soft-reset the PHY for smartspeed disable to take effect */
+	ret = genphy_soft_reset(phydev);
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
