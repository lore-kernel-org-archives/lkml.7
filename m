Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D1AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB882086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j2EGEvuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393286AbfITPJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:09:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57546 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfITPJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=e3sX+AKf4jIPWECu8JKuRF54xUJQe/sOkxk/uvlTQKc=; b=j2EGEvuSo2CoXp4MZ0ciWPIdii
        TNSWC3Axg+Zv2keHaLgZje8D9ZEOh6IluaXdKabSnxomEDa/hJeaeseFR/y/GTgzOGUg6IZSspyGA
        Guzs+2sCD7wAIk10Q56fMBQYxOMCzUM1CjiG+ZeV9je3wtiu0e74vzYlaBvCynZx4by8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1iBKXE-0005tx-6t; Fri, 20 Sep 2019 17:09:24 +0200
Date:   Fri, 20 Sep 2019 17:09:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] net: dsa: vsc73xx: Adjustments for
 vsc73xx_platform_probe()
Message-ID: <20190920150924.GG3530@lunn.ch>
References: <98fee5f4-1e45-a0c6-2a38-9201b201c6eb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fee5f4-1e45-a0c6-2a38-9201b201c6eb@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:25:53PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 20 Sep 2019 16:17:18 +0200
> 
> Two update suggestions were taken into account
> from static source code analysis.

Hi Markus

netdev is closed at the moment for patch. Please repost once it
reopens, in about 2 weeks time.

	 Thanks
		Andrew
