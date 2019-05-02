Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53648C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D4320C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QQ7tllZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEBQzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:55:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52471 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfEBQzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xMqzWPWYIN6jeOd3YVkBiCmwBqYgASR2+g0UEvKZ2P4=; b=QQ7tllZlxmWjEuXWSr4a2ioKAC
        vpAwCvBriqVDIYwJdYna1C6EGvz4pzbJpnFWZ3euQ9D/PMIOPMtu0y9iyoLmkpJHHO2aYo5ohas3b
        Ju/w4dGj0jXgCzVUXMI13hFoeHCoSasBeRLiLWU/0uepkuK1W5wxWqOmOti2+gfmWlaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hMEza-0001Tk-BB; Thu, 02 May 2019 18:55:30 +0200
Date:   Thu, 2 May 2019 18:55:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        vivien.didelot@gmail.com, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 00/12] NXP SJA1105 DSA driver
Message-ID: <20190502165530.GJ19809@lunn.ch>
References: <20190429001706.7449-1-olteanv@gmail.com>
 <20190430.234425.732219702361005278.davem@davemloft.net>
 <CA+h21hrmXaAAepTrY-HfbrmZPVRf3Qg1-fA8EW4prwSkrGYogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hrmXaAAepTrY-HfbrmZPVRf3Qg1-fA8EW4prwSkrGYogQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wow I am sorry, Gmail apparently moved your reply to spam and I only
> got it when I posted my message just now.
> Do you know what causes these whitespace errors, so I can avoid them
> next time? I think I'm generating my patches rather normally, with
> $(git format-patch -12 --subject-prefix="PATCH v4 net-next"
> --cover-letter).

What happens when you run checkpatch on the patches? Does it report
white space problems.

Another possibility is your email system has mangled the patches.
First try applying the patches you generated from format-patch to a
clean tree. If you don't get any warnings, email the patches to
yourself, and then apply them.

     Andrew
