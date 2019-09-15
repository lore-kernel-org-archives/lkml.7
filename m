Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC611C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD585216F4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O4qJeJ59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfIOOm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 10:42:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46944 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfIOOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xMf0N4K2EgA3OUVay8T7uJqPe+W0bKJBfCqBZvUVfYk=; b=O4qJeJ59kDtv4wGtvnnVT6JpDi
        Y3WowKRfuE2WOGLv7wp6e0j6GymzHYw9dMik4XLOXSRz41wglcLbJb9vWvFUVjWeshj6a9TyKadcm
        +4xYbG+lBAYY0e3bWcFszP0eZOERrelUw0C0dFIX3q7Jo/bw6WaH6JzkLPUEd32MAXIk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i9Vjo-0004Wx-AG; Sun, 15 Sep 2019 16:42:52 +0200
Date:   Sun, 15 Sep 2019 16:42:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
Message-ID: <20190915144252.GA17261@lunn.ch>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190915140639.GC25745@shell.armlinux.org.uk>
 <20190915141552.GD25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915141552.GD25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > OF: fdt: Machine model: SolidRun HummingBoard Solo/DualLite
> > ...
> > # ethtool eth0
> > Settings for eth0:
> >         Supported ports: [ TP MII ]
> >         Supported link modes:   10baseT/Half 10baseT/Full
> >                                 100baseT/Half 100baseT/Full
> >                                 1000baseT/Full
> >         Supported pause frame use: Symmetric
> >         Supports auto-negotiation: Yes
> >         Supported FEC modes: Not reported
> >         Advertised link modes:  10baseT/Half 10baseT/Full
> >                                 100baseT/Half 100baseT/Full
> >                                 1000baseT/Full
> >         Advertised pause frame use: Symmetric
> >         Advertised auto-negotiation: Yes
> >         Advertised FEC modes: Not reported
> >         Link partner advertised link modes:  10baseT/Half 10baseT/Full
> >                                              100baseT/Half 100baseT/Full
> >                                              1000baseT/Full
> >         Link partner advertised pause frame use: Symmetric
> >         Link partner advertised auto-negotiation: Yes
> >         Link partner advertised FEC modes: Not reported
> >         Speed: 1000Mb/s
> >         Duplex: Full
> >         Port: MII
> >         PHYAD: 0
> >         Transceiver: internal
> >         Auto-negotiation: on
> >         Supports Wake-on: d
> >         Wake-on: d
> >         Link detected: yes

> Note that the FEC does *not* support 1000baseT/Half.

Hi Russell

fec_main.c has code to mask it out. And it is not listed in the modes
you have above. So as you say, this all looks to be working.

I'm wondering if there is an older variant of the hardware with
100Mbps magnetics, and the boot loader is setting something in the
PHY? It could be we are now stomping over that?

We need to see output like yours, but on a device which is
experiencing the problem.

	     Andrew
