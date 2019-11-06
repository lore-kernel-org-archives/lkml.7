Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBDC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C36B2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WMVrZM7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfKFQBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:01:15 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51974 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfKFQBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=14E8rBtiDQjr+xd3m9tbE7W5QJZUOJcr7W7KfFXoGhY=; b=WMVrZM7IeRbhGXkEEb0p7Tl/Vz
        FZyaovE79hsMMbOVWMoYVZHTZ85x17w5qVJxbVk9HfNkjo04tiHjXjGMhHZ4ZcgzglzAEJgQzwI8D
        wThQSZA3OyLm5GTQcrB4r/IXLytyaBqq+xApEnKzae2C2KbFv1QvtjuJ4+ay3JiBtHgg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iSNk7-0000Hq-MT; Wed, 06 Nov 2019 17:01:11 +0100
Date:   Wed, 6 Nov 2019 17:01:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
 STP to CPU
Message-ID: <20191106160111.GC30762@lunn.ch>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
 <20191105142202.GC7189@lunn.ch>
 <VI1PR0402MB28007254BB7614477CED4DBCE07E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20191105155954.GE17620@lunn.ch>
 <DB6PR0402MB27899B298481E7A3460BB9BFE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
 <20191106145038.GB30762@lunn.ch>
 <DB6PR0402MB27896E3229CC3397F26122EAE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27896E3229CC3397F26122EAE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If I do this, I would have an L2 switch that relies on IP traffic
> passing through it.

Yes.

> Also, if I use ACLs to model dynamic FDB entries than I will need to "software age
> the ACLs... which is at least not ideal.

The bridge will do that for you.

> Andrew, thanks for all the advice given but I feel like I have to see if the firmware
> can be changed to better model the CPU traffic before adding a lot of hacks and
> pushing something with the current implementation.

Yes. I agree. If the firmware can change, great. If not, you might
have to do these hacks.

     Andrew
