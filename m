Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40684C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D54A218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552686346;
	bh=rvCb2gVlIygCd3YUXLvoH6R59Le9HKkCajVQEmvDb/s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hOE+F3lA9b7099E7Tp1sfIJe0kTTkF7gH8T6p7nRVz829xWnJc/16jOuPZWcZM9sg
	 BpjpRs40DoTU7HzVoF+5wNfrtFeZOyeNdcKPASp6HRzUUPFKv7VtzOisJ+E7Z8geLQ
	 QfMIPH8mEJnaU7k3Tw1sLEbsUJ4YKz2+s6lz9/2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfCOVpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfCOVpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:45:21 -0400
Subject: Re: [git pull] IOMMU Fix for Linux v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552686320;
        bh=rvCb2gVlIygCd3YUXLvoH6R59Le9HKkCajVQEmvDb/s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vln3/uoBAUJVEHJz4+0/gg1z82lXh9FUwTRU0iUdKJmgF5O1CDVRcVr3A05VMroAI
         Apo4HhGO0IgdkSXQcFK7XvldtwiYQWkYDzavm8ivfTqY5jQOX5yslX1lhD37drERGT
         lO8LvU5nJhBCzi1iaIQacpNypb1jBWZLlqVp/tmM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190315154359.GA22666@8bytes.org>
References: <20190315154359.GA22666@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190315154359.GA22666@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fix-v5.1-rc1
X-PR-Tracked-Commit-Id: bb6bccba390c7d743c1e4427de4ef284c8cc6869
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 323ea40ff6fb1e9d2c481bff50245ee5f559c8af
Message-Id: <155268632060.16247.6577264960740561406.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 21:45:20 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 16:44:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/323ea40ff6fb1e9d2c481bff50245ee5f559c8af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
