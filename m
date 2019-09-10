Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CCDC49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A8F20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4qPPl99f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfIJShU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:37:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38790 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfIJShU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JTkbnv93gLuDmmH5p1691gshTY19q7OsYC9+NWDuBBU=; b=4qPPl99fBJ6gOfJHUQgScDhSiH
        4qbNMXF+pas/nE2AhMn4Uv7pOFjKZYbkWH8ecyWDWvIgLpq1AzyhKjAozojQC39pNZf0twMniNDPL
        /5W++1SkvDKKuiM+Tlg680sxxaW4JGzTD5ltC0Gu04qi0+01y3TELqVEPtR+yD1Lw+44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i7l0s-00030O-EG; Tue, 10 Sep 2019 20:37:14 +0200
Date:   Tue, 10 Sep 2019 20:37:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     George McCollister <george.mccollister@gmail.com>
Cc:     netdev@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: remove
 NET_DSA_TAG_KSZ_COMMON
Message-ID: <20190910183714.GC9761@lunn.ch>
References: <20190910131836.114058-1-george.mccollister@gmail.com>
 <20190910131836.114058-4-george.mccollister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910131836.114058-4-george.mccollister@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 08:18:36AM -0500, George McCollister wrote:
> Remove the superfluous NET_DSA_TAG_KSZ_COMMON and just use the existing
> NET_DSA_TAG_KSZ. Update the description to mention the three switch
> families it supports. No functional change.
> 
> Signed-off-by: George McCollister <george.mccollister@gmail.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
