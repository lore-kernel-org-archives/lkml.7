Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98503C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691202184B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560563707;
	bh=5X6lG+aweYd3ld01vEg3aXWOFE3AOs2/v/c8/zBSmtQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0hpJUqB4c9MKAISHsnBP/n2L+teTaIx8gaA7i04GKLlghaqJmb0jwOQCw7QkBK7g1
	 yGfj8bol4PU054xEQoni3jHgGN60nrcDnAyFK63CI6PBoifS3biTp7Z8uQFhAuHz0W
	 CuUc9lM9Dgljv92Q7rvnl4F4wTaJOa+cfJeOF+PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfFOBzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 21:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFOBzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:55:05 -0400
Subject: Re: [PULL REQUEST] i2c for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560563705;
        bh=5X6lG+aweYd3ld01vEg3aXWOFE3AOs2/v/c8/zBSmtQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G+QxVlaQh62h4DhRUogr3DUrGGr8brIVkd/+blGVjQkZ9wnkVqZB1RVnZsoP//MAb
         KuUP3NXniiJN6e9DXwv4/0n+R47EsL2nWzjY7Qwlz3mDxvJctqdUEj5on8a8GY2CId
         +kt2gwW7jKBkxzEpWos2e6aXKWiP+HZFp3HMX42w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190614164549.GA6067@kunai>
References: <20190614164549.GA6067@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190614164549.GA6067@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: a0cac264a86fbf4d6cb201fbbb73c1d335e3248a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dcedf4600f8708150b89485d25cead88bff08a4
Message-Id: <156056370528.9443.16281348104646164725.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 01:55:05 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 18:45:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dcedf4600f8708150b89485d25cead88bff08a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
