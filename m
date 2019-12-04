Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B6D2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v9Bfxxq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfLDRaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:30:12 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:37038 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLDRaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lAsG+T4/3QI7MFHFX6DTkoBl6UOaIUr3qpKXn/UuyzU=; b=v9Bfxxq7/fD63NH2anKtkms+QE
        zT1nIfBwxeIHbzjfzDHTmQj/mjqQEYJ/mln0h91fRLQ+1WxljHQFNOCM891gV2GacAz/+CjE4n4PS
        RvFqkVPlKlU3g4f93Q4jpgxqLBU6lrLT9v8h7a5+VdBFr9fNZeSckZOK1mbt+K4/oQJs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1icYTY-0003Dk-D6; Wed, 04 Dec 2019 18:30:08 +0100
Date:   Wed, 4 Dec 2019 18:30:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        davem@davemloft.net, rric@kernel.org, sgoutham@cavium.com,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v1] net: thunderx: start phy before starting
 autonegotiation
Message-ID: <20191204173008.GG21904@lunn.ch>
References: <20191204172351.29709-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204172351.29709-1-ykaukab@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:23:51PM +0100, Mian Yousaf Kaukab wrote:
> Since commit 2b3e88ea6528 ("net: phy: improve phy state checking")
> phy_start_aneg() expects phy state to be >= PHY_UP. Call phy_start()
> before calling phy_start_aneg() during probe so that autonegotiation
> is initiated.
> 
> As phy_start() takes care of calling phy_start_aneg(), drop the explicit
> call to phy_start_aneg().
> 
> Network fails without this patch on Octeon TX.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
> v1: 

This should really be v2.

You should add fixes: tag

And the subject line should indicate which tree this is for:

[PATCH v2 net] net: thunderx: start phy before starting autonegotiation

https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html

       Andrew
