Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC6C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8580206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oEohW79p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfD0PVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:21:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46594 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbfD0PVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vASWoFYpeZXsfADUB9OGrtEdMcB7irROegImPbRXlKA=; b=oEohW79p3dAumS6lpU01nbQ0VW
        wBekT3Va0NNANFWwUOt1L/C9s1CJM2AUPf1TvuPSnOanW0rw+Pgqb/3yNQgA39zVTdXnwX0YFkjU9
        CxQzK02mUbAEjHYWPyGWybqJO8Y6KZ9tdY7kZWglVzkb07S3H1f2dw4N2fe4tMSMMNI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hKP8X-00029R-RA; Sat, 27 Apr 2019 17:21:09 +0200
Date:   Sat, 27 Apr 2019 17:21:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays
 config
Message-ID: <20190427152109.GJ14432@lunn.ch>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426214050.GU4041@lunn.ch>
 <20190426234503.y6nm5hekyclmgftc@mobilestation>
 <fbf2ff24-a435-fe69-abcc-1f9326e1d61d@gmail.com>
 <20190427074400.is2hbij2k57f5daz@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427074400.is2hbij2k57f5daz@mobilestation>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> Hi Serge
> > >>
> > >> Next time please include a patch 0 containing a cover note explaining
> > >> the who series.
> > >>
> > > 
> > > Sure as long as the patchset gets to be much bigger than two small
> > > patches with an obvious reason to be merged.
> > 
> > netdev likes to have a cover letter for patch count >= 1, probably
> > something to be added to netdev-FAQ.rst.
> > -- 
> > Florian
> 
> Hello Florian
> Really, even with count = 1? So just one patch with cover-letter? Doesn't it
> seem redundant since at least a single patch can be thoroughly described in
> it' commit message?

Hi Serge

David workflow is to put the patch set into a branch, and then merge
the branch into his master, using the cover note as the merge commit
message.

You occasionally see commit messages for count == 1, but not often.
For > 1, if there is no cover note, somebody is likely to ask for one
:-)

    Andrew
