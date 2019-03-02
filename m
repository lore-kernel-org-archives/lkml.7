Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4E0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E712083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551486012;
	bh=noXHThylEqHUR6v3nDoqX+fibtPcLyQFj/qcruLmvDI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=x45TBb/Y2ooRKomBxOizj/RNBTnBDfUlNt+sxTOX8oehdNLBpZIYe2u1Oxauket38
	 iE1WI9EhT80Vqt6N/r/CfdufivhZ3tmyO1cRjRpKp9diSi+jHgWBTe18oOswQl1/cp
	 Q1prDZxy28XLSM8jyJ9fJlZhP208MtdW+svD53p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfCBAUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfCBAUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:20:04 -0500
Subject: Re: [git pull] drm fixes for 5.0 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551486004;
        bh=noXHThylEqHUR6v3nDoqX+fibtPcLyQFj/qcruLmvDI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=haxYgWTs0etI3nR1HLlMI+ITA+6rdP7wtL8ulRp0uBqHMWKXqxfl7KOtt0xOvOssI
         6KXCtnILkas70F2fhFwFTGoJP0PsJe4JMb84ELp9a/JFmTznNxd+PfOxd0eOtzgtkr
         wfi5KyqqzxJLAJn67hfmeyExbDocmxuqL7Wsn0Zk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twK9Yqer+wJE6tH0rAjSzXayTJyqQoP75RwDk5a3XNH3g@mail.gmail.com>
References: <CAPM=9twK9Yqer+wJE6tH0rAjSzXayTJyqQoP75RwDk5a3XNH3g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twK9Yqer+wJE6tH0rAjSzXayTJyqQoP75RwDk5a3XNH3g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-03-01
X-PR-Tracked-Commit-Id: 17fb465f16027ea22225b282295f5b8af19992e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6357c8127bea35c52085a0ae0f97e73de2419825
Message-Id: <155148600409.30240.6940342817146488509.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Mar 2019 00:20:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Mar 2019 15:40:01 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-03-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6357c8127bea35c52085a0ae0f97e73de2419825

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
