Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C152C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D642C22C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165528;
	bh=nJnUujJ+so3cSBaZGhIbQ4Uh18h9udPXuxvD24fEUfk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j4H/dS5gBYQjnc1t5Zyo/ZmrfWUVMdJHo6RAvE7Wg+qfc4XwgFEvLJ9mWkJx/u2wK
	 4Qr8/pQw9vqFkpzHL8QalibKqnYjz4A17WR4tP2dunSZmft/EYGPwOyqp8oLNGITl9
	 vda3Lzn3Tjaq8FWBLvVAJ3AA/3mnTzZE3RwixfUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfGZSZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387469AbfGZSZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:24 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165523;
        bh=nJnUujJ+so3cSBaZGhIbQ4Uh18h9udPXuxvD24fEUfk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qoj913NNaMCDtEKCHQB9WDDAYKoLceduU7weNRH3+fvEV1dF6Ay9x/FOhUfE9jFT6
         xF8WCynyqH6ugrC3aWK/3uxiBQA0fYJTA0PqVNS1Jr4/j0PPJFeAUaFyFWpIyndesb
         hpmyOJzQOFnR0/oK/eDYguyTVh1khOdRVKguXq5w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190726092048.GA3957@8bytes.org>
References: <20190726092048.GA3957@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726092048.GA3957@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.3-rc1
X-PR-Tracked-Commit-Id: 66929812955bbec808c94d7a3916f41638a98a0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b381c016c5cfea94f2ad22c0c2195306a70d54ac
Message-Id: <156416552310.19332.10815430798423943308.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:23 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 11:20:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b381c016c5cfea94f2ad22c0c2195306a70d54ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
