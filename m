Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A990C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087092175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554440715;
	bh=dL9J7tDeLiHnM4KLVAGHilvHhSMjNRixvwvV0T6arwU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rJ0KDfpjrGilIMyKCCITXXZt2H65Ed+XmGejfz70TxHDrSW8fxWgZews660fgnF7z
	 yFPAg46jql1oEo09HnSjNMm/e4lEFHYdFNVj3acN9BKR4TMp6bNU1ZgyEKrVscubPm
	 cwVztn16yWZlIWYpk8s9I4m8Qq/KCidGaR4Tpj+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfDEFFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfDEFFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:05:07 -0400
Subject: Re: [git pull] drm fixes for 5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554440707;
        bh=dL9J7tDeLiHnM4KLVAGHilvHhSMjNRixvwvV0T6arwU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LjpXaWi9iwo8haFtOYK+HYfnXmAJJz9MIYGBhRRDMlDGw38V7rQlV3GI2iQ+BNUC2
         XsM/p2L3/qF+bLYfqeCmXtaePyzlyFcjUmGmsaHquuTwWZPLLWw4ovB3SE7Xo3+9AQ
         GQFnnjQhen4oWFYoKAAiyEGjjVcWNaYs5HMiz/RU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txdKn5TUM=CLQgfVfw9v9fwkn+MgfUkVX69uvst=KfxkA@mail.gmail.com>
References: <CAPM=9txdKn5TUM=CLQgfVfw9v9fwkn+MgfUkVX69uvst=KfxkA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txdKn5TUM=CLQgfVfw9v9fwkn+MgfUkVX69uvst=KfxkA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-04-05
X-PR-Tracked-Commit-Id: 23b5f422e8f42d9d3b7063c05c839a8b0ff5adf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea2cec24c8d429ee6f99040e4eb6c7ad627fe777
Message-Id: <155444070741.4287.9887138381845519590.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 05:05:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Apr 2019 12:21:09 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea2cec24c8d429ee6f99040e4eb6c7ad627fe777

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
