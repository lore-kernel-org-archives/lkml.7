Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02302080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="flicGF8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408662AbfITKge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:36:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60818 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393577AbfITKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OqnJbMKZf+jB/1frWLHcbvpcFTP1xDtJjx0l4FcIer0=; b=flicGF8fB5EcjyHS/GqpbQwx6
        gANNgMd5t46ZpYwh6aQHyDhHGInQiibEN9gcoHBE0WvRwl1CsRRqVfgjDWtPVjkHr35ukxm7y2S4J
        zoOgZAH55fyc4+d1utnGUM/1k+5drU1y2S0oCt3V/kFzcd0G/H9SXCrljTv/1u6X0xOrQS1huvBIo
        X43PctZ7uHezIXK0rHZDyQEIXaSgsPtmJKLVQCrpeLBX7StJjfBOukRQSwwimjkxJqmfN4dmsuCEb
        rX1fXdnDiYvy13AC6Vhw/cw/FwFL3vac0B7eiV8tIbEeKBdxMrgZYpwFaaOlJDHiqU/oArEWQ2xQp
        7cb/sNNqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45958)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iBGH5-0003Me-9G; Fri, 20 Sep 2019 11:36:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iBGH0-0005jR-6j; Fri, 20 Sep 2019 11:36:22 +0100
Date:   Fri, 20 Sep 2019 11:36:22 +0100
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
Message-ID: <20190920103622.GL25745@shell.armlinux.org.uk>
References: <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
 <20190917170419.GX25745@shell.armlinux.org.uk>
 <20190917171913.GY25745@shell.armlinux.org.uk>
 <20190917172658.GB9591@lunn.ch>
 <20190917173728.GZ25745@shell.armlinux.org.uk>
 <20190917181905.GA25745@shell.armlinux.org.uk>
 <20190917183934.GJ20778@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917183934.GJ20778@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 08:39:34PM +0200, Andrew Lunn wrote:
> > > Well, the _correct_ driver needs to be used for the PHY specific
> > > features to be properly controlled.  Using the generic driver
> > > in this situation will not be guaranteed to work.
> 
> I fully agree about the PHY driver. I'm expect this device is
> violating c22 when it modifies the advertisement register itself. So
> all bets are off for the genphy.
> 
> > Well, this hasn't worked, but not for the obvious reason.  Register 0x14
> > is documented as read/write.  Bits 15:6 are reserved, bit 5 is the
> > smart speed enable, 4:2 configures the attempts, bit 1 sets the link
> > stable condition, bit 0 is reserved.
> > 
> > Writing 0x80c results in the register reading back 0x82c.  Writing
> > 0x800 results in the same.  Writing 0 reads back 0x2c.  Writing 0xffff
> > seems to prevent packets being passed - and at that point I lost
> > control so I couldn't see what the result was.
> > 
> > There is nothing in the data sheet which suggests that there is any
> > gating of this register.  So it looks like we're stuck with smartspeed
> > enabled.
> > 
> > So, I think there's only two remaining ways forward - to revert commit
> > 5502b218e001 to restore the old behaviour, read back the advertisement
> > from the PHY along with the rest of the status, as I've previously
> > stated.  It means that phylib will modify phydev->advertising at
> > random points, just as it modifies phydev->lp_advertising, so locking
> > may become an issue.  The revert approach is probably best until we
> > have something working along those lines.
> 
> We have a couple of other PHYs which support downshift. We should see
> if we can follow what they do. What is i think important is that
> read_status return the correct speed. So we probably cannot use
> genphy_read_status() as is. Maybe we should split genphy_read_status()
> into two, so the register reading bit can be done unconditionally by
> phy drivers for hardware which don't report link down when they
> should?

I think we need to check how the downshift feature works on other PHYs
and whether it is enabled there.

Looking at the Marvell 88e151x PHYs, they have the feature, but do not
enable it by default.  If firmware has enabled the feature, phylib will
incorrectly resolve the link speed based on just the advertisements.

I think the safest way in the case of both PHYs to ascertain the real
link speed is to read the Specific Status register - register 17 in
both cases.  The top two bits indicate the negotiated speed resolution
and bit 13 indicates the duplex.  Bit 11 indicates whether the
resolution is valid.  This register layout seems to apply to both
88e151x and AR8035.

The register also contains the pause mode resolution in terms of
receive or transmit pause enabled, but this is not useful to phylib
as that is not what phylib wants to know.  However, it probably makes
sense for phylib to resolve the pause mode negotiation itself rather
than having that logic in the MAC drivers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
