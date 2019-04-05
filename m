Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA03C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190502186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554508212;
	bh=E9eDV05l0GzbydLPPYQ6+1QOgKgXdgNbzsrh6RDbOI8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dIEgY74YwOQrirgDec44obf6W3RwFPG52QXcAMOhVfiCcm20bV4OvVjVNUKpvpB4d
	 40QfxOtG2KXnoh40TcbKmAkelLPmt9B6xo+K+sx4LMBeXYDCgX+YVKDQGAxRtBmMsG
	 Lii7idcDhj747wjWqVzb7P7dwycYkQBnjCMcRMnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDEXuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfDEXuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:50:08 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554508207;
        bh=E9eDV05l0GzbydLPPYQ6+1QOgKgXdgNbzsrh6RDbOI8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ftfbWB8KqD2eZgrEoKFrZMCbBa61tCO1gqzng7sKfXH7+Unlu2rHsSpb4jG5SOkrI
         j0C3ToXDrBbgDThz8m2AhA4ImSX6gGh7zZpLAlVE+ioffzRic1peV0s764Ob09Vhnd
         Zy0gFKukYPIlsxhPfzOTiM/BuIyYZW7oeqkm1jzI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190405171719.GA14563@arrakis.emea.arm.com>
References: <20190405171719.GA14563@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190405171719.GA14563@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1c41860864c8ae0387ef7d44f0000e99cbb2e06d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f9e10acfa1243a7d0ad323873f4a193144a25c3
Message-Id: <155450820752.23520.9654885207257250761.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 23:50:07 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Apr 2019 18:17:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f9e10acfa1243a7d0ad323873f4a193144a25c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
