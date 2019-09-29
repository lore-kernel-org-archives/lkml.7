Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB92C352A9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DEE2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569779428;
	bh=+XWUYtBP1qT7QheXIg8At80qTqeBy2oEuBlU8jR6p38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aFi00hKgnAhmO82/nMmRHhAwJUQV5BoU5EWQDNyfxlHdLBR9BRt3EzPQYvZw4oHbW
	 jIhtGXWMMQWsu9emU2CZ+zfrTQ8f7rBpxTgFeRlbpt6e2espTb7BaesyVfZRSmM5G+
	 OKGFTwqi4ICKZoCGzvguLPSHJV4UVu8Rax01k5Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfI2Ru1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbfI2RuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:50:24 -0400
Subject: Re: [PULL REQUEST] i2c for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569779424;
        bh=+XWUYtBP1qT7QheXIg8At80qTqeBy2oEuBlU8jR6p38=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QQKx22MCiqyJyHH7AB8+0bHj4LAASeHEWCtiaBq1VMfYyWflreuVPRtdWqJ6ud1cx
         LrobzcI+HwdKN4p8rEgVW5ayqxcfDeix0fdIscIj6aileJoSV8IJzJfx0nt6N1fjpb
         v73X0eISvxhd65L57xDwByb4I6gSHvB6Ajh4IB7g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190929103950.GA9497@kunai>
References: <20190929103950.GA9497@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190929103950.GA9497@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
X-PR-Tracked-Commit-Id: 11af27f494086188620e7768e421894af93c126a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ecb3e10a9f2d3443c3bcd0dba42e7e3e2e67618
Message-Id: <156977942406.28081.7782548145153903012.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Sep 2019 17:50:24 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Sep 2019 12:39:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ecb3e10a9f2d3443c3bcd0dba42e7e3e2e67618

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
