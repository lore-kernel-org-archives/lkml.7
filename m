Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007BC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A652083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551486008;
	bh=n0MIIZoBaVxADXl9CAsZPjZSpwScQ2b9G/ssWVMasvU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N1u5cF73pkW91vWpbmR4/WOcKtcXFRNNvIFy6ePznVbmRHADVI11JSXSFznjo5F+w
	 zBErU0MJBoXG92UvH+Mjzq1iwiBbZ4jbmXdswDEQ0xheqbt0wlncSG7mPe6LFBdaZM
	 hqlt6J1SZcfeuOW6zDDYHT9yuX6NR/WgcUsA0MUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfCBAUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfCBAUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:20:05 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.0-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551486004;
        bh=n0MIIZoBaVxADXl9CAsZPjZSpwScQ2b9G/ssWVMasvU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e9dfJQdvq/K3pTBypmyb6gV/Ch/76s3vlNqRBgHWNWKNRybhvLJTuMAZufJDPK4av
         H296Ub6cCYlawhgb2Y19z3thh3PqstyjQ00skwNVTANfUpGHDgg/lSOdMgfIlnQEcn
         aKg4QTVyxMgCXfScE5/4bxEuRfb/BUX9dCAezztY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190301165700.GA20504@8bytes.org>
References: <20190301165700.GA20504@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190301165700.GA20504@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fix-v5.0-rc8
X-PR-Tracked-Commit-Id: cffaaf0c816238c45cd2d06913476c83eb50f682
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a215ce8f0e00c2d707080236f1aafec337371043
Message-Id: <155148600471.30240.4627044240857620670.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Mar 2019 00:20:04 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Mar 2019 17:57:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a215ce8f0e00c2d707080236f1aafec337371043

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
