Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0249CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C649D21903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552771517;
	bh=BhXsJcKGMhbZiBWDvOWRFV5nlHnS3hScCWy/xkXlG7o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qudn9XH3fzO3mfbZwaPDH7WDe6t0VtjF0cZ5lW9+KZnwFf1oDV1z1McD1/lxN/KLH
	 yRrx6ODwA2OxXgGUatR7V1WRLIM+gp6ZBvvg2nfSADOGwpYsHaM3eVG0jtI0/3Ezbb
	 iRTEKE522YdS2i6PVmaNWSvx1Z4k+JHs8+vazxYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfCPVZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPVZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:25:15 -0400
Subject: Re: [GIT PULL] pidfd patches for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552771515;
        bh=BhXsJcKGMhbZiBWDvOWRFV5nlHnS3hScCWy/xkXlG7o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hPHB+jTrVXTugIhrYQuL08PRufiE9RBP2lJoa17e/OTq6mf5P1zO+oAc0Vbp03mDY
         YMFo+FEWTrAjbC1W6gx8q2PIkkiIYnhHHmEoZNLJbFYA9Rd132sr4bVOXEOuf7E7p1
         VoORtKv/zQsSCkhF0JeG0oLPIDBUlwdfdmWbvtqQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305171301.23147-1-christian@brauner.io>
References: <20190305171301.23147-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305171301.23147-1-christian@brauner.io>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
 tags/pidfd-v5.1-rc1
X-PR-Tracked-Commit-Id: 575a0ae9744d571f7c6aae4487a05850baae9e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9dce6679d736cb3d612af39bab9f31f8db66f9b
Message-Id: <155277151544.28247.8109419608467526638.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Mar 2019 21:25:15 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
        Christian Brauner <christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  5 Mar 2019 18:13:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git tags/pidfd-v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9dce6679d736cb3d612af39bab9f31f8db66f9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
