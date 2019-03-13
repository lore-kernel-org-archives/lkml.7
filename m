Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C4C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E27E213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552502419;
	bh=pC7Hk0Ttt84rF8fYZTr4dm7VPVSIsFoEgqrs/RPkrV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VR5lHMmwkh/ZYzXEcppVAAI2sXgFSCtwXBLBzD9tsp2xxxkHMthJ0YaB8U0xliejD
	 6lPekm75vri1VfYC9f8XoJU50L7+YGZQJM53YxZozBG9s9g1FUUBDzUTxIKrDUB9Lo
	 JNKOHDSB3P0lGKWigMg0xjQjsPOuqeNsCRzpl2kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfCMSkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfCMSkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:15 -0400
Subject: Re: [GIT PULL] apparmor updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552502415;
        bh=pC7Hk0Ttt84rF8fYZTr4dm7VPVSIsFoEgqrs/RPkrV4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ipHraNJphBcC+MtZ0l21JaY8T2Mr0Ee5M4dG1uApKiG4KQpsEUKoPhpBnoSuY405F
         4IQkpP9faCR3CNzhxxNPTsAGORc8xo93rKSXmctYUeDSKz1fqOTV1gJtPzs9bZlRLB
         5y8OvT7aAXqcmJXUgaXSeoHceDmlAJLwNTLbY7CQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d695d181-eaa1-eb62-9d01-56e4e52178d7@canonical.com>
References: <d695d181-eaa1-eb62-9d01-56e4e52178d7@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d695d181-eaa1-eb62-9d01-56e4e52178d7@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 tags/apparmor-pr-2019-03-12
X-PR-Tracked-Commit-Id: d8dbb581d4f86a2ac669c056fc71a28ebeb367f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8636b1dbce854363cd98922b3e4b49a603c4d5fd
Message-Id: <155250241498.10454.14887241728608854003.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 18:40:14 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 05:23:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2019-03-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8636b1dbce854363cd98922b3e4b49a603c4d5fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
