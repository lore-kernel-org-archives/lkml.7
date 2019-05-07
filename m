Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85499C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58796206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557199508;
	bh=iABvr0GxsU/P+5SEw4Lu96lUQz9vyVvQXaCofWRqjV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JjHwIDFm/eokg4qLZRjUQ035fkAhNglZVQ00CmVf4FJCSfR8+FkeVxQqP5SHHJOUG
	 /GWbZPtL+zxbR+53IHLB5qbfnd1Nz95vkybzEnZ/G6ZVGiWVkPqMYwSnb84s1J0I/A
	 9g1Ij2RKr+tdsqkOVw8bFtBgcPJHE3sKikTv4uYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfEGDZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfEGDZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:25:04 -0400
Subject: Re: [GIT PULL] RAS updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557199504;
        bh=iABvr0GxsU/P+5SEw4Lu96lUQz9vyVvQXaCofWRqjV0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u7oHL5tO4+Rsix5o/BC93bRh4XR+8rLfdjJ++R2yFQd6appVy9UScHEeJAlW9DO+R
         3PMLxT1nyxv3ic4wyswcOFVPPrKODXQSkNXoAxz9DpnRs6aGIc68fDiKWvoyLR+TXp
         4/+SPgsMOiNQaIfh10Mo/ptMRk2Rd/fUWFJNIxLE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506114651.GG6094@zn.tnic>
References: <20190506114651.GG6094@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506114651.GG6094@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus
X-PR-Tracked-Commit-Id: 71a84402b93e5fbd8f817f40059c137e10171788
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffa6f55eb6188ee73339cab710fabf30d13110a7
Message-Id: <155719950433.20841.14404063553357728016.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 03:25:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 13:46:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffa6f55eb6188ee73339cab710fabf30d13110a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
