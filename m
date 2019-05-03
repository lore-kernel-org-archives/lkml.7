Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA0C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CE0206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556900411;
	bh=PdQwiRjHsghdoXxNJ3/WJ9wiBAJQB1vDqM32KiE4RNc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jkqd2AUTmxw4RiLHyyrIvLjO75lPuPwCSIJBXfFiuVMM5EXw98IgLosAA76eqUg7H
	 c5NDdo7WImojLjrLuvYKa3dkLQdbhnhUQ2I/UNzT7YiIPBvlGJGFW7PFHSeuBc6dIH
	 PeWqU3sS4KrtBChSxRzDr6Yb/JqdnFULjJvC7RiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfECQUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECQUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:20:05 -0400
Subject: Re: [git pull] drm fixes for final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556900404;
        bh=PdQwiRjHsghdoXxNJ3/WJ9wiBAJQB1vDqM32KiE4RNc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p1BHXSWZyuMRt+Dh4nAvSdb/dwQ7FRlq1Ywfe5716spBnvJxwl/mYJ9V9zzhWlwJ3
         SKQXY44gKYPvs8P/vOgga3AbmaYMDArrT+qZjUXFXxaDwVLaH5Tn3NOvBy5pgKUxAV
         sVgIbwRPFWM8NX5zGFDjywyhtovXUQARG6KlB/T0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twjCLCi0rVHeaK1CtyD=13PSFxdDTDK4LvV-w89Wr6DvA@mail.gmail.com>
References: <CAPM=9twjCLCi0rVHeaK1CtyD=13PSFxdDTDK4LvV-w89Wr6DvA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twjCLCi0rVHeaK1CtyD=13PSFxdDTDK4LvV-w89Wr6DvA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-05-03
X-PR-Tracked-Commit-Id: 1daa0449d287a109b93c4516914eddeff4baff65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4ccb5f9dc6c4fb4d4c0a9d73a911986f20ec88a
Message-Id: <155690040459.31408.13875118131564070601.pr-tracker-bot@kernel.org>
Date:   Fri, 03 May 2019 16:20:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 May 2019 11:01:07 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4ccb5f9dc6c4fb4d4c0a9d73a911986f20ec88a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
