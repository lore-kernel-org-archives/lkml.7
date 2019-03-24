Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B3CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF0821741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfCXAyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 20:54:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34862 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfCXAyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 20:54:47 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA84614B475A6;
        Sat, 23 Mar 2019 17:54:46 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:54:46 -0400 (EDT)
Message-Id: <20190323.205446.1529829825876709396.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, sfr@canb.auug.org.au, andrew@lunn.ch,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Correct Cygnus/Omega PHY driver
 prompt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190321232331.22584-1-f.fainelli@gmail.com>
References: <20190321232331.22584-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Mar 2019 17:54:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 21 Mar 2019 16:23:30 -0700

> The tristate prompt should have been replaced rather than defined a few
> lines below, rebase mistake.
> 
> Fixes: 17cc9821766c ("net: phy: Move Omega PHY entry to Cygnus PHY driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
