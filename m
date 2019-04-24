Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9533FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C7F218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556079306;
	bh=fYiWrylyOX8P30F+1TXuhnjbz5Uc/ZNDwplol9a9iz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AGWp2qaFcoTdcI8aUq35Juy9S2MBzJBNzeqThDEXIqb3efuskG/lQKtLoNGz99mFX
	 Z/cV2EGkBA3NnELc9oJSE62+YHEi8pmQcDY1QvW+AWbl3NOlvdMDuCAsi3BRIwS9+2
	 3l6NPCKSqPD/tdMJbYUXUSpLxJMNdE2mM8qFUZRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfDXEPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfDXEPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:15:05 -0400
Subject: Re: [git pull] drm fixes (regression special)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556079304;
        bh=fYiWrylyOX8P30F+1TXuhnjbz5Uc/ZNDwplol9a9iz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V1LpjY0/zMEhPCg/x73y+Z+sRCr4ATyxfMqXDX6R7esipAaeasl21FojemxJkiOHN
         jzk2xQJYziJYQs/eT3w9ejPHU9pR4adZfMi4b3DLvPkskQJHiBOaWyxQULMXrQpAOe
         U9jf55sVRRDifE7/102IhfaWZLKSHM+TRZsAoqQM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tygHnQZXS+etRBwYM_sjuQHACtNEOnXyf+KM5CvryVQ7w@mail.gmail.com>
References: <CAPM=9tygHnQZXS+etRBwYM_sjuQHACtNEOnXyf+KM5CvryVQ7w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tygHnQZXS+etRBwYM_sjuQHACtNEOnXyf+KM5CvryVQ7w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-04-24
X-PR-Tracked-Commit-Id: a0cecc23cfcbf2626497a8c8770856dd56b67917
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba25b50d582ff6c6021eee80824134aeb9ab8785
Message-Id: <155607930440.11083.505771189817551998.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Apr 2019 04:15:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Apr 2019 11:21:44 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba25b50d582ff6c6021eee80824134aeb9ab8785

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
