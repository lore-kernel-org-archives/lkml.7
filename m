Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AA22173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557345628;
	bh=v0GB6t/7ljXqwebCwcPSBvFJwRUY+LrOCFURVNC4Pco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LPp+B18GM238GaaApX45+ZbOXSGN0PoumY+g2eM9IQ0NBELwZsM7BjG2dhbPlsvf7
	 lU5FIe9c7NsDLOfOd5bVszVkIi5nlOd7D7w20mGi6CdilvCYQ7YfRwF/mOeoSSvHVm
	 BmFFvzByAYw15yl4SQgykufnR9R05Siqn9dkST2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfEHUAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfEHUAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:00:14 -0400
Subject: Re: [GIT PULL] nolibc header update for 5.2-rc1 (RISCV support)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557345613;
        bh=v0GB6t/7ljXqwebCwcPSBvFJwRUY+LrOCFURVNC4Pco=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UbNwZdxCTZ2Qc8k/QkwME5nhV4iHQaWTrseDkqEaCM1t5TkQQ9P8lJQLYvNogoRpC
         YN7TNd9f1UEwKrmQaERO4LdOBpInkcxEMMbDE+NglyKdz3dKNV5bZGFTfW3+8xAD+A
         q9nXvNMvU12jssC4K0dyuYJ02V1p8MuTyMtPnN44=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190508140027.GA17190@1wt.eu>
References: <20190508140027.GA17190@1wt.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190508140027.GA17190@1wt.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/
 tags/nolibc-5.2-rc1
X-PR-Tracked-Commit-Id: 582e84f7b7791bf2a2572559c5e29f3d38a7a535
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 019d7316ea84b7d8a8bcb9f2036aa4917a32986a
Message-Id: <155734561349.27473.13745037826993652118.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 20:00:13 +0000
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Pranith Kumar <bobby.prani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 May 2019 16:00:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ tags/nolibc-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/019d7316ea84b7d8a8bcb9f2036aa4917a32986a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
