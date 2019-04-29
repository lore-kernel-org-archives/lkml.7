Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAACC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FAF217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UcaM6N/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfD2UdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:33:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfD2UdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7H2edA31iYs2gw/p0bJe67gS5zRGaMvkW5f5LLki0zw=; b=UcaM6N/eqsa1kjB7Q7mVrj7VQ
        vCO43VOyZMkB5Tfd7pEGWsST1nuVuvGIcTCmpGQbjIZJu9h2ASAIiyj49uQjfO7oVsalaIkHtSshI
        jo5Q8d4KGhPBFD/9IfQ3aPUihrvONGGrI0WgdpXuaa64z7QuMEGOpfBi/E4wfnwA+9KZrZ7sY3Aii
        WHPa8rT+tAhPXl24tKE4Bf/YuPx0ASWJ3hRarrLz0yPOV6vRLMCxwBkGzmOaDwYAnn/aSYKHQNLwD
        5fSXUJ+z5e3DR2Otudwan91rnYRx6ybMrS0wL6mAhLd/BVcdGJhK8jTaJ6ihrYcYOD+3XtjQBzWjY
        9jaUgw9mQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLCxP-0006Vh-32; Mon, 29 Apr 2019 20:32:59 +0000
Date:   Mon, 29 Apr 2019 13:32:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fdomain: Resurrect driver (PCI support)
Message-ID: <20190429203258.GB19699@infradead.org>
References: <20190428200626.28092-1-linux@zary.sk>
 <20190428200626.28092-3-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428200626.28092-3-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:06:24PM +0200, Ondrej Zary wrote:
> Future Domain TMC-3260/AHA-2920A PCI card support.
> 
> Tested on Adaptec AHA-2920A PCI card.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
