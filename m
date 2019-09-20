Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01FEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEE52173E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569006633;
	bh=pT4cIq+qbYDvYC6eSboDOcSlbJFd/dK46BWKrrQuBVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ly5Kmxs04CE6Blzvzro5abXWnc2MyaW32b0qnYbwjTIVWmrcg9Q5OMYFYpPZzdiC9
	 lP9HVPUaE7TzIVzkhUCxS/mrMSEgcwZeLggPhsz2XXGfEgxqlDDoFUhcEDiOZfx7xw
	 kYr8JG/HuzjeXx4Uq94Sfb59smCMAyBXzLLiv7yY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436688AbfITTKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406870AbfITTK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:10:29 -0400
Subject: Re: [GIT PULL] arm64: Fixes for -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569006628;
        bh=pT4cIq+qbYDvYC6eSboDOcSlbJFd/dK46BWKrrQuBVg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AfobFpd5wnOH68p49BwHvrCu65OSX5Y3A7MSvqPVOfRin99GT4AXtjqG3ZewXiCJd
         /4JH5BaDA4AY8vCPUZZf5HzECe2Xif7b5qc1flLQ0bxeQI0KfWSzhs60co9KyqbiTt
         ItxF+IqWV1nbJ8ZjVjN9RHqhD6NbzcdAvbqbTudE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190920133703.zor3t4dvwam6uyqj@willie-the-truck>
References: <20190920133703.zor3t4dvwam6uyqj@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190920133703.zor3t4dvwam6uyqj@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 799c85105233514309b201a2d2d7a7934458c999
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c2b418c3f95a488f5226870eee68574d323f0f8
Message-Id: <156900662888.23740.6256981181910647860.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Sep 2019 19:10:28 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ndesaulniers@google.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 14:37:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c2b418c3f95a488f5226870eee68574d323f0f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
