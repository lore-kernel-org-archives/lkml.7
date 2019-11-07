Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F43FFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4072B2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g1odS0jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfKGBvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:51:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53092 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfKGBvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nmKx7wji3qmcoOogImEap1jlfatkXDxtFWOPRbr3HYc=; b=g1odS0jDMvWWS3xEEFAJlFLNPm
        jtEx6ADqv9buymCOTDNXezrh8M3U+pG39DHhXT3Ekj8vaPoWx2qT28p1yABV9VjFFVw3crUFJ4DHj
        RXU+Fn3YpM2nBgGFdNEYZ4kVRkIafVVbIcQFF9eY5mtdigfKz6vgm5ZwhahI1S96HwaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iSWxU-0002im-K6; Thu, 07 Nov 2019 02:51:36 +0100
Date:   Thu, 7 Nov 2019 02:51:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 2/6] dt-bindings: net: phy: Add support for AT803X
Message-ID: <20191107015136.GC8978@lunn.ch>
References: <20191106223617.1655-1-michael@walle.cc>
 <20191106223617.1655-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106223617.1655-3-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 11:36:13PM +0100, Michael Walle wrote:
> Document the Atheros AR803x PHY bindings.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
