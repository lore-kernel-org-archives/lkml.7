Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8787BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A020661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897081;
	bh=VEcYUr4po5MdizQ7nvH7//F9Ma9YX5g3Mv7+83NJtz8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ItexTjnHHCikTAVV5WP7tlP4T7348vMshddVgoPWWG2F1LkD/Ra6mVPEaQVB8siBf
	 N6AFYQKHBu6oOyo3nMJfDWq1ohNqSpTI/GVLNi/arUu1hyiUhGxWlCwFh8AIsc+b4+
	 KLVmsIQuuTQ5yphWAZpM3t42deXzK9RKHcx8KeX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCFSaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfCFSaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:14 -0500
Subject: Re: [GIT PULL] scheduler updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897013;
        bh=VEcYUr4po5MdizQ7nvH7//F9Ma9YX5g3Mv7+83NJtz8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HgbjEIZpEBR3LaAJLonM1QlN0mtOVR7Gg5NAE5Nh9PwJZlpjWjB/zi4hce3+EQcen
         dnH3dE8a9B+bClf8kaACjtelXqQOlzH/WzMAk9KtpivHlKjq2Dut+6FYxph8WEeHoP
         briDjWOVjVqWzACKy/FW/ZsvquXMUcR0/O6Vquqs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306074411.GA21345@gmail.com>
References: <20190306074411.GA21345@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306074411.GA21345@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: ad01423aedaa7c6dd62d560b73a3cb39e6da3901
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45802da05e666a81b421422d3e302930c0e24e77
Message-Id: <155189701385.14612.16151368534597268567.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:13 +0000
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

The pull request you sent on Wed, 6 Mar 2019 08:44:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45802da05e666a81b421422d3e302930c0e24e77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
