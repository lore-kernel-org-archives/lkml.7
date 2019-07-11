Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C48C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5F22084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562885120;
	bh=XBggxdE2WumShzCsdRC87aW4JZd07onrYg0w+FIu4lU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s4UaA6s5jQ/4GiwFh2pR6eYIjksPiM1oxk71e48wfS9dpmR/+iSq317R97GyqubTR
	 d44atbZ+ANMcrqGNGPkvNGPILAvZos3XKvS6oMhVdGccGTBuwDFbPn6EikkA+5PBpm
	 m9LIcZxxyIBIxMkxjHpxbqC92ePIqLw8xYlGWqyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfGKWpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbfGKWpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:45:14 -0400
Subject: Re: [GIT PULL] TTY/Serial patches for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562885113;
        bh=XBggxdE2WumShzCsdRC87aW4JZd07onrYg0w+FIu4lU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GKAN8o7HH5S2+Ha7OHfiqmyp3dD2T4+DUw46S5roQylSXM7W2dqzm5DQJpOynMK3B
         f3qx7hmeCzto2+rLGtCjSbdGhXk4ihmJDngnW+CRwPoqIxBkLYUjBe78JpOVG4qxV9
         2WJ9LNJKygWu0rtZBryOEJI01SgjuWWU0aNvP5tE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710133247.GA24083@kroah.com>
References: <20190710133247.GA24083@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710133247.GA24083@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc1
X-PR-Tracked-Commit-Id: 35a4ed0164e992c9c7b82eb1370081a292131904
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d72619706abc4aa7e540ea882dae883cee7cc3b3
Message-Id: <156288511388.25905.1817368092932800061.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:45:13 +0000
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

The pull request you sent on Wed, 10 Jul 2019 15:32:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d72619706abc4aa7e540ea882dae883cee7cc3b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
