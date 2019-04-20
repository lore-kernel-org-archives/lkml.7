Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0790AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD3B2147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555788331;
	bh=t94Iztxt4cU3Fgg6wXws5npzu2WafMHz02M5436NiUg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D3l2etjE8bwCcre9OBHB776Oyq6fVnajUufi18741tmpQeG/SX65OmuFg2QLJYJVv
	 jTThGLrEZQT8j9CQHkhw5kJE3eqPFD1cUw0buFgrezJmwsqz3Ngo1zFj3K7xw2FT5Y
	 rHrUfbi9WR6831ai7hwFqORE0Oo55t2F+3PphPsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfDTTZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfDTTZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:25:05 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555788304;
        bh=t94Iztxt4cU3Fgg6wXws5npzu2WafMHz02M5436NiUg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o86vxja3igQmjN71SZSi/29wmwNwzBff1Ge3qATGFZVewW7bue+WM4dPqmv6WIbHT
         xG6oitd0ip1iErglFGt3awnPEAc/jTfKhOpanvUTFeyrTTewFXdXBCTunnLPd7UJrn
         m8jbPKYC2W518IvvU3WODpgIO7Ina53MPGzLdMWA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190420073341.GA34023@gmail.com>
References: <20190420073341.GA34023@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190420073341.GA34023@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 1b02cd6a2d7f3e2a6a5262887d2cb2912083e42f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b4cf5850db6acef2bbef52e3011f9bf93484209
Message-Id: <155578830469.28386.8338420281366637795.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 19:25:04 +0000
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

The pull request you sent on Sat, 20 Apr 2019 09:33:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b4cf5850db6acef2bbef52e3011f9bf93484209

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
