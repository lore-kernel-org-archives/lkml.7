Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE0C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95320665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565973015;
	bh=C+15RRON7v0kZNLZM4cWgiba2GqK7EyGHEkGjYx5UfA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PbDQQaKC5vnj8Lam/ptrv85HjRLWeHrWhPUU4nwhv80zQT/Uw2F6tCMj4tLkRqTZv
	 dH0tXowaASXKc18YRVyWiv7ZO1Jewq6O7Dqre2CvtkSkLfnkg2HXC6AKEK4J8XzNNm
	 xiV+HoEWlZ3uRm+9Veh1hQMVCEjmR3vupMqaR23g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfHPQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfHPQaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:30:07 -0400
Subject: Re: [GIT PULL]: dmaengine fixes for v5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565973007;
        bh=C+15RRON7v0kZNLZM4cWgiba2GqK7EyGHEkGjYx5UfA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PjlYNJax/L7UGcDSkucKo0TTavXoe2/VUOj8GwiQMtCON/4sHzYxrX2PPxMstVWL1
         14ZBeIIFJEUlMsI122qDsJb6cim0+rvpy5/EHDQlFWxOJ45xB4iB3SPIxW/V6wyMqF
         ODpc3cQp/ao10YyELyKFsVqvazEZMtyHURFY/BAY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190816094627.GB12733@vkoul-mobl.Dlink>
References: <20190816094627.GB12733@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190816094627.GB12733@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.3-rc5
X-PR-Tracked-Commit-Id: d555c34338cae844b207564c482e5a3fb089d25e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9da5bb24bb368567a43ac2df0e108e43d80f3564
Message-Id: <156597300729.15122.18141782735058596853.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Aug 2019 16:30:07 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Aug 2019 15:16:28 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9da5bb24bb368567a43ac2df0e108e43d80f3564

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
