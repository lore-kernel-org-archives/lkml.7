Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19991C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E431520835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574883020;
	bh=0BjfvpddLOC3ud3mOCB5xeUdclPpMWxpuVJUYEA4bRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y8UFPVSgvKbhUTGuufmk3/4CwNMqfDg3DxGytVuQX6cDq7uU88gyVC+nVKsd+nzj/
	 kBCI1/T8YNxXnMeOGUGdEMedaDlYwjqagh0i+qVljEAUlWBxMcrHXwXZL8XSQc5LS2
	 otfDZqj9hDG+/Dv1vgF3RuCS8FwsC0t7EvaLyKF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfK0TaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfK0TaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:30:17 -0500
Subject: Re: [GIT PULL] Staging / IIO driver patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574883017;
        bh=0BjfvpddLOC3ud3mOCB5xeUdclPpMWxpuVJUYEA4bRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oTBbF0ozXxs3wIxlu20/ILMuWr5S27MJseyFHwAnhJl6m0c9eYZfgA7+q/EtTmyuA
         usfqW5od/JZJdmhSXpYwPJgva/THQW/ODSKlASho7RNc03kttrdmsDJeH5ZEJa4bMO
         HkokU7IGjAO9U9bGkZtQ/c/K+UlzhmVFPyAERMmU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127163515.GA3087498@kroah.com>
References: <20191127163515.GA3087498@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127163515.GA3087498@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.5-rc1
X-PR-Tracked-Commit-Id: 0f6f8749872e7be6c083dc845bf4d45a7018b79c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dd09bc02c1bad55e92306ca83b38b3cf48b9f40
Message-Id: <157488301725.32229.8963038948658119912.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 19:30:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 17:35:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dd09bc02c1bad55e92306ca83b38b3cf48b9f40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
