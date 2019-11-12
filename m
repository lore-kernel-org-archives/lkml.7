Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC6FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2549214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XPrY76jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKLN1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:27:32 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35734 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfKLN1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=euNUpgPVSFECHKrlPOqySzeXVv/LTuML8q4Esa2KSao=; b=XPrY76jGMc1pxZG3n/FWKdj1bp
        RrmBbhUjtJid7xU9Wtv9uQvDYDjb7fXB8BjrxI3XhhjZXsUIhqNQVHD4dG5/r7MvXH5PQbG2tz+47
        Yc8Gn5CC42pqFtluXt8wYnTFV9dwbOxENy/ub0yBeVlLE2GOQgqJuA+1E90qxSMWxKWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iUWCe-0001XN-3P; Tue, 12 Nov 2019 14:27:28 +0100
Date:   Tue, 12 Nov 2019 14:27:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Iwan R Timmer <irtimmer@gmail.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: mv88e6xxx: fix broken if statement
 because of a stray semicolon
Message-ID: <20191112132728.GC5090@lunn.ch>
References: <20191112130523.232461-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112130523.232461-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 01:05:23PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a stray semicolon in an if statement that will cause a dev_err
> message to be printed unconditionally. Fix this by removing the stray
> semicolon.
> 
> Addresses-Coverity: ("Stay semicolon")
> Fixes: f0942e00a1ab ("net: dsa: mv88e6xxx: Add support for port mirroring")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
