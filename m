Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5761BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2940123A7A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dhKb75OC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEaMF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:05:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44412 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaMF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dF5nDtOk5abJZYFCMF9oMzGBnnpEB+On3dIj6UU9HrI=; b=dhKb75OC9urPoYj9NjRoQRCs01
        fTFpJ2yOKnBZhFp6C6DzmaZUfvfEHp/ThHVZd2uxGQFTVq2erArnAqSikhmgtEdxtjc21eKHYQ5JM
        UhjiWDkNAKaaOXQQI6iXbir+1t//Gs1390CesDZBobO6pyexY0xBLVq3erq4yVgmfslo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hWgHZ-000528-Es; Fri, 31 May 2019 14:05:13 +0200
Date:   Fri, 31 May 2019 14:05:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ruslan Babayev <ruslan@babayev.com>, linux@armlinux.org.uk,
        f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [net-next,v4 0/2] Enable SFP on ACPI based systems
Message-ID: <20190531120513.GB18608@lunn.ch>
References: <20190528230233.26772-1-ruslan@babayev.com>
 <20190529094818.GF2781@lahna.fi.intel.com>
 <20190529155132.GZ18059@lunn.ch>
 <20190531062740.GQ2781@lahna.fi.intel.com>
 <20190531064842.GA1058@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531064842.GA1058@kunai>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 08:48:42AM +0200, Wolfram Sang wrote:
> 
> > > Are you happy for the i2c patch to be merged via net-next?
> > 
> > Yes, that's fine my me.
> > 
> > Wolfram do you have any objections?
> 
> That's fine with me, I'd like an immutable branch, though. There are
> likely other changes to i2c.h coming and that would avoid merge
> conflicts.

Hi Wolfram

Davids Millers net-next is immutable, but large.

Maybe he can create a smaller immutable branch for you.

      Andrew


