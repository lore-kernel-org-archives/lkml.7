Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D572071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574747111;
	bh=8hySCAvFwxNPVx3p6xKj6WywkLv5vFBXxIBs/Ao3lHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oNlV/JVlf1f8lIAErE3c40FZm0CYXmzTos9c8f5qvlBBgM3hnAjbrJo02j+o3kqX8
	 P2stdVzJqosq5PUey2SH3hH8YQ9+b2pFaBmSiPgr/kCEQTQ77PArRhtXPpf6y7kqaT
	 ezF30K5DB26fhiEjiMvLf1dBqwDRGbD8E9H4OnJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKZFpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfKZFpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:45:09 -0500
Subject: Re: [GIT PULL] IPMI bug fixes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574747108;
        bh=8hySCAvFwxNPVx3p6xKj6WywkLv5vFBXxIBs/Ao3lHU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MCcdZexW5TnqgSVCW1iQwZQKIUKK0B9HnmWrymrw1K/owFC15TbOVWvrBD+v9rjP1
         zZz1BeeR7B3skW/00M26VQKw8ploXuRe3tR5eNfXZWuyfvJVEvI237KZeTs6izdftZ
         GzE3wQ5vQ48Xv9+DL6lBXrXZnDtPVDQQAW1g44DA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125165945.GC3527@minyard.net>
References: <20191125165945.GC3527@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125165945.GC3527@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.5-1
X-PR-Tracked-Commit-Id: 8e6a5c833333e14a5023a5dcabb64b7d9e046bc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be2eca94d144e3ffed565c483a58ecc76a869c98
Message-Id: <157474710884.9386.13214233036520397987.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 05:45:08 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 10:59:45 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be2eca94d144e3ffed565c483a58ecc76a869c98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
