Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368F8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1021720989
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553971816;
	bh=qNXXFZ2XL+8lqwi1e/uJYh49nJkUeUCPfp1XGsTQgr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ad/lzxyeE4Mk93llBEyj47W+M3/zHwfbX9x4SmYwzunIqVxnMpCHXobYFYrRNGItr
	 uitLmAI/Gg6gDgzcPIiOjQC4I2+X5JJZZJG+IZuCiyuNUXF49Zb0rs+nsFROMpTD8V
	 1A07r+meF+yPwS9CJ4onH4zX6iF+Yn/D1j/lqAKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfC3SuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbfC3SuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:50:11 -0400
Subject: Re: [GIT PULL] Staging driver fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553971811;
        bh=qNXXFZ2XL+8lqwi1e/uJYh49nJkUeUCPfp1XGsTQgr4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x5NM+L2vUZOAzQ+YhpMspkFv9nQkYDUL7PRditg7ORUWMwhd6KDiZd4AnAzxt4je3
         S7RNa96xmNlke47wsV75H/9OYnBWzNqayQyIIvkSwJNsLnvi0Z/BuBwSno0iVW4wbR
         pGnTYEmReIzmKg7IChNONjsN/VJMHA8Lv8jdJYfY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190330090421.GA5644@kroah.com>
References: <20190330090421.GA5644@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190330090421.GA5644@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.1-rc3
X-PR-Tracked-Commit-Id: cc26358f89c3e493b54766b1ca56cfc6b14db78a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32faca66bd3f6aa7ec4212d20c7b2d45657fab10
Message-Id: <155397181112.25047.17187209538900116349.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 18:50:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 10:04:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32faca66bd3f6aa7ec4212d20c7b2d45657fab10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
