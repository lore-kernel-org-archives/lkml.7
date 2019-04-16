Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDE7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F0F20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ohL171Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfDPQjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:39:25 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34493 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbfDPQjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=re+DJvTcJZ1v0YRi9X6jWYWJ+mFNWP8LTIrBgnnN28Y=; b=ohL171Vx5dA9B81E+wwfeGyPz6
        sy/Gb57TdsOA3NDqymH1KvzjS7+g2R+4whe9oL8gBf312sK9GsbRtflxT5dC17meed3f63+ubnR9/
        r9ljsKSOjz3E0PB0kj/6xx3teQgOotVVlVFGqXqlsudJmCIQDW0FoZ/ElpK1T4ntNkbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hGR78-0001bS-S2; Tue, 16 Apr 2019 18:39:18 +0200
Date:   Tue, 16 Apr 2019 18:39:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH net-next] net: phy: micrel: add Asym Pause workaround
Message-ID: <20190416163918.GD2890@lunn.ch>
References: <20190416101020.22149-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416101020.22149-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:10:20PM +0200, Antoine Tenart wrote:
> The Micrel KSZ9031 PHY may fail to establish a link when the Asymmetric
> Pause capability is set. This issue is described in a Silicon Errata
> (DS80000691D or DS80000692D), which advises to always disable the
> capability. This patch implements the workaround by defining a KSZ9031
> specific get_feature callback to force the Asymmetric Pause capability
> bit to be cleared.
> 
> This fixes issues where the link would not come up at boot time, or when
> the Asym Pause bit was set later on.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
