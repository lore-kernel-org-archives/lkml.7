Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501AACA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2077621D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571357708;
	bh=soPDvfWZzCOiWR8Dc2S8JX5kOP5xHAukB2H+7IlVZ/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q6Wy1fEEz9CLGOatZMLHa6sLtZduP7xSjcWCEQ1+n7kQ30RbUbX1PvsRJP/QK5c6+
	 ESFRSyMrGKRWrDeVc6Owu/h6Z/DhjUTkQkci3sriEXCLAPIfURnYVeIkfH4Fn5gZre
	 YMVe3WsTmeddTmo1rn2AEvM9Ai97A+188I0KxAkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503819AbfJRAPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503799AbfJRAPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:15:06 -0400
Subject: Re: [GIT PULL] arm64: Fixes for -rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571357705;
        bh=soPDvfWZzCOiWR8Dc2S8JX5kOP5xHAukB2H+7IlVZ/M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BYBJnn6/CXgYjA1V2eIuGeqQT7SMdv9SdZw8uOwBw1C717umZ9oegwwG3oTZEfkJ4
         yO3PiwgW2NThhEhZSOlnjR8/Ty6odUy0orF7Vi6stgwKIqZgqc6Fm5ivh6EMZv3J2p
         g1QimGEDqZf0+tkzclrYu4QwN99g8pypKS+DpvyE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
References: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 777d062e5bee0e3c0751cdcbce116a76ee2310ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e2adab6cf285c41e825b6c74a3aa61324d1132c
Message-Id: <157135770556.19677.2191598282446582691.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 00:15:05 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 00:43:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e2adab6cf285c41e825b6c74a3aa61324d1132c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
