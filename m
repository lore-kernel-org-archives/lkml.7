Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14508C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB142467F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576443013;
	bh=4zdkNIjusAjEvESombh0pStUMrJDcv4a5mmA7pKnX/g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=miwLx7Wkl7ITXhhPYj86vVijwIdTlsHJc9wXX91UAGirb4cO6Oxoofb5JGk/o1XVA
	 tC79RkhagBxOr5b34ad+5FSLje/z0U0SctMxK8gMkT7lZiNPZqeDwCh/5WX919aBGn
	 jMdkj4LDPsjYSAelHBVJgvM11p3VQIxmM7Wip+co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLOUuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOUuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:50:12 -0500
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576443011;
        bh=4zdkNIjusAjEvESombh0pStUMrJDcv4a5mmA7pKnX/g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lWkj5ytk8skGyadTEP9lpQYxOOMWmgEA0vnDoypWf2jWMlGdnhrwH/vjgQdIY75mB
         Z+0O4O21u2Zz/LOLP8pbQWiAcqYMsbLi5qq9k2EnaaflL9RIXkTXuCh7sPVafrTCQ3
         BjoI7302o7erDpcTEebgaRx7YBkwIUUlBDIik7d8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191212181422.31033-1-linux@dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191212181422.31033-1-linux@dominikbrodowski.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git
 remove-ksys-mount-dup
X-PR-Tracked-Commit-Id: 8243186f0cc7c57cf9d6a110cd7315c44e3e0be8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e6d304515ba9936d85265ad93dddc4c13c17d06
Message-Id: <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Dec 2019 20:50:11 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Dec 2019 19:14:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git remove-ksys-mount-dup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e6d304515ba9936d85265ad93dddc4c13c17d06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
