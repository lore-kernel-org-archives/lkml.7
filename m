Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC29C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F09B2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574019308;
	bh=xbfMiemDLREQHG+yPmiDSAgZjvaaA6EWOeJhj9EsZVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w4tBka0xvGsxv8c9VR+B+SqFOxl4JgiAx/MkWMRQ3nSO3ylKH4k2kPFDuQWV+nxen
	 PaFtDccOB/4R44XwvXYEhYAxzRP5Mz8XxBKDY8/2l2EqTLTg5KHQRh6nfJ6ONBkzx5
	 KY3HwVuqitYCp/VUrwDi+YN7zUWA58FiBBVrGiSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfKQTfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 14:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfKQTfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 14:35:05 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574019305;
        bh=xbfMiemDLREQHG+yPmiDSAgZjvaaA6EWOeJhj9EsZVc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s7cTT/lTIOAcuGVqBngjwcZpAXa4+6rlNM9T/Rd+sjoXu9XTRZ51rEPjDUZ05VZR9
         LkmWYnD070BCPNCHc8noMc5wroUau7BTLfj4qXoUkezvWbpR1jEZsnAdciFv58w1BF
         vgENCHJK02U70o8XbILD9DMwuPo6oATYneMKHI0I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191117185507.GA2578@8bytes.org>
References: <20191117185507.GA2578@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191117185507.GA2578@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.4-rc7
X-PR-Tracked-Commit-Id: 4e7120d79edb31e4ee68e6f8421448e4603be1e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec5385196779fb927e7d8d5bf31bef14d7ce98ed
Message-Id: <157401930535.8182.1564061217555148491.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 19:35:05 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Nov 2019 19:55:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec5385196779fb927e7d8d5bf31bef14d7ce98ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
