Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BECAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE1F21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2XYoq8pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfD2WVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:21:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49232 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfD2WVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4tz67MkZsm7EoDBDjVjxlRhP32MwBSdt6O5PxAqikqY=; b=2XYoq8pKphKeA6+tolwq9fEh/4
        ix6y7oagErUm+uiFmKH2yYHuHsYcOzjqPmFLmb6tMwjl7SnDYmbMPwYw4lFEB1yUZSxetYG+OXMHy
        NhlXH20S4pbPv081p2bLinAKERbe/n7KaRpEUrDcOrWcsBD88kpUTDOATPhA3s5CP/t8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hLEeA-0007pg-2t; Tue, 30 Apr 2019 00:21:14 +0200
Date:   Tue, 30 Apr 2019 00:21:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 08/12] net: dsa: sja1105: Add support for
 configuring address aging time
Message-ID: <20190429222114.GS12333@lunn.ch>
References: <20190429001706.7449-1-olteanv@gmail.com>
 <20190429001706.7449-9-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429001706.7449-9-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 03:17:02AM +0300, Vladimir Oltean wrote:
> If STP is active, this setting is applied on bridged ports each time an
> Ethernet link is established (topology changes).
> 
> Since the setting is global to the switch and a reset is required to
> change it, resets are prevented if the new callback does not change the
> value that the hardware already is programmed for.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
