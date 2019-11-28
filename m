Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E8AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFCC216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574970918;
	bh=0YZdEDTRQcaiem7wsteKe6vcE3rtm3kUJ9ehSINoDl8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DIjbnRseJp6IOTpkC4zsWX1flxIHSvZ76qzV+c3BQ8mA567db1/HmfbCTdlEGSECQ
	 MGC7/q2uK9HB1bWbTvzj3CxUtkP+EKJ0x7o4TgPyka5A3BCZdOoEFYyuORVTs1AEqs
	 1tNQ+RSRlFIKTwx/lurqLubY2+X6CLSNF9MGjz5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfK1TzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1TzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:55:15 -0500
Subject: Re: [GIT PULL] dma-mapping updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574970915;
        bh=0YZdEDTRQcaiem7wsteKe6vcE3rtm3kUJ9ehSINoDl8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kvpjWkXNYyUDkXLS42imM1H9+9EBJcccD3gEVPy0JMXbKphDEcKe5OijzdU/VvIEs
         QjXPd3h8xgaX0QrwkVVBOGYIm7PAJQLicNZa+UANzLUeuGXTmhxXt3Xlv81MfGJ5sT
         YlApeDjar01JhqQsFF+HD2tUhPugQbZehgkWj9rg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128164904.GA20771@infradead.org>
References: <20191128164904.GA20771@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128164904.GA20771@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.5
X-PR-Tracked-Commit-Id: a7ba70f1787f977f970cd116076c6fce4b9e01cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81b6b96475ac7a4ebfceae9f16fb3758327adbfe
Message-Id: <157497091536.22792.17174255235714068782.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Nov 2019 19:55:15 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 17:49:04 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81b6b96475ac7a4ebfceae9f16fb3758327adbfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
