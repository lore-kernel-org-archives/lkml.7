Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AA822BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564071933;
	bh=3LH01SBWhzp8lTHtgUqSeEpR+jY+FtOs7mMAkGQMU9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RYch8uSGhDafqGIeNExUzcpNnIXamZ6/aZj8SS5kgMPpvpkJytfPJ8KgKw/8vUAEh
	 mObqaDSKfUeKTqQD+udCtWx+LuxmoIcHPSJzr4Bg+idie0ROWezx8efyAM+KgQCUM5
	 6b0wi41qz/5V8v5Y9zncX8GFxHof8gMZGxGqSOVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbfGYQZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387677AbfGYQZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:25:19 -0400
Subject: Re: [GIT PULL] ktest: Fix some typos in config-bisect.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564071918;
        bh=3LH01SBWhzp8lTHtgUqSeEpR+jY+FtOs7mMAkGQMU9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s/aC2bf8iBfHDvQtvsWB16fA7c6WIX67h/xD0re24JCTwKilukF7/cvoiCulM+BuR
         oNFQLQnmUFHrR9Kxtn5KVgOfLB+q/9yuBMClieeaDb/bbk7h9uyaaZqwmZWjzpD2G5
         Qu2QTY+hr79d3Pmh5zAsYFVA/GMO2NJKbfQcRHrY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190724154711.2698f244@gandalf.local.home>
References: <20190724154711.2698f244@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190724154711.2698f244@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
 ktest-v5.3
X-PR-Tracked-Commit-Id: aecea57f84b0586b62c010bea946468d77f6bf0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da3cc2e6f168fd52630892f4672f2f26bd217198
Message-Id: <156407191874.26857.545577017149394846.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jul 2019 16:25:18 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Jul 2019 15:47:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da3cc2e6f168fd52630892f4672f2f26bd217198

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
