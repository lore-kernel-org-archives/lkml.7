Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B9C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32BE216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669718;
	bh=q52ZFHXm/LA/R2JrWmX2L/Z8vL1yV17IsFuxspLn8pA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KpzuxSDhf8ey95BcwuwNfoEtyrFQ/9Ec31ZBNqgMHA4Z9PRovKCHU6r3lQ5/Z1ePS
	 +KKPVZV6VO2KIxS7qWENzRxhkxzN3ZoRZHEhEwWIFts66RdYCGddSiNLffvtnm2hPz
	 1BmbKDNOJVozZZHD2ha8QF5MuxirwRkRufc0fzhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfIPVfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389133AbfIPVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:14 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669713;
        bh=q52ZFHXm/LA/R2JrWmX2L/Z8vL1yV17IsFuxspLn8pA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zaml9FTE90NT3S05cNZvj/c9qNgoRC4cIoplq2xUQOvw+kg8+kp5shlMd7uOFecGf
         wqAGdybZ0b4QEfpout8vK/BsAV//mYOgEqemCDLR7xDsu+3/UgJz37G7cnvJ6yt0OV
         ya73M7Yhsj+rrOPfln/DsteCwcrLz67JwZkyNBFA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916151342.GA7444@8bytes.org>
References: <20190916151342.GA7444@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916151342.GA7444@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.4
X-PR-Tracked-Commit-Id: e95adb9add75affb98570a518c902f50e5fcce1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52a5525214d0d612160154d902956eca0558b7c0
Message-Id: <156866971382.13102.1513006408940685487.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:13 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 17:13:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52a5525214d0d612160154d902956eca0558b7c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
