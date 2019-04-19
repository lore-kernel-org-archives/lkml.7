Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F5FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E5B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701009;
	bh=0ppEW66FpxAJH8pXi8CNG2YeLsuu/hVpLeRMRZbt/SQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LyoSk7sOZ5v0yTEEa8oJcibtdYuQ1A4dXM8v0dd/N6jZ6PdoyC9CZvM2bN6Ia8TUG
	 Zl5ndppnYueEWbG+qKxtzJmkHLyN5xM9fKTSIJo2el6Qm2z3vA9FbxW0OwtIyf/k8y
	 Wny1Dls6cZkpz3w3buW+4qV73MB5NCXTNT0lmZhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfDSTKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbfDSTKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:05 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555701004;
        bh=0ppEW66FpxAJH8pXi8CNG2YeLsuu/hVpLeRMRZbt/SQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jw2yCBSV5QuCmBH/cNkv9d0U5QPhFVAYz3h2NUQ5GkyZnDPq2cJ6rLJwEUtDRTF2s
         kTbGewdnYDG2KEajUb89J7ZacU6kLu1fs4R0zQVmzP6iaUJkEklc4zh2+Q/HOt7nKP
         A9L1Rp0OJ1xOmOXRefZyZrPcNvMA2VxrGpFqu4oQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190419123042.GA4761@kroah.com>
References: <20190419123042.GA4761@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190419123042.GA4761@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.1-rc6
X-PR-Tracked-Commit-Id: bb0925b283fe558fa9530c9d0b6158e9b6c9dfa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9764dd4d3befedba403fbb20d99566f4d26829d
Message-Id: <155570100494.4805.15363448480912025771.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Apr 2019 19:10:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Apr 2019 14:30:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9764dd4d3befedba403fbb20d99566f4d26829d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
