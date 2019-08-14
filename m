Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A975C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE30208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KoDxmKPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfHNOEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:04:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60382 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfHNOET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lW02VcD5dJoh66qRLHZLDXcw00AyjyqyRblslSpxS8I=; b=KoDxmKPW26H1h4PxKJAx6fqZq2
        ZSiHt0h8oFqX5IXXzbK++RhKvLBols4u/wvgh1dqCLsuSY8EvSU854P1loDhZF62hZIBblJGotmVL
        oP9GbodNyQuYqcbsAfFfehtKaP/gewKWrMNWNv8AaD5FMXkXesgqg2gm+DdW3Q4KrALs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hxtsq-0001lU-HG; Wed, 14 Aug 2019 16:04:12 +0200
Date:   Wed, 14 Aug 2019 16:04:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 13/14] net: phy: adin: add ethtool get_stats support
Message-ID: <20190814140412.GD5265@lunn.ch>
References: <20190812112350.15242-1-alexandru.ardelean@analog.com>
 <20190812112350.15242-14-alexandru.ardelean@analog.com>
 <20190812143315.GS14290@lunn.ch>
 <c3fdb21c40900dae0e52b02b98fe27924a76c256.camel@analog.com>
 <2175a95d818172153e839f6bcf6d3d61a3e23dd8.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2175a95d818172153e839f6bcf6d3d61a3e23dd8.camel@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I have to apologize again here.
> I guess I was an idiot/n00b about this.

Not a problem. If it is not something you have come across before, you
can easily miss the significance.

So you just need to modify the ordering and you are good to go.
Please add a comment in the code about this latching. We don't want
somebody changing the ordering and breaking it.

	 Thanks
		Andrew
