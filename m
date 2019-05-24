Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C7C2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558719408;
	bh=ea7tQ4I3l0XYPLSzWUVRBi8wD4VUi3zM6ApyTznKSEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pAfzMzaFuOXodR5V/39GOQOEWCUHFlnCQkrYNnfEnJBCe6PcPL4YCvJq3bdW24N6e
	 inCV7jD3awS5veyLYdPCmTcjMon59gX9m6VHchvbCwCPrW9mXhmRnVKIpUWIjgv6uQ
	 iCBu7bzIMl+3uZV9+Z+g469HirxrmrnTspPNE0IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391776AbfEXRgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391573AbfEXRfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:17 -0400
Subject: Re: [git pull] drm fixes for 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558719317;
        bh=ea7tQ4I3l0XYPLSzWUVRBi8wD4VUi3zM6ApyTznKSEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bprlgLNAzPSZJdRkts86dpLgIYrLhwlZoo4T5vrIIgQMpCiVm13OS/a342oGnvoM5
         HuAl5wy4Ph7cy1ds7na8Q9vG5j6rKGibObG2nR1MRQdLNIFVizOdzLT4ybbanJ+5W6
         hUZP3Mg90tIwIuBD/4NLnMHucmTkmUFr8rTWqaeM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
References: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-05-24
X-PR-Tracked-Commit-Id: e1e52981f292b4e321781794eaf6e8a087f4f300
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c074989171801171af6c5f53dd16b27f36b31deb
Message-Id: <155871931712.20356.1440632621890156969.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 17:35:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 14:28:08 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c074989171801171af6c5f53dd16b27f36b31deb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
