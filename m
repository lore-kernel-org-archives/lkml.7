Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A378CC43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B34E2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575164427;
	bh=BY1A+hhpbLbXElnuimqf6SBG1uPo2NJxuzJaRnqv3Os=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vXF4xwMxLNTbi3yHPWlMmZmB9gLDY6AanE/UuJhE9Oo7jfvnLtDplMALENF/hPffH
	 Zi1h1/t7tqTxRm2jc2/uoOtdntPCqFuMmeNjEHSQDmpbysyzpl4Ra8RynsVZ0gEuDa
	 c9ubbs9Cmh7rpCFmDBMRBhwoaq5vbl1Zu1WJBAR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfLABkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbfLABkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:40:21 -0500
Subject: Re: [GIT PULL] Audit patches for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575164420;
        bh=BY1A+hhpbLbXElnuimqf6SBG1uPo2NJxuzJaRnqv3Os=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NEu4Wy6A/WWCMRnpnDof9f8rDp2hRZ4Yc0cwmajteXtnyX7qczYF3rdfx+DYU7HtJ
         /PDrd8idoYcjxK3K3hWSDYXxswf4XypVsQIXVjot2YBS3j683wQHrAnj5CEf8SA2JF
         WtDCxYxoae6FV3t4md2t454kmy+nip1ZiLQbzkfM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRnN4yWO0So+u4Ktm1N8EpAbe+W1AGPXU-U7Bd7cPBv7g@mail.gmail.com>
References: <CAHC9VhRnN4yWO0So+u4Ktm1N8EpAbe+W1AGPXU-U7Bd7cPBv7g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRnN4yWO0So+u4Ktm1N8EpAbe+W1AGPXU-U7Bd7cPBv7g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20191126
X-PR-Tracked-Commit-Id: c34c78dfc1fc68a1f5403f996de8ca62f298d7b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b805ca177a24ff78b466ca73febe8466c67ea61
Message-Id: <157516442058.28955.13379032546958515249.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Dec 2019 01:40:20 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 16:33:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20191126

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b805ca177a24ff78b466ca73febe8466c67ea61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
