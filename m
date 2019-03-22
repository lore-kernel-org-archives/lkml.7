Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32270C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AF72190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553289628;
	bh=QxYcQnl++ZE89HogXIvoszYrC4xq0m3wNugQeTNpi/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QNIwmxvWiKec9k1sgNVQF6wRGUb5qHVY/DcxwwKAFmIe5dgD5Njp2OqjxHttOVzsM
	 vtDaN+K9f0wO5fKbN+UvRDcdEX/evy9/sSws3RoKwOF8xLV+KWaievcbnCyniDtsft
	 zjgaoVvAYpUlRAYYVWHlHDBaWpg/NcEBB2oYsz4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfCVVU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfCVVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:20:12 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553289611;
        bh=QxYcQnl++ZE89HogXIvoszYrC4xq0m3wNugQeTNpi/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fLWVa4Aa0cdeplsrVetMj6WQyPVgBAPS5yzccNoyFVbKKSWpBuppxqAHBYObt+GdU
         T0S3m0obQiHvK1SgRl6gGQEmk6WGGtYlGuv0PBLvZYh64UyjqTEtS3UA+mzqWGwEvv
         aFCTJRg+yQYRv7QaS0KaupC3UE9L/iBKhx1xWjfI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190322112224.GA22496@8bytes.org>
References: <20190322112224.GA22496@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190322112224.GA22496@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.1-rc2
X-PR-Tracked-Commit-Id: 84c11e4df5aa4955acaa441f0cf1cb2e50daf64b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 070c95d457267eefecd70f5dd434740201d5083c
Message-Id: <155328961182.19902.18128280652950568575.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 21:20:11 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 12:22:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/070c95d457267eefecd70f5dd434740201d5083c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
