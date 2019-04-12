Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A56CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE390218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083008;
	bh=iAIfwCGiRF1f0s/ZzPQh8LCMwap3QtBvcW4uscQ3NfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=B6CQZ5nPIlEiuCZglLi4bd2tKqqiUeej/yWrqQ1AeoCqQ8zcgRQV3jtAziM0O4L0X
	 5p/bN8c5/WTpwg67TywAJlG2gTHgDIAMV5VFqQukLwysnkvhEo4Du5iJAQ9NS764OO
	 hiVTCoVZC30szqdSIYsUXUILHdoseOhP5Gc+eHDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDLPaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbfDLPaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:06 -0400
Subject: Re: [git pull] drm fixes for 5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083005;
        bh=iAIfwCGiRF1f0s/ZzPQh8LCMwap3QtBvcW4uscQ3NfI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bhIA3WbvA9ouU9/sg6vRQK4rI998W02yEHv/wR82Mzp1K3AKfUn6t71EY8T78KJx1
         AFXXcnSlHpbL7ZqJVhrOcAQBGguKZGcH8EtbB+RuO7WZY7sPr3KeszXunB7zbp8+2r
         q1oaHh18ddbbzZwUdqdzC4+ddFRgaA3p/GHLYzZM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw5ALn3-+TNW2khkAk9oHdks=paxXu=fqO40onohrvxyA@mail.gmail.com>
References: <CAPM=9tw5ALn3-+TNW2khkAk9oHdks=paxXu=fqO40onohrvxyA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw5ALn3-+TNW2khkAk9oHdks=paxXu=fqO40onohrvxyA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-04-12
X-PR-Tracked-Commit-Id: 788f07ebe040922c89e38f609b7890ba52a09db2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58890f31f98db230e708905a7f0bd700756ebbed
Message-Id: <155508300553.31973.18249127186256523701.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Apr 2019 15:30:05 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 14:04:12 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58890f31f98db230e708905a7f0bd700756ebbed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
