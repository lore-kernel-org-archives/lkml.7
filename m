Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC84FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22272084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HcVW0oTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfCAOPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:15:36 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43244 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfCAOPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+FyzDSklz8elQiXqYNHnht1i6svEcQbGXDAyH1LqOUE=; b=HcVW0oTBK0Nv8TdRDWZ8t5wAOH
        RD9d2y8lrt5/eCWYpC2OHI3/yVAgWIeY99P2MwnT+p6unCMmeYIAazS0KPc3nhpaVjHY1nHTwtq3v
        PGIEjGjNr6XEvrpb5QB5/HzCMgKAP7cc+QMxx7Av30DKsX+oUgNx9Sz3cjR86fg5/9xg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gziwj-0006LW-GD; Fri, 01 Mar 2019 15:15:29 +0100
Date:   Fri, 1 Mar 2019 15:15:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, linux@armlinux.org.uk, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 2/3] net: phy: marvell10g: add the
 suspend/resume callbacks for the 88x2210
Message-ID: <20190301141529.GD19813@lunn.ch>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-3-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301110047.20257-3-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 12:00:46PM +0100, Antoine Tenart wrote:
> When the 88x2110 PHY support was added, the suspend and resume callbacks
> were forgotten. This patch adds them to the 88x2110 PHY callback
> definition.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
