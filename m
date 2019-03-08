Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CEAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D15D208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070158;
	bh=nRyoHu2iE2Yqb+bTEm1CvKxjxZbfIt+yeoRmXBa2mDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=agupC24BYTJoWzmGXJrb8GkZgRNqzTkQZpOT9zDDrYbYzO+UTztJ7BWvOdfnCX4k/
	 yzKZEtVR9j5EMnv26Dv0q4MqISbOuvcouAg/BX0ExbsKnVQphMNHnOoMYRtiSjyviQ
	 cSvziOm3QT9bUhBQDSR6wi602VNkq2dgLqgtOvio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfCHSfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbfCHSf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:28 -0500
Subject: Re: [GIT PULL] Backlight for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070127;
        bh=nRyoHu2iE2Yqb+bTEm1CvKxjxZbfIt+yeoRmXBa2mDA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0YRkGUQ7cPTIR2ogI+7+jAFSrJV36mg1ihWSCGas/fOBe21kKFfmOo5PPCk7GeVgW
         56dcrPQpfePeOnh4slh6NrneWbsH/C/0mFOl+ON2iMPC5jki32ZWM5Ml40hNSuBY86
         OQsRpUSUqL9PEy4ck+Z4nCouNnTsfYVP2RER8ZGA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307093455.GC4634@dell>
References: <20190307093455.GC4634@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307093455.GC4634@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 backlight-next-5.1
X-PR-Tracked-Commit-Id: cec2b18832e26bc866bef2be22eff4e25bbc4034
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04e0361848afbe86fbf8b80945568df4c5bf6f07
Message-Id: <155207012783.7904.9464956077482554068.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:27 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 09:34:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04e0361848afbe86fbf8b80945568df4c5bf6f07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
