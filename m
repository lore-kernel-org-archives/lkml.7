Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80129206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556304005;
	bh=VJ4cxFdUktStWBWyNxOfPNSiDqvNZPbIa5bIrGef3Dc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=o/u7VmwgwuXR1rTYAsSLp+ns3uvALdmpZ8QUkuIDLAEJnhJt7jhyMN3hUkZ8nfJgZ
	 6m5QlszrdfOyMv7TQrDfmjGpJ7grGxxTn7/QHfLSLd1avjG3PhnCmhDtKysIly8/9D
	 1HRlA7eywYHFuz+1xptQt0xV3Rmf7ch8XlyMuPJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfDZSkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfDZSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:40:03 -0400
Subject: Re: [git pull] drm fixes for 5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556304003;
        bh=VJ4cxFdUktStWBWyNxOfPNSiDqvNZPbIa5bIrGef3Dc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j+7TsnrjzuYid5F864iR96U80Uz+K8A4HUdP6fIlbszkBKgRHBQz/D7qaVkmuqrrE
         /dApUC6Imhf4Jy2C5s2dnBUpVmQKhtMrwjL0T6JEiZ2P71/jKfGNNzrgOpH1hy+77R
         iPGbjmnbkz5O5wLBg8qA2bYxBA7kxqZhguJ45kvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twJ1AQ2Nt-+HUFJa6a_Z7F-kxxMtTgaafRRWtYpgFYkBA@mail.gmail.com>
References: <CAPM=9twJ1AQ2Nt-+HUFJa6a_Z7F-kxxMtTgaafRRWtYpgFYkBA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twJ1AQ2Nt-+HUFJa6a_Z7F-kxxMtTgaafRRWtYpgFYkBA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-04-26
X-PR-Tracked-Commit-Id: 6db71bea59f964d241bdcf1e73e47aebb7427888
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e40f0f35be86ed5d8724d52bc38af5dbab06470
Message-Id: <155630400294.7251.15331457102768129277.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Apr 2019 18:40:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Apr 2019 10:46:30 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e40f0f35be86ed5d8724d52bc38af5dbab06470

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
