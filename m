Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0131C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588520727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="baXi3B1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfKZOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:37:23 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56642 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKZOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oKkdwn0/YwK2hGC0uEm2QqP4fqSSsp4M7q3bSY4IohY=; b=baXi3B1tEmHUqbmdc44YZwyxBS
        96d8goz5ZmE4om9rTbjDA67dmR7wColKCZ2ivfq82HsmkxBctOTtwu025ubJrK147ZAPvhQ3Rr8we
        GCwerM3cYuo6a/R4lp8USxevFKF52PfWoKNkPsc9oDHbdLPhMpyO6kciCdrhJvJImJe4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iZbxt-0003XR-57; Tue, 26 Nov 2019 15:37:17 +0100
Date:   Tue, 26 Nov 2019 15:37:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Milind Parab <mparab@cadence.com>
Cc:     antoine.tenart@bootlin.com, nicolas.ferre@microchip.com,
        davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
        dkangude@cadence.com, pthombar@cadence.com
Subject: Re: [PATCH 2/3] net: macb: add support for C45 MDIO read/write
Message-ID: <20191126143717.GP6602@lunn.ch>
References: <1574759354-102696-1-git-send-email-mparab@cadence.com>
 <1574759389-103118-1-git-send-email-mparab@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574759389-103118-1-git-send-email-mparab@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:09:49AM +0000, Milind Parab wrote:
> This patch modify MDIO read/write functions to support
> communication with C45 PHY.

I think i've asked this before, at least once, but you have not added
it to the commit messages. Do all generations of the macb support C45?


FYI: Net next is closed at the moment, so your patches will be
rejected. Please post again when it re-opens.

	  Andrew
