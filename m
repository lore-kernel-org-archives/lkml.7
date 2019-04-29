Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63818215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LsXKsCKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfD2WHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:07:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49185 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfD2WHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ze3nddxPSZh0i3nBebZ753zCi/GZQ2MRnRMA+b5QuiY=; b=LsXKsCKCeM3RgGyVpgMD7RBIKb
        qNldf8H8I8ub/GYapf2QG4wNs+R4P74JBSGcSM4g8jX9O2Vcw39EI2PRciAmgKWRY3F1tA0xyAl/G
        nnjN4/FwalQc49F5aw+KF796N6ncOSQst9a2sUWGI3yy6qJ5jDc2KwCv26p37QeVJ5qE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hLEQH-0007Lf-BB; Tue, 30 Apr 2019 00:06:53 +0200
Date:   Tue, 30 Apr 2019 00:06:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] net: ll_temac: Allow use on x86 platforms
Message-ID: <20190429220653.GM12333@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
 <20190429083422.4356-1-esben@geanix.com>
 <20190429083422.4356-7-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429083422.4356-7-esben@geanix.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:34:16AM +0200, Esben Haabendal wrote:
> With little-endian and 64-bit support in place, the ll_temac driver can
> now be used on x86 and x86_64 platforms.
> 
> And while at it, enable COMPILE_TEST also.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
