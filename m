Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CC1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A76D21851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558722019;
	bh=EbCatF+nk6Yrrx+RopsbQWZdXfG/uf+mUj9qs2Y1cw4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M2a6/K8ZqZmGKZqZnfulIHES+UJp/nQMurGPwBrXZsj3vH0n6MUPJG+2WhCKK4fXW
	 /B8if4onJwQMO1wJDbtlnVOaKiG5d/Uihzv2/CnxP7s3jO1wRiUbJLNW2jM6M5CX3y
	 oEtd2xjkLObZNaWYX1Y3cc5lQrd3vCpmvEjb+EHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391663AbfEXSUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391618AbfEXSUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:20:18 -0400
Subject: Re: [GIT PULL] arm64: Second round of fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558722017;
        bh=EbCatF+nk6Yrrx+RopsbQWZdXfG/uf+mUj9qs2Y1cw4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xVELS5AZpMr7x2GkF7U7Ut/dhQ80wTsGzrrQhxAHfUFsDOuZVwwpDUMMHAH/7Jgl6
         iHJ7XiX7oeS7XticboJGpA1tLamQUIXsfVoQQv5Bu+8bKyZwETWpgi5VksS9wrnrJD
         04dnjx1MYUGjB9ZqB2K7yoPrX8B+pyc/9E9fDze0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190524174357.GC9120@fuggles.cambridge.arm.com>
References: <20190524174357.GC9120@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190524174357.GC9120@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: edbcf50eb8aea5f81ae6d83bb969cb0bc02805a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a72ef89901409847036664c23ba6eee7cf08e0e
Message-Id: <155872201757.27843.1132229878974057804.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 18:20:17 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 18:43:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a72ef89901409847036664c23ba6eee7cf08e0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
