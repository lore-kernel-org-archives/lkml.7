Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430DEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B4920644
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669766;
	bh=uTThZTmk1EG2UhZH8Yh2qMi6q0TVlDWYdYtAA2VYj30=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=slTAbDcls5k0vArQWAso3x+L3rZp1TTDksooMXWf/ZkQC8WofvNV4mvhvaohLDGf/
	 6qYKkQLIqDBOikPFloGNADkGagsLg42Hn8GS3yo+9s8NjuiW8lTg7ruaYWouwX1oRJ
	 94ppyJM7eameNKS1ttYQkQigk5ZwfO4ZAiJ+fOT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfIPVgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389463AbfIPVfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:08 -0400
Subject: Re: [GIT PULL v1] core process updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669707;
        bh=uTThZTmk1EG2UhZH8Yh2qMi6q0TVlDWYdYtAA2VYj30=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=toQ0xVf6BZ+1xNwN/V1UC8acb3Zarb+M0DlXPiJGgibN8i6aYWF05fvWxXE78kY5l
         kPq8nb4ML204PDj20k2+4bbqlXHU18Xoudwan1/pTPL5CPLpgEgTWiCezWt2jblzGo
         Ys57obmDhOwcREoLvT5DTmkSEK9wdHNgOsTheyEU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190910160051.3795-1-christian.brauner@ubuntu.com>
References: <20190904133418.23573-1-christian.brauner@ubuntu.com>
 <20190910160051.3795-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190910160051.3795-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/core-process-v5.4
X-PR-Tracked-Commit-Id: 821cc7b0b205c0df64cce59aacc330af251fa8f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c17112a5c413f20188da276c138484e7127cdc84
Message-Id: <156866970747.13102.12480230809400556567.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:07 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Sep 2019 18:00:51 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/core-process-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c17112a5c413f20188da276c138484e7127cdc84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
