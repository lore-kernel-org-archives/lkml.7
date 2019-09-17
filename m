Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA5AC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5B1206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568689519;
	bh=C+PXss2mWQ5yCfvOvzWhp1F0oOnE/usf/XMVXXKsyeE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=stdzTxSb3De/zfI7Ah+Bl6HKUuZAQ1cl9POOSYyukM6x3Z5KcSh2uF+UCsjYYoJzv
	 ImCXGrXqiRP02mwHexqdmeilv6lo5598YkdqHf69qveifVc7RMJxCtlT7jdnDJkZ8O
	 cUmf1/7E5YMWweVsX9syzZYoS1xQIKWvgc1lBC9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392141AbfIQDFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 23:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbfIQDFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 23:05:17 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.4-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568689517;
        bh=C+PXss2mWQ5yCfvOvzWhp1F0oOnE/usf/XMVXXKsyeE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sP1oFDKwQ42b4kzEUxyofFpzngkY937Y8niRCFvuXpTp0Xnbt3YNcYIoxbQfuLYdk
         BMttxVXDipb7oyesJJI1CGyMiLf3Iu1mb6jl1b9A99orb8iNFGA/7+sd0dAlbobRGO
         B7p1lRM0//0Mk4f7JSuGUCE8s4lclNxIZA80ut+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913170655.GA29705@smile.fi.intel.com>
References: <20190913170655.GA29705@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913170655.GA29705@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.4-1
X-PR-Tracked-Commit-Id: f690790c9da3122dd7ee1b0d64d97973a7c34135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad062195731bea1624ce7160e79e0fcdaa25c1b5
Message-Id: <156868951731.17669.10691370751965971396.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 03:05:17 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 20:06:55 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad062195731bea1624ce7160e79e0fcdaa25c1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
