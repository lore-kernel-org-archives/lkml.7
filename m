Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627D02084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GcNCkckh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfCAOQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:16:05 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43252 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbfCAOQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8LUw/K+Tsq38wZJ1UV4G8v1nxv7Y/oaWDeuVHg2sq0Y=; b=GcNCkckhgdS9wK7Kd1MKD3ewB5
        +ODe8JAfx3xzr7LeWZjUgdI7AKfuUbv953QGd46y2N2HiWTBQ8ORCiBbz6/4EZicZB2AI/TonRQ54
        LcoLAUBGqNc9eeLD6xONUO+N5aQxAUNFgNMGbz8/cw8cDx7XTPi5LuuYFWXefwcFbrVY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzixE-0006Mn-6H; Fri, 01 Mar 2019 15:16:00 +0100
Date:   Fri, 1 Mar 2019 15:16:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, linux@armlinux.org.uk, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 1/3] net: phy: marvell10g: implement
 suspend/resume callbacks
Message-ID: <20190301141600.GE19813@lunn.ch>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-2-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301110047.20257-2-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 12:00:45PM +0100, Antoine Tenart wrote:
> This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> are powered down) when the PHY isn't used.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
