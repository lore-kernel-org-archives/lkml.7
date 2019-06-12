Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB9EC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27452215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560304516;
	bh=mjpZy/AXm9YfznLfbotCtjfRbleaCjIRMqbO8WDfh70=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GPfXOy9si8Vxjuah9nzbRsUTXogmCCo5l/kUOJ+ew870wVfqSAYhzbDqIY4NV/5l3
	 GdDyPq2dfvFBK/1MOSz8H7cx6L7elFlVqb1WayqyBBCZIbGOYnKBOaHzCMp9cEN6zJ
	 4R1umCKoPvLuY1eE0CjyHcpXRx0K0G3hEL0QeM3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437079AbfFLBzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408338AbfFLBzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:55:13 -0400
Subject: Re: [GIT PULL] Minor ptrace fixes for v5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560304513;
        bh=mjpZy/AXm9YfznLfbotCtjfRbleaCjIRMqbO8WDfh70=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KeQ2dZWSNXS5341KaDgyM4gY77EDlRxXcGznim6yMmq4Fr02ng9n0YQhbvZYKJm+p
         YcIkmOfyHFFi3PTlf22evlrIUryOyUjTj7qy1ikqFTCb00rznBIMZqZ6Scd7DE71d9
         CNBRsbW+4cK+AWfQHBDad9Q9JSP7xBJlDpUIAj7k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87d0jj6fcw.fsf@xmission.com>
References: <87d0jj6fcw.fsf@xmission.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87d0jj6fcw.fsf@xmission.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: f6581f5b55141a95657ef5742cf6a6bfa20a109f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa7235483a838be79b7c22a86b0dc4cb12ee5dd6
Message-Id: <156030451320.13515.9066573219794161403.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jun 2019 01:55:13 +0000
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jun 2019 15:23:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa7235483a838be79b7c22a86b0dc4cb12ee5dd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
