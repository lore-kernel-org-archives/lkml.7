Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603A1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8BD206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yNJoXUHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfHAD4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:56:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52884 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfHADz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Y1QlX2yE7yvhO9Y6IQdrLu7V2tiqtVgXwBkJSh4jYHg=; b=yNJoXUHia1doAfiLkZ7DnjfnK2
        DlsR52pVLSHbKp0s/pjmV6L1gaWDbQ6nlSfwl47jeGtYrwsMa5QfRALq7DLdZpyzf4zab2Fw/KOPb
        Lo0lyATAVgDSUowhIZ9zC7yAt0IT7zszT23ki4epttXDyxDLlDZQaJAl9ouyLcDfL5BE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1ht2Bx-0001OG-16; Thu, 01 Aug 2019 05:55:49 +0200
Date:   Thu, 1 Aug 2019 05:55:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, f.fainelli@gmail.com,
        hkallweit1@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: ftgmac100: Add support for DT
 phy-handle property
Message-ID: <20190801035549.GH2713@lunn.ch>
References: <20190731053959.16293-1-andrew@aj.id.au>
 <20190731053959.16293-4-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731053959.16293-4-andrew@aj.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:09:58PM +0930, Andrew Jeffery wrote:
> phy-handle is necessary for the AST2600 which separates the MDIO
> controllers from the MAC.
> 
> I've tried to minimise the intrusion of supporting the AST2600 to the
> FTGMAC100 by leaving in place the existing MDIO support for the embedded
> MDIO interface. The AST2400 and AST2500 continue to be supported this
> way, as it avoids breaking/reworking existing devicetrees.
> 
> The AST2600 support by contrast requires the presence of the phy-handle
> property in the MAC devicetree node to specify the appropriate PHY to
> associate with the MAC. In the event that someone wants to specify the
> MDIO bus topology under the MAC node on an AST2400 or AST2500, the
> current auto-probe approach is done conditional on the absence of an
> "mdio" child node of the MAC.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
