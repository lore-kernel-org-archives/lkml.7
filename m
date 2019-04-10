Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED537C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B848920818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554915007;
	bh=CFr5mO+k0lrftgY3lmOL9xx2ANcD8qxdQjMwx9d2UVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nmQAtz6uZ2Wv+Sx6ts62uSYSX4kKZc0Wpp3xulZGXFNU/rxkqx/c/SxuFUKEvmv4B
	 KutkF6GEXNW2AEc5oN3qpnCwsNS5wNeV4vzlsqjO+HypT2gVNzZCNUmEPVXJ25QHja
	 9yC1BcHIjPzy8JR5on20dTARzMjlU6MDraASOTd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbfDJQuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbfDJQuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:50:06 -0400
Subject: Re: [GIT PULL] apparmor regression fix for v5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554915005;
        bh=CFr5mO+k0lrftgY3lmOL9xx2ANcD8qxdQjMwx9d2UVY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eFF0VIwSIzupX6ZOewJKGY0moE6SwLXmWosV2tpmfhBC4yUgFVPrLyuIpjSkKQXgE
         gv3YtbA9YekkYgQlmybacpANjn0sN/zBVZ0oNQAvJjC8MDmTt2K6k1cQbzO1gzob2l
         BdGgmc3IEo9UXW8j5CQK6A/vM1X7fWI5eJP0TcyY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <234e0edf-0dd2-e74a-019a-4ce536af3358@canonical.com>
References: <234e0edf-0dd2-e74a-019a-4ce536af3358@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <234e0edf-0dd2-e74a-019a-4ce536af3358@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 5.1-regression-fix
X-PR-Tracked-Commit-Id: e33c1b9923775d17ad246946fe67fcb9be288677
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed79cc87302bf7fbc87f05d655b998f866b4fed8
Message-Id: <155491500566.22837.15712405643591989947.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Apr 2019 16:50:05 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Apr 2019 04:32:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor 5.1-regression-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed79cc87302bf7fbc87f05d655b998f866b4fed8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
