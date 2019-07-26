Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34CEC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE2422BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165505;
	bh=2m5n+Cy939A7WkGIUd/1iGnbvwkXXkVvdD48YpLUZ98=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IVe7tiEtoD6Gwo16S6lWbzFs4KYdCO1nU7eK1U7AVTQRQeygZ/MhLUETiOnLvazgt
	 /H3TICE2FOGXUmRWhrYn0Bi5BFClbNBFm3gYEWBIsXJRNV8K+qqQVDDHTvm0g7fsCk
	 9OHMP6KGxA4lQjaTrCgx3xtD7VayFUY2bSpJ1CKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfGZSZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfGZSZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:04 -0400
Subject: Re: [git pull] struct mount leak fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165503;
        bh=2m5n+Cy939A7WkGIUd/1iGnbvwkXXkVvdD48YpLUZ98=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YUEeWYYQaQ1Xxz15UUYESs3yFNWJZjwkjtjQPXiReCsz51Dx92zWKZu+Xe2LXGIdi
         OHHcMO7NqfhnpzFFjhrq4A6pkdGBQn+wV5HplnC28RCaV2ZWoum0la4MigzQz56w8p
         5tGA/f/Jrb+d1n6eJavrjBSYlRMXjY1VSL/ceDAk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190726143048.GL1131@ZenIV.linux.org.uk>
References: <20190726143048.GL1131@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726143048.GL1131@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 19a1c4092e7ca1ad1a72ac5535f902c483372cd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 863fa8887befa19c89fadb1dc6666ac34314fbce
Message-Id: <156416550342.19332.6858606528013554496.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 15:30:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/863fa8887befa19c89fadb1dc6666ac34314fbce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
