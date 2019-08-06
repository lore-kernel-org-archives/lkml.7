Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D898FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C88206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nTAloYe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfHFVMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:12:03 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38648 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfHFVMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Fc00WBtovQWbwYWrsv1JjCYQajV6WgZsSgkyMDMnwmQ=; b=nTAloYe1jHjKOUvI8oG2rVCIuf
        8l0QzmynOpMgso4HVgULgT1ngDM6pxm2PaZwe6/I4rGXxRJtv/BuI6QaEqL0nx8AZF4hjOca8WKp3
        zt9197AHBXJBBbLXaCcBbTTxv9g2WL915ObwC6YRRnDzeHLbT4ufKAOgXc0vW+H/P79c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hv6kO-0008KH-GQ; Tue, 06 Aug 2019 23:11:56 +0200
Date:   Tue, 6 Aug 2019 23:11:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <taoren@fb.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next] net: phy: modify assignment to OR for dev_flags
 in phy_attach_direct
Message-ID: <20190806211156.GD29142@lunn.ch>
References: <20190805185551.3140564-1-taoren@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805185551.3140564-1-taoren@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:55:51AM -0700, Tao Ren wrote:
> Modify the assignment to OR when dealing with phydev->dev_flags in
> phy_attach_direct function, and this is to make sure dev_flags set in
> driver's probe callback won't be lost.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> CC: Heiner Kallweit <hkallweit1@gmail.com>
> CC: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Tao Ren <taoren@fb.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
