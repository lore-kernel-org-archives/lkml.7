Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C2C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1475E21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564425620;
	bh=z0xQRTneRbrbK/v1o65X+2eAvEsGuLaB9wJEDVLC438=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f9co7wz2h6Y1NsaIDnwUKEcnj9V1sOAPJGU28HpcrDNZS6rV3hgyxoUCAsbDj1mvu
	 M6Jj8e72Wbk8/SxjO8AI79SJROg6FNz/qr/+OKaZJOGe78MyIGCteyp0glvcASVJY2
	 RXgYagu8wKZRTMpxgq1OIehrg6X0d8ppwLG18M48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfG2SkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfG2SkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:40:18 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.3-3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564425617;
        bh=z0xQRTneRbrbK/v1o65X+2eAvEsGuLaB9wJEDVLC438=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ewUBWeMGlKSNtPFIulHajctawzhorCzR1PxZEFQlr/8Hap8y5VVxtkKX0Oyc8EidK
         WG+wuId7mPxmcrzgHSxGqlI8PYhy1U7utDx2MQwEeEZA8RlR1HmM7VXiReQiVnS/0E
         WHOxuVmYRnmlCHETqfh9mo9CUP7dfy+Geykfp5i0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190729153815.GA853@smile.fi.intel.com>
References: <20190729153815.GA853@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190729153815.GA853@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.3-3
X-PR-Tracked-Commit-Id: f14312a93b34b9350dc33ff0b4215c24f4c82617
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45aee68e19a52d434624bdd322a0c1d6c0b9be4f
Message-Id: <156442561745.16864.5486640479330507715.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Jul 2019 18:40:17 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Jul 2019 18:38:15 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45aee68e19a52d434624bdd322a0c1d6c0b9be4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
