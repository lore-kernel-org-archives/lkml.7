Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D575FC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A008C218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555128332;
	bh=n8NH4Y1L1DH6UI2W3QKN7H/opyQY2zW7chzFdevz05Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a+RHw/I22mwFprySNLMi4BtDYPC/hT/diBcaG3Azp6vxjZT7GZk2rwRHSbAA5eQCt
	 7X2jcbrhejH1gj0t+NQ+5Mlyj2l/WT9LDJ975X37/e3bh64Luuo9/S6nfgebYEk3FJ
	 9bl+o7L8ZKrRni/1kJm0dXGwbaPhMFHU4YTLs8vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDMEFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfDMEFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:05:06 -0400
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555128305;
        bh=n8NH4Y1L1DH6UI2W3QKN7H/opyQY2zW7chzFdevz05Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j/1Sjazf7/Ik2VBRBDw8vT+ycS9EzXjoFVTXVBJ5JjgbdwLnvuFsuVdVqRQqlmj0W
         v4UWojvHnEtzSMAZP9A2G6KtMgJ257zufrs+Z908iqoB+zaS7PwIoal2OrbQ1AHOsY
         ExbXVdkllg3u+7WPwnflPTif0PCGDUqi8pM5clbQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412130811.GA119417@gmail.com>
References: <20190412130811.GA119417@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412130811.GA119417@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 0e9f02450da07fc7b1346c8c32c771555173e397
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e6f1fee60a3d80582146835ac01d9808748434f
Message-Id: <155512830586.12181.6260205788654368688.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 04:05:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 15:08:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e6f1fee60a3d80582146835ac01d9808748434f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
