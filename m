Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E127C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D782184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563477920;
	bh=AIVu5bgXjZtq+bohAoyuTUrVouah9VrcQQdD60mwgHo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mPhViEYAA0Hdp07eZlS53PVtqAjwKyKnwqQW6YLtXx/Mu2tF5rKsKzTRIhJxd/e4k
	 ajOk5XjWW7nknrEvzp9KxPc3XBKcUOQuP/3ipm46FVH5xqv9Zm9FGIs7ZpAAEsfPPS
	 u5PrlWLlibwWxa4dLHPLKzGPNjuBFMcxhfZiYQ10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391338AbfGRTZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGRTZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:25:17 -0400
Subject: Re: [GIT PULL] Modules updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563477916;
        bh=AIVu5bgXjZtq+bohAoyuTUrVouah9VrcQQdD60mwgHo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XkETVuvrPoAzSgYofqiJ8IQLw+HHgeCyWdJyGniGdNGmX2rvKSi7ihE+os0MIhx4d
         g6IphbctP+VMPM3sjqYzDoDxMZU/ROy21bUcLnwRX/jx3mHA46Y30rXwEx1ah99GSz
         JxzylyZ5gzkulGCxXQU5pgDDZXblQDW3jUMmcuLc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190718113346.GA19574@linux-8ccs>
References: <20190718113346.GA19574@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190718113346.GA19574@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.3
X-PR-Tracked-Commit-Id: 93651f80dcb616b8c9115cdafc8e57a781af22d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da0acd7c656c09b362b5095dc8595f8655dc1223
Message-Id: <156347791689.32127.14511774981821883242.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 19:25:16 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 13:33:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da0acd7c656c09b362b5095dc8595f8655dc1223

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
