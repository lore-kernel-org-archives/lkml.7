Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D00ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9038821D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Emw5kctj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438047AbfJQV7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:59:19 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51600 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733238AbfJQV7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=114cGOXdIYdNiPZFR4ELOkx6rjRTcSQU7fbuI7oiAt8=; b=Emw5kctjJuU/UajdJsL7jcuz08
        gRofogWUyIKrLG7gS4mgYbEpqsH26PTpL3E6XG69g2W5f13/2zEdVofGWHfhr2IAQGpZb6YCA5bjz
        T3wm5xSMbaF9FSmbY015OFsNl8j1xv07LrTkPrHC5yM9COeywkZaxLCY0I//I/MlfRqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iLDne-0006mf-K3; Thu, 17 Oct 2019 23:59:14 +0200
Date:   Thu, 17 Oct 2019 23:59:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, olteanv@gmail.com,
        rmk+kernel@armlinux.org.uk, cphealy@gmail.com,
        Jose Abreu <joabreu@synopsys.com>
Subject: Re: [PATCH net-next v2 1/2] net: phy: Use genphy_loopback() by
 default
Message-ID: <20191017215914.GA24810@lunn.ch>
References: <20191017214453.18934-1-f.fainelli@gmail.com>
 <20191017214453.18934-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017214453.18934-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:44:52PM -0700, Florian Fainelli wrote:
> The standard way of putting a PHY device into loopback is most often
> suitable for testing. This is going to be necessary in a subsequent
> patch that adds RGII debugging capability using the loopback feature.
> 
> Clause 45 PHYs are not supported through a generic method yet.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
