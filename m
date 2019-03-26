Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3642070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553622314;
	bh=SIN7sDrlPml4R7Md2ymgQymnMp68+GJD88pgrpms0ig=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c8TjjMyh69xYcsU5kBnP1Ek5xdXaEIq/s8LutVI0GjFUY5wWYd39d/UdaA1F4eFSW
	 QXnKBwnUF5CRLYNtEk4EqHsl+zxb9lTZSB4k/9twftJV6a6WyF05X4OfXQ6ggoMtab
	 TPC0xLVP55NNWifwLff/hzgTd6Nk2kKw3rJrdApc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfCZRpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731904AbfCZRpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:45:12 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553622312;
        bh=SIN7sDrlPml4R7Md2ymgQymnMp68+GJD88pgrpms0ig=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HjohQEmsya18neWWA/LEHDNh6MhcHVupbCkCyX+7bqEX0Hz16LwzMj3zHAZEUVXU+
         wN2Upu1fzv8uY/dd5HMob3QjhwFQUb8fug0B38HcVa0RVn9D6vpOJfWnQXSZJ+dXPs
         86fXmTF5CpuLzry1CmJSl954OAAfwBV0qaXYL/GM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1553608661.git.dsterba@suse.com>
References: <cover.1553608661.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1553608661.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.1-rc2-tag
X-PR-Tracked-Commit-Id: 0ccc3876e4b2a1559a4dbe3126dda4459d38a83b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65ae689329c5d6a149b9201df9321368fbdb6a5c
Message-Id: <155362231238.6747.1714626172994251592.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Mar 2019 17:45:12 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Mar 2019 15:15:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.1-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65ae689329c5d6a149b9201df9321368fbdb6a5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
