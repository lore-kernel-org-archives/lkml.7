Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ADBC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01A220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XWqU7cYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfE1Pcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:32:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35688 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfE1Pcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=++rLbXxo4bi+XXtwzmWsoqtfNeuWm1VHi8j7nqrGnoo=; b=XWqU7cYWfZcvtOy+pxtHLz3Dq9
        Ta7JcZn4VP7sCc2f2Tm+BOuNJiRg24BI6dS+lCdTC0J7qyjHVTyPSi0N7TMr6R0OluZXwJacSdV6O
        8Di2nuoJWih+I31GECdyc6LlfhX7n83WrG9HLRSLzoHDbtYi1sfMsf+iKQPOpLcpYHcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hVe5h-0007vs-UH; Tue, 28 May 2019 17:32:41 +0200
Date:   Tue, 28 May 2019 17:32:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, ioana.ciornei@nxp.com, olteanv@gmail.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] Documentation: net-sysfs: Remove duplicate PHY
 device documentation
Message-ID: <20190528153241.GN18059@lunn.ch>
References: <20190528020643.646-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528020643.646-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 07:06:38PM -0700, Florian Fainelli wrote:
> Both sysfs-bus-mdio and sysfs-class-net-phydev contain the same
> duplication information. There is not currently any MDIO bus specific
> attribute, but there are PHY device (struct phy_device) specific
> attributes. Use the more precise description from sysfs-bus-mdio and
> carry that over to sysfs-class-net-phydev.
> 
> Fixes: 86f22d04dfb5 ("net: sysfs: Document PHY device sysfs attributes")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
