Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA953C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16D92070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576940123;
	bh=MLnfA3nzYAB00Nh83uzmFUMSz2Zg9w+B/yubzgqQZCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KWbFbWeVGYkXtKLgrIarM8IGiCYkiy+qWpwsM4L30r2mni5sOo5xeL8osIdQSSRyM
	 GkVixI1kmvTHHUFaFDAmaG0xEboVEs6x6gsZmWYjo7J+YbX3lC9jMx/asToqFT3UNe
	 kDIt3ZSgmWmA3MDU319HFnVEZW8RMLZp831NpKDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfLUOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 09:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfLUOzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:55:12 -0500
Subject: Re: [GIT PULL] xen: branch for v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576940112;
        bh=MLnfA3nzYAB00Nh83uzmFUMSz2Zg9w+B/yubzgqQZCQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cMfqv8y+0rJA7SBwUZsCsoCZ8kty8vCVDI0MvNHZ6I1V8DOHchPV8leuP4bJdkIug
         e0BuqTed4EknPHbtUV99AHiP+/7x9p6y2AwU3UIZTPmY1XjtKVFXKU3B8f8iWwLksG
         YwlcvbgjEwDXIbRm2Z1NtLml9HoFevt7NcNpZOwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221131946.27017-1-jgross@suse.com>
References: <20191221131946.27017-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221131946.27017-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.5b-rc3-tag
X-PR-Tracked-Commit-Id: d6bd6cf9feb81737f9f64d2c1acf98fdaacebad1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62af608b4b075871f7214c345c42a2e7a456f35d
Message-Id: <157694011209.20544.506027854286834225.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 14:55:12 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 14:19:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5b-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62af608b4b075871f7214c345c42a2e7a456f35d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
