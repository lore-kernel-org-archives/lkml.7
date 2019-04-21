Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D0C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5698F20833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MBlXUZIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfDURsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:48:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39416 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfDURr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=75h+WJZyGrEG3bM8rfnitdXn+qdIuPSf/u42nHPnkNM=; b=MBlXUZIcC4tN9FyBsdOvkdLvq2
        EdIwI0Q4I6SQjfqwrj0+wseISLw1Sc66OdUkEh6CRFRk7h/TLWgeh9PLuOACKdp7sDppl2FcjlaFe
        loPhCVb8wGZYQHetcx/mtdVK8YW9YXYD4Ipkn1fRrGKRFKCnMF3aUjs6nv4XMLBBPWJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hIGKC-0005an-3x; Sun, 21 Apr 2019 19:32:20 +0200
Date:   Sun, 21 Apr 2019 19:32:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: add an explanation for internal phy-mode
Message-ID: <20190421173220.GA19783@lunn.ch>
References: <1555784073-21679-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555784073-21679-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 06:14:33PM +0000, Corentin Labbe wrote:
> When working on the Allwinner internal PHY, the first work was to use
> the "internal" mode, but some answer was made my mail on what are really
> internal mean for PHY.
> 
> This patch write that in the doc.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
