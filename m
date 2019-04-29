Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBED215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h5hYMGMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfD2WGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:06:32 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49175 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfD2WGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CDkCYbBrMqsa0J2dGF7qat95dbAVM0+F+tk4bLYplek=; b=h5hYMGMCjtscuGrEym+sefVT0T
        oVIvFVAdxF1s1igVBA+j9FCpaxdJTEufYRyHMF2uuO8dRPWmcDK7J2dG3taU9DR1YVTIkEDJEXAMW
        Hy7SVCDqm10poJH6BmQALi7nL4yC9fmqxbsYPZyu85n31QsSjmLyiTmGM0YQ2lqmNV+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hLEPW-0007Io-Qb; Tue, 30 Apr 2019 00:06:06 +0200
Date:   Tue, 30 Apr 2019 00:06:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] net: ll_temac: Fix support for 64-bit platforms
Message-ID: <20190429220606.GL12333@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
 <20190429083422.4356-1-esben@geanix.com>
 <20190429083422.4356-4-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429083422.4356-4-esben@geanix.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:34:13AM +0200, Esben Haabendal wrote:
> The use of buffer descriptor APP4 field (32-bit) for storing skb pointer
> obviously does not work on 64-bit platforms.
> As APP3 is also unused, we can use that to store the other half of 64-bit
> pointer values.
> 
> Contrary to what is hinted at in commit message of commit 15bfe05c8d63
> ("net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit")
> there are no other pointers stored in cdmac_bd.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
