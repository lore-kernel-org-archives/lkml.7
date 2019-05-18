Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB57C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550BB2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UNnEXHWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfEROXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 10:23:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38963 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfEROXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 10:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7v4bLqHEeHp7LbwQqxufyBDKdh2cw6VQugJ3egXSjvE=; b=UNnEXHWYTcL43w1LJAOHD3Hpep
        uVvfb4xheRmPpAw+zjA1On+v4uksxL51h/ISQcrKsg52+q2XcxTi3IDfN5MnEY42qUVjC6DPpwPBj
        TUSWqrpI9HX9XHa+0X5CmESddeTN9rTX2N+DGPpjVf88S1FdCRnLpTCOVeu//CmVh5EU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hS0Ez-0006NT-VS; Sat, 18 May 2019 16:23:13 +0200
Date:   Sat, 18 May 2019 16:23:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mvebu: Add git entry
Message-ID: <20190518142313.GM14298@lunn.ch>
References: <20190517213659.26604-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517213659.26604-1-gregory.clement@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 11:36:59PM +0200, Gregory CLEMENT wrote:
> While there was a git repository used for the mvebu subsystem since many
> years, it was not documented. let's add it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
