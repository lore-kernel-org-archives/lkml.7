Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E5EC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901F022BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165532;
	bh=ycXJxCB7TjsI3Gy8EgMha0covz94YKyIcyPusNT6Tsk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KKl7m7VgwOCKi5KPpVe9yCrD98VzMlvChDyDEDrv5DnVUtYTWTeDiuawveRQH7is5
	 rXKJsdFzj7GjIsvcdNv8naqb3SoknebflNW9y+k6D/IDcA0fNWfqclHWkAEATaciEE
	 kKZ74va2XhXxTE8jiIX6vB5N/EXnp7kXksCIAySE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfGZSZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbfGZSZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:26 -0400
Subject: Re: [GIT PULL] arm64: fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165525;
        bh=ycXJxCB7TjsI3Gy8EgMha0covz94YKyIcyPusNT6Tsk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=llRfxGgWUrU2sqaFNrXnrSS9IssQ9JFadjG6WvfHjVJg6LKcGcKiVhSHNjp7W2N1Q
         eA8K9N8tGUBXkMzLQQ877sxJEUyKoo6ZldkmQMTlRrdir/JU9oR+1/KwdlcLdgVHFB
         dW4mNtI7dCbA4MiCw8u9b0we6Hua42QYhXr4d1tA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190726131215.2dqryzjvxfyqefuw@willie-the-truck>
References: <20190726131215.2dqryzjvxfyqefuw@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726131215.2dqryzjvxfyqefuw@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 5a46d3f71d5e5a9f82eabc682f996f1281705ac7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ed288665686a52781c0ff04ddfe402c7a5397e1
Message-Id: <156416552538.19332.17458620883704995487.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:25 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 14:12:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ed288665686a52781c0ff04ddfe402c7a5397e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
