Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C13C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4B02082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OJaBJ2dA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfFRVdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:33:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38500 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbfFRVdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HFlUGfwI29OnXEJ+MFr4KVMqjeFlOdA1xe8uQe9XuvY=; b=OJaBJ2dA3JnZLzHBuTprMuMBgq
        FagHrrCnx3j473aG+UCapG0Vgf1R6cNscK3HcKYXW9+sZFh25xTez8tsV5BSaL8Oi0kXOurWUa95N
        29XVHWxr1xD2I+7qjodqhuPRbSlXXRXnXCkBG4+OUwwdV6hnrBpSKRhJcX1Q6UHfgr+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hdLiu-00043l-0w; Tue, 18 Jun 2019 23:33:00 +0200
Date:   Tue, 18 Jun 2019 23:32:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        f.fainelli@gmail.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        aniljoy@cadence.com, piotrs@cadence.com,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/6] net: macb: add phylink support
Message-ID: <20190618213259.GB18352@lunn.ch>
References: <1560642367-26425-1-git-send-email-pthombar@cadence.com>
 <1560883265-6057-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560883265-6057-1-git-send-email-pthombar@cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:41:05PM +0100, Parshuram Thombare wrote:
> This patch replace phylib API's by phylink API's.

Hi Parshuram

When you repost as a proper threaded patchset, please Cc: Russell
King, the phylink maintainer.

      Thanks
	Andrew
