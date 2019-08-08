Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60626C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E6B2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RBiyV9vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbfHHPYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:24:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44594 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732708AbfHHPYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u8YLp5s7sOeKAALIv/oP9KgrRkzlnI6awJj6R/tzAqo=; b=RBiyV9vmuLIelxPiP1nPVmGctU
        eK/kDi75IupoAxbFx4XLREFNEUuHvpB6BpPtdgxx6NQH/VoJuJ0YLjkN5I8UTzvGbJj4XO3gDKiOs
        RSDVavwbbf2+o8wK7GBRUgUHuYdt0JMw8hFIypYhy9wg7QhHbZxxCPDTE/QD6ZbF5y7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hvkH6-0003oT-C3; Thu, 08 Aug 2019 17:24:20 +0200
Date:   Thu, 8 Aug 2019 17:24:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH v2 03/15] net: phy: adin: hook genphy_{suspend,resume}
 into the driver
Message-ID: <20190808152420.GC27917@lunn.ch>
References: <20190808123026.17382-1-alexandru.ardelean@analog.com>
 <20190808123026.17382-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808123026.17382-4-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:30:14PM +0300, Alexandru Ardelean wrote:
> The chip supports standard suspend/resume via BMCR reg.
> Hook these functions into the `adin` driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
