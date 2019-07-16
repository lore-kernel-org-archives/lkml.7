Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C5C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF96221743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563306019;
	bh=mFaCk71Obp+ZzNnZFTVkJkYF7GTksI/NA4n86omTqfg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z2/mTl0Yt9Fb0SzZ32bNDO12wbK0nqdZUBBRIolv7wHBdtPwSNJO0MpDoD+nKWoor
	 Y5i7LjprMFKJ2HJB02lFKZ5MZQygMxb9/87Pv8+SzkSyPamDH7gYqPlnfDRjdOjY12
	 Zq3Wzz9FwLVDPuapocQ/5fd+OlaOKtVscYDLgKGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbfGPTkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388866AbfGPTkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:40:18 -0400
Subject: Re: [GIT PULL] pidfd and clone3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563306017;
        bh=mFaCk71Obp+ZzNnZFTVkJkYF7GTksI/NA4n86omTqfg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xaSSAUEKtwDB80KbDZh50L4hvBWQaziiLRyVUC1+feaTXizhqxgJmtZd4n0VFHRm9
         5/vSRnw8sP21PBVDefLQ49tFlCydlUt5fjJqlB0nEAA9uuz9I+VQo89s2IYgV7c0Yy
         gXFRN1QCeUEMrqoE35jKY5FPBT+8znug7juR32Xk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715151509.3151-1-christian@brauner.io>
References: <20190715151509.3151-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715151509.3151-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190715
X-PR-Tracked-Commit-Id: 69b53720e92c1bdea854a2fc204477ddabfa902b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c69914b4c7b0b72ff0275c14743778057ee8a6e
Message-Id: <156330601781.24987.14382168743362213732.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 19:40:17 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ldv@altlinux.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 17:15:09 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190715

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c69914b4c7b0b72ff0275c14743778057ee8a6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
