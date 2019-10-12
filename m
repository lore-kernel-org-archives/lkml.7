Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4141C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844AA2190F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570916408;
	bh=Bqk5XYFvPmYMqGXGvb3ZS0BE6cigGHuc5IgL4TPeKfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dBLg+/R6BBWx4XXCaX2I8VtT9+xre+M2rrs3auWZl2uHQGoan7+JxQbxdoPOXAVrr
	 AVe/k2jUnBrBwh1AKx7veJtD7aTelT7geTklB9h2d/IwyaYIPYg6SifqDNH4jnpeZU
	 gIUKJxglGKYyCRdPcFZUKFzNos1DQlJicKUd6cdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfJLVkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 17:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfJLVkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:40:05 -0400
Subject: Re: [GIT PULL] s390 updates for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570916405;
        bh=Bqk5XYFvPmYMqGXGvb3ZS0BE6cigGHuc5IgL4TPeKfo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BKUsa9cKt5i22m5t6eqLQFLRzJNuYpqd0oMx6v4Z94quuGMTc3j25ePmhAaU4NMT/
         BY/q8u0YgFRv4aGyQ03dp2lvxU4vo980gw2psn/JwLKwbiK3rNvxPTL455LAjeaWmW
         4qy7lww7f7hZ1aZh12UVy7rmbYg9sSgAXfpjbuVc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01570875939-ext-1686@work.hours>
References: <your-ad-here.call-01570875939-ext-1686@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01570875939-ext-1686@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-4
X-PR-Tracked-Commit-Id: 062795fcdcb2d22822fb42644b1d76a8ad8439b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f154988a905e5cad9d1a20d4c4aeb176968fe3be
Message-Id: <157091640502.3377.2210428493105655595.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 21:40:05 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 12:25:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f154988a905e5cad9d1a20d4c4aeb176968fe3be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
