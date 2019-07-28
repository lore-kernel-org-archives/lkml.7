Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C81C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91669216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564335023;
	bh=8f0vQVyi42TLo9vftSJyGTcKK0iudi1a1qqKZKcoSSw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sDdI4lBpI0y5TnBpSlaMlNfrqsuWBSo/8HUPRZ1N+WbXzWeVOTGcDOrdr1QFPDtc8
	 FF3AhU+/C6aDsBeQ1d4qIrzGsofqxLxZKKGy+oewoQ0pwAjJgUrNUqgf0EA0pAZfxV
	 LmYKPTgBgGKLNoeLVuW0wW7pDZeDXlOtAy+Bv5g8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfG1RaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfG1RaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:30:21 -0400
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564335020;
        bh=8f0vQVyi42TLo9vftSJyGTcKK0iudi1a1qqKZKcoSSw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tkkEmN3c8cMLwDufnmNi3OnhX2YKXyX35hjmuxOXjXY8Qy+J33ObSBmW4nciO1r8J
         KSKSoYYHCnciSeWVZFO/s/nLM582gCjcCoNmYbK7Gofb3VzWUktT5xikB6N+XKeb1C
         eb2grjf7gfPsbOTOAjlOMmxbTu5QeBn+ZRSGrJqY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190728120133.GA16163@kroah.com>
References: <20190728120133.GA16163@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190728120133.GA16163@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc2
X-PR-Tracked-Commit-Id: 61d51456f35760a09e8aa1e6ddd247f1547015d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 572782b213b284e05cbbe941a18df055d8d1d898
Message-Id: <156433502059.9558.4900138612595522246.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 17:30:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jul 2019 14:01:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/572782b213b284e05cbbe941a18df055d8d1d898

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
