Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A5C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9B12182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563382227;
	bh=50zDFOZude2L+6XHIxUsl7zIj4hjRnFRXri7R1X89/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LzG45Mm29BEmH0cKzRslhcemfuuoqGTXAtYbq0Gm6s4K85SKGR0FJYyWxJxiVJvgm
	 DCr7Kv4DfRI1nchlX+D9zuOW6hgYprnjwr4tAdj94ZMS7eP6n2CBoRFq7AzsLK9oQY
	 YXVjhYHkh8k+0jfdAdqJmJqgdnHSHYO0rCvdOfB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfGQQu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfGQQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:50:18 -0400
Subject: Re: [GIT PULL] arch/h8300 update
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563382218;
        bh=50zDFOZude2L+6XHIxUsl7zIj4hjRnFRXri7R1X89/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ILgu+eeNQoq2wypwxJZuvXj/Ip1gmA3+YTYXiwLfiBVS863/aHOmSYQi+HNGr/O/f
         PiRJkrw7px3mZ15TK/z3ePl09tNvR4F3Qs+QaQsf6wM27WCHqQo8qAQtEEFx+/GsKw
         3B6KXFHyGopIQ6XYGSI6D9e/y64YL7yZCCTix1L8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y30xozv8.wl-ysato@users.sourceforge.jp>
References: <87y30xozv8.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y30xozv8.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-Remote: git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git
 tags/h8300-for-linus-20190617
X-PR-Tracked-Commit-Id: 38ef0515e1e89794ad1797ce5fadbface4bec216
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d4901c08ae573e569dd01a29bef2ad404a40f97
Message-Id: <156338221801.6265.10102605162804905710.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 16:50:18 +0000
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 16:59:39 +0900:

> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/h8300-for-linus-20190617

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d4901c08ae573e569dd01a29bef2ad404a40f97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
