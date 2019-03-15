Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1581C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99921218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552687818;
	bh=G8MT6C0ydWp3AZ4BNG7pSjbG9BWZWCGoA2fXXCY8zqM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1VPEioBpiuIAVc9jG7XdWWyF/Wy20X0OzBqwPa+TylSsnrcu/57uFaaX9eceKrMvR
	 JWZW1ioZuzlptOFPiPXFZuOOTMx8qoPglUpxBD0pvwjNeOZxPC5CA+jkTZc1EhNQMu
	 zBOGlR4ncmydidkagb+nKR7cMckIc5hnBiHaif3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCOWKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfCOWKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:10:16 -0400
Subject: Re: [GIT PULL] UML updates for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552687815;
        bh=G8MT6C0ydWp3AZ4BNG7pSjbG9BWZWCGoA2fXXCY8zqM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pdyYQcepNj5CM20wBVbivfHnVFBKDxdEuqyJ5+SfbEF4PdJqGVkaf+JX6HoTx3bQ9
         QgcNNJXyQBaTDmhYGhX0dqFDqHZ3h47WX5YIelVjrR+1qGhWiuPFK4XMcqPRPI6edx
         19Na8cUfjTvySu1MXdC6UguyPKFy6ATjkWpCnCCY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <31705653.NnsrL61LRB@blindfold>
References: <31705653.NnsrL61LRB@blindfold>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <31705653.NnsrL61LRB@blindfold>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 for-linus-5.1-rc1
X-PR-Tracked-Commit-Id: aea05eb56e47046de1e5b508d40931dca969f1e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c83d0d5eb62846b8591884e246ab67d70b651ef
Message-Id: <155268781589.7789.6803567278190687959.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 22:10:15 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds@linux-foundation.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 16:14:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c83d0d5eb62846b8591884e246ab67d70b651ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
