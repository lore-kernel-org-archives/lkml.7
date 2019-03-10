Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B77EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8642084F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257017;
	bh=ZtjTPN8ea/rPAzuJ6IElKXNfcYSj5cjfix62eBRKQsE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D4yHKQM1ZZJ3/9RuMEFIpn/a1bboFtKQ5XtMEWWY1Be01wlGuPqMMKaqdYocDHfct
	 T9KeJ2E0qesDcdYKsuqthvX2wvGI6aRyMfC0aghv1WVhSrNagmdtBiio6QjzrOv43l
	 Njce5Sjk1LlSjn4lPacGeUm9mU/P3sSk5hhTrOuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCJWaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfCJWaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:15 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257014;
        bh=ZtjTPN8ea/rPAzuJ6IElKXNfcYSj5cjfix62eBRKQsE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qThGVvEMZ2PJPRdeAZhaTpEtYoZ/cvInvC8QmDTEts9Hyw9188rklJykZ/0DPIItj
         pHgpi1dDjvjqbnfPpdGSu0O0170jgmv/sty39NgXIKA9nA6Cp5VGn56rGq/oVBUOOl
         xCMU1Z6YT32bexsLWSodlyNfPDMtcFkVQjeNhq8I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190308084214.GA17628@infradead.org>
References: <20190308084214.GA17628@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190308084214.GA17628@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.1
X-PR-Tracked-Commit-Id: 9eb9e96e97b3381e94cba81d93f4a390c26ca6cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7a7d1c1ec688104fdc922568c26395a756f616d
Message-Id: <155225701458.14748.9837414918632727063.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:14 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Mar 2019 09:42:14 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7a7d1c1ec688104fdc922568c26395a756f616d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
