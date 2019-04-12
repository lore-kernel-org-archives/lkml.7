Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42F9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728842171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083016;
	bh=oiV2TF0Cayljh36UB+zkBeste5mIsG5MpuOTV8JQfKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u+1B6igapsckWtA2Ri2R5slBve5GVacT28DWAJq6hqaU010Uftuv2iXjpJfR6WskZ
	 RL7I5mH65Eomo/XtWQRNg1o3P5fNN9L0Fue+ZVupR9u1ILCvaInwT3ioFOYIQt9K7M
	 CC2RJa52skXzcmopNZoUrZ/cS/LSn6iDyRuUjLr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDLPaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfDLPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:08 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083007;
        bh=oiV2TF0Cayljh36UB+zkBeste5mIsG5MpuOTV8JQfKQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZIdGPlbQTcaWPexS1EZjg74qqz+cO9RUfsLeHqxtiHEpIPc5GQrk3OzaVqV8iYhWa
         2ikp9b9ZyoSeJfEo30uPMcCxxeQffJv7eAhVGgIH/w7jY/iqn0b+x4CbH8WCFJywpg
         EuiVCou/jaw6bnETE52xbtK+4hkmAnrVrEGWJyD4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412132938.GA13555@8bytes.org>
References: <20190412132938.GA13555@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412132938.GA13555@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fix-v5.1-rc5
X-PR-Tracked-Commit-Id: 3c677d206210f53a4be972211066c0f1cd47fe12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4876191cbe2a4702b0067d4156e1d8648ac36801
Message-Id: <155508300772.31973.10115471264720043552.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Apr 2019 15:30:07 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 15:29:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4876191cbe2a4702b0067d4156e1d8648ac36801

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
