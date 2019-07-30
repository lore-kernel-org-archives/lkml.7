Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2800C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A6020659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564519224;
	bh=1/Nui8xT/ECAjXZzqkf2Owrj28Wqwo7XwlfpORfVslM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=g2bYXdxuiscWZSfwBvyrsS6031aZCQnQE/7GP4vrDevW3IwXpkhnOiyyiEvH2d6vY
	 cAeWrdJzRiVOrz9bRLyWGejmAGdBiBxUckiWradi5nbFZ/1I7CtnxBTyqSfrLXYq75
	 JXJFioJ1POwHNMICLhKjn5SKJhNyD+bwQCANywNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfG3UkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387450AbfG3UkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:40:22 -0400
Subject: Re: [GIT PULL] pidfd fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564519221;
        bh=1/Nui8xT/ECAjXZzqkf2Owrj28Wqwo7XwlfpORfVslM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TlHLNX1LHaD76idHXmgrecpSqwjlCiPRp5IOag8n+2sTWcCHa2w9tId7vP9nolNo8
         NgX6Fa11RKfxp6cfi0ekhezflW2utrpSyzI8Y2GTWgB96Nmh5GHYcim358SozCVcGu
         /fzbnPfg2D0Q1aw+7wR9S2BzRycanEwaZnumjVCE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190730190437.19004-1-christian@brauner.io>
References: <20190730190437.19004-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190730190437.19004-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190730
X-PR-Tracked-Commit-Id: 30b692d3b390c6fe78a5064be0c4bbd44a41be59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 629f8205a6cc63d2e8e30956bad958a3507d018f
Message-Id: <156451922178.18459.5388960211013592427.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Jul 2019 20:40:21 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, joel@joelfernandes.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Jul 2019 21:04:37 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190730

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/629f8205a6cc63d2e8e30956bad958a3507d018f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
