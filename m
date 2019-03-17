Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA87C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C3420835
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552841116;
	bh=ArJLI2Kj27hkQ93S6TDXRZwh+osx/PBIjXAkQUeuwnM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rlFowjL5pXBouO15NtydlD3IuoKlbVNtNmPQA98J8G2UcvN211tJM5mbGPfeD8Dr0
	 twCr4Qc1Cam32R2cUuGiBfngizFRUK6jxgC3g3TjwS7Cc+nh+PXoNGh1qYUJUcehP0
	 UcSjIICzHTLZnepsUdmGDV0W5Xu2WS1yzNodEtCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCQQpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfCQQpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:45:15 -0400
Subject: Re: [GIT PULL] xen: one further fix for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552841114;
        bh=ArJLI2Kj27hkQ93S6TDXRZwh+osx/PBIjXAkQUeuwnM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rc8UFZ5AkVGq9rZ8p+Sg9QTsDiueZeP578zwEYnH8pcTKX9wQcfDGhZXmJshzZ6+k
         8yc2MnpLfiKySDHXDVo/j46EBciqoXGZpwWSq6+JK6byehqn7p0//dEzhxbilomn40
         3h+CFV3qIhC8eaAIPVy90ET/4o0Jh9uH/2pBmQwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190317074526.15549-1-jgross@suse.com>
References: <20190317074526.15549-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190317074526.15549-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.1b-rc1b-tag
X-PR-Tracked-Commit-Id: 0266def913771e718fd0c998eecb072e0685e2c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5b5138cdb2f833a22cfa36c95d6ee41e98a0a34
Message-Id: <155284111467.10074.11471388491637844211.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Mar 2019 16:45:14 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Mar 2019 08:45:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.1b-rc1b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5b5138cdb2f833a22cfa36c95d6ee41e98a0a34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
