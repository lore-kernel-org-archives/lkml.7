Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14096CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D814921925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571439007;
	bh=FKzAlNN+TyJBmE9+y4CpxN/ZJGSJcbXBg++g7FzD46g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uk2b+HuNC5dSXMz/vn37fXfFLj6SaZiLVXr3OinJrpGzpZY5Cmomi91MhI6hNVQ1g
	 D66qg4lhx7uqtUETymKmMiK+pZhVO4bcxy6UVDNf+aMx2Hvj2CriJuFwvNaA1F99zf
	 fjTdJiKTjBjYN4HErNaHREIZ8mcZLugTKM/+lluM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394930AbfJRWuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfJRWuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:50:06 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571439005;
        bh=FKzAlNN+TyJBmE9+y4CpxN/ZJGSJcbXBg++g7FzD46g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RGgsiADRCN4R+BG6B7z1H/if1Fl/fC3kWBAbqgYHTIP8Y8AYqjk+48GS3rJgQdgW4
         XmHZHiUq9t2cQfsPn7r0TJ2sOcBWEI/PGeqntId4QviOhc/Y35OpoRfElMsbKhlYzZ
         0j9wPuamXv/vnG+LDJgjltRnKZO+gKr6bj7fPavY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191018155403.GA9621@8bytes.org>
References: <20191018155403.GA9621@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191018155403.GA9621@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.4-rc3
X-PR-Tracked-Commit-Id: 46ac18c347b00be29b265c28209b0f3c38a1f142
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90105ae1eeef51987f40d8e2db4c9c79604fc4e4
Message-Id: <157143900556.13317.13328781026600840171.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 22:50:05 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 17:54:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90105ae1eeef51987f40d8e2db4c9c79604fc4e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
