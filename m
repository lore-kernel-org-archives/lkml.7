Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23EA24676
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578344709;
	bh=MtwfprF12fRZGmuOyD+jEC84wM3ugYYf5PJuYPKcdrc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p7J5ikG5srciWZlInrQTjDRpXxH4e29y9p1YOao0fYE6Nz8N1/+KtG2p5mtRMBvWj
	 +XSVVI24DEmeHEAE5Pnmtmiij8lBbh8+cAJRWeL95EwoQnnod4PTPsazCLuqXR5rJj
	 GWNsJ29ViqGufjdVB+m06MRW9MWJgGARLEdx03EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgAFVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFVFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:05:08 -0500
Subject: Re: [GIT PULL] regulator fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578344707;
        bh=MtwfprF12fRZGmuOyD+jEC84wM3ugYYf5PJuYPKcdrc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cq0SiYwuNrMwr+egMpa8TISHg7o9iskDqz0GdZm1t3UhX6AmTizhfW/D5jppNuuFa
         SSxH4IQGnoyFNsn+UQKTCX/srIKgSh94VyaW+OY9nZ7JdbQsNK1xMiZUovdw2xGT1Y
         Xz1IoTTTgR04b4KM+jravByqb8jKD5Ntn1Sfah3M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106130632.GB6448@sirena.org.uk>
References: <20200106130632.GB6448@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106130632.GB6448@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.5-rc5
X-PR-Tracked-Commit-Id: 6f1ff76154b8b36033efcbf6453a71a3d28f52cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5acefdc27b739e68294259c1a89c39d250246554
Message-Id: <157834470777.27503.14880015732193891463.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 21:05:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 13:06:32 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5acefdc27b739e68294259c1a89c39d250246554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
