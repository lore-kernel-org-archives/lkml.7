Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D65C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876392089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u+YNmT48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfG3Nab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:30:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47656 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfG3Nab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tZfqFV1mC7mjoGwJp7O3BavJOel8ZxAd9ytjtyhys4s=; b=u+YNmT48vGmDMbMfOWrSeCDUfD
        enHCxebeZ9BjoW3i24I+yk2UQIfTK0zmG8k+4p3IjwODwuD+Cr/I3puGYpT/koy87J8QqGf2Rxo0y
        XP7Sjce4ycQUzjQ4l/SuLMNH+0svT/neij9rv8TKuj+SNiWoMJ2P3KFOIRaYViNkrLU4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hsSCz-0007gW-0u; Tue, 30 Jul 2019 15:30:29 +0200
Date:   Tue, 30 Jul 2019 15:30:29 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hubert Feurstein <h.feurstein@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: phy: fixed_phy: print gpio error only if gpio node
 is present
Message-ID: <20190730133029.GC28552@lunn.ch>
References: <20190730094623.31640-1-h.feurstein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730094623.31640-1-h.feurstein@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:46:23AM +0200, Hubert Feurstein wrote:
> It is perfectly ok to not have an gpio attached to the fixed-link node. So
> the driver should not throw an error message when the gpio is missing.
> 
> Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>

Fixes: 5468e82f7034 ("net: phy: fixed-phy: Drop GPIO from fixed_phy_add()")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
