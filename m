Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F366C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD1E2081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nyPTJsIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbfINOSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 10:18:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45904 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389316AbfINOSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 10:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1Z1jO0nsHRh4rObU5dMZe/5cCeCRCh92lPqbmxPuZnc=; b=nyPTJsIqcIONf/ruvBFUNjyy+y
        jxrYxl/AyHlYC0E9bpP6RypaIpEZpRZduJLth2Nq5osk3lIRSh2LIyy/5zUJMwIWyfhBHSfzJdPCk
        UlUR+434o+OJnOcK+j8IwjgspMHyho0EkdRUYghxgmzaa6lDxSOHXhKKEv4e5j1lN3V8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i98s4-0007Qf-RV; Sat, 14 Sep 2019 16:17:52 +0200
Date:   Sat, 14 Sep 2019 16:17:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <taoren@fb.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next v8 2/3] net: phy: add support for clause 37
 auto-negotiation
Message-ID: <20190914141752.GC27922@lunn.ch>
References: <20190909204906.2191290-1-taoren@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909204906.2191290-1-taoren@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 01:49:06PM -0700, Tao Ren wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> 
> This patch adds support for clause 37 1000Base-X auto-negotiation.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Tao Ren <taoren@fb.com>
> Tested-by: René van Dorst <opensource@vdorst.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
