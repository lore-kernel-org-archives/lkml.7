Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7128C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC788218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552686357;
	bh=wUOAlKg8D5vT9FLblXvn+ewjYaJND38DFeh3wksG/gw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oOLtEb6F0nf2IpmEIgmq4DVuG0RThmKtd6v1sZ9pvOjOuyckE0nsb7WzW+/9ZiiPH
	 3eD7zXiqYVD96o1eE9IAVslyA4Yqhg7boyaxxxdD2AhQJz+DiYKjjU0K/25rpbUFlj
	 7sxUXL6OisdRzThbRIittCYcNHAOUC5UNS2H4qAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCOVpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfCOVpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:45:17 -0400
Subject: Re: [git pull] drm fixes for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552686316;
        bh=wUOAlKg8D5vT9FLblXvn+ewjYaJND38DFeh3wksG/gw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m9p53dJUXQslEf+TZ10x7vCq4ismTB+6uGzkcGZRuSNqKZTa3HefwmrR8WK0U+qva
         G1EbfqyTGIfyAwJJe1fTT4MBr10f6ho/ojuGbbjVvtAY9sJxvKWvS6wq11kCMZ2PKZ
         PAD+cxjGvEsicnb66GOudrfSeXFkeH2HKY7o+qds=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tykVGf4Y215gPygj==9wW0Bri7BADN6y9oPxcr6aS7M1g@mail.gmail.com>
References: <CAPM=9tykVGf4Y215gPygj==9wW0Bri7BADN6y9oPxcr6aS7M1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tykVGf4Y215gPygj==9wW0Bri7BADN6y9oPxcr6aS7M1g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-03-15
X-PR-Tracked-Commit-Id: 0f1d37e65a59e9db33ab85f6e2c9784768ef80f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8264fd046a0884d6bf475a784412978dbbd93175
Message-Id: <155268631680.16247.7806713109350553298.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 21:45:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 10:35:19 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8264fd046a0884d6bf475a784412978dbbd93175

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
