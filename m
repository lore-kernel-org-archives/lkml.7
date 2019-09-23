Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AECC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF2320665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569265525;
	bh=U76FJwtKT0mkJl01AD/IYvcwyuNp6Ikc5Mdzd38gUN4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=njPLTq6pW/jrQNXUqqMTABVwzQnjAGQ24dCzN9a+PkGDhj2NZo6uFE4uyTxHrjI2F
	 XZupu7tR+CLxnmE1kQKddtX6Ow0yDwvc2PHE4NEGLCexLVHeVnXoBiFkj7x+ascdIU
	 /LbGu8pBR8dv0TrfqntmAwyZMdHR1HrHf34RYMtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbfIWTFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733093AbfIWTFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:05:24 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569265523;
        bh=U76FJwtKT0mkJl01AD/IYvcwyuNp6Ikc5Mdzd38gUN4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OQcwLYMVleEQgb3Cl4gMsNKZr9PCCjqvGgp8ISnT7GDlHubtDkmvKMVHfg8KeMgVr
         uz2HLp9pYvKnvNGPtXEmm8lxmC0IUz5Et/jZJ10oqcMFrsyH6KSMeYs/QWVr+ztNaZ
         RW9GdMUjLN9XeAhfdmOhpHgXM8BokAoVOdiFVSl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT1n=zwWJRSqF+OLzQq2r_8Bf0TjO-1QEe3yfLHAnomfA@mail.gmail.com>
References: <CAHC9VhT1n=zwWJRSqF+OLzQq2r_8Bf0TjO-1QEe3yfLHAnomfA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhT1n=zwWJRSqF+OLzQq2r_8Bf0TjO-1QEe3yfLHAnomfA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190917
X-PR-Tracked-Commit-Id: 15322a0d90b6fd62ae8f22e5b87f735c3fdfeff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5825a95fe92566ada2292a65de030850b5cff1da
Message-Id: <156926552365.25044.12209568315799352743.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Sep 2019 19:05:23 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 15:38:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190917

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5825a95fe92566ada2292a65de030850b5cff1da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
