Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBE7C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C977A22387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563921605;
	bh=3URHmg5S84zST8FLhBpSgxIgYtv4jOr9FrNf0IW2YzU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XpAu4qGvB5uiZfWU4gkKTSfqsJjyEa81JyDA2Fa3dYGVFa2tNG2bkZhhkPflY2DCN
	 E7XwyefiYrW4vhcrKeb1Y1BOwiSEtYkMkmrODWwTC3A3Pd5VJBcieDg5LWUwC0PEz6
	 +jpqiRyEYajf5g1qkTkeuSrt39x8klQ5u+O+NsRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbfGWWkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731091AbfGWWkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:40:04 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563921603;
        bh=3URHmg5S84zST8FLhBpSgxIgYtv4jOr9FrNf0IW2YzU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A6Qb31RpSX+LOFlp0py9dMBXcq4Q3vx3jQwl1yDtVMgrfVoEVxwdAF6CEl9XJGwy9
         5c0EsZUdH/esihacrZi2Ir6Y7zJzEMHlBaBO1GHPYXiaxm/7GesdxtQGh6wm4FO3lf
         9Xq/HURCFU2LBvzNhgjirlPdolON1gJQM6YXM3Us=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190723214344.GA30785@ls3530>
References: <20190723214344.GA30785@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190723214344.GA30785@ls3530>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.3-3
X-PR-Tracked-Commit-Id: 69245c97560b40f88c609b078f4b51c5be81d88b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad5e427e0f6b702e52c11d1f7b2b7be3bac7de82
Message-Id: <156392160346.5279.2897687973383997307.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Jul 2019 22:40:03 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Jul 2019 23:43:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad5e427e0f6b702e52c11d1f7b2b7be3bac7de82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
