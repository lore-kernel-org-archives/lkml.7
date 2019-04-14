Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA24C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9910720880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YuEKkmwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDNQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:22:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60820 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfDNQWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1OysKUHOzl85mmmsw6XkGn8VAEScgIAKqxCiYIpxdzk=; b=YuEKkmwgucvDifZZinVjzc+SXh
        36Z88A+fcfOtBXy0DymOoVNKUP/UN5U2OLgKg66JhHKniWpqFO7WLEbVjPPDXfi8AGaT21xkok8Kf
        IA2OvaDJARj2pOh0vqlF/MHVq2rqZl1YXONhZn7upEEy8qRpHoSA5sLx8VtaGgm6j8lQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFhtS-0003F6-8R; Sun, 14 Apr 2019 18:22:10 +0200
Date:   Sun, 14 Apr 2019 18:22:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: mvebu: add SPDX license identifier
Message-ID: <20190414162210.GC10323@lunn.ch>
References: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
 <1555217391-3552-3-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555217391-3552-3-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 06:49:51AM +0200, Nicholas Mc Guire wrote:
> The license is clearly identified as GPL V2 - so just add in the
> appropriate SPDX license identifier.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Hi Nicholas

Adding a SPDX line makes the license text redundant, so you should
remove it in the same patch as adding the SPDX line.

       Andrew
