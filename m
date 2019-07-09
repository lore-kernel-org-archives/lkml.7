Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF7C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC702080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562695554;
	bh=NkcUNciY6fp+o9lV42HpyjayCavwwzbOIUw8DGSWkZg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wMznMB1m/RnUOv+4IQKLHwtpAUIAdj9fS5W8p9H1dyuwGbE7gbPeRG0J33AGUqldD
	 Oc9A31My1vPpSITHKJsW3/StpLBDIenNbhyEzOudstaP1PpgHywCUn0hXd/qkjo0rA
	 4z63/qL9FpOGgRyJDOpBnfpFjuZIi0JmimcTZGKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfGISFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfGISFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:11 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695510;
        bh=NkcUNciY6fp+o9lV42HpyjayCavwwzbOIUw8DGSWkZg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O2HrqHuzIETZrvVAyGqeN/bTaCkyGWjXXzZPR8dRxpyf3k5+ZvcpLbLXipphJ9rw/
         JG85yusEn7aITVVTq3efrL5e1AQzlyyOy6hrfMed6XILl2nqjttqUGxTTX3bRMqdzj
         iKaKhJlVvTCn4A+EjwUI/ryRBSdaLhHq0djeSImY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708160601.GA1214@8bytes.org>
References: <20190708160601.GA1214@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708160601.GA1214@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.3
X-PR-Tracked-Commit-Id: d95c3885865b71e56d8d60c8617f2ce1f0fa079d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b04014f3f151ed62878327813859e76e8e23d78
Message-Id: <156269551078.14383.16540843583255942762.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:10 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 18:06:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b04014f3f151ed62878327813859e76e8e23d78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
