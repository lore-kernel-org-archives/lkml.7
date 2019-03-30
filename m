Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E516DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B756D218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553967018;
	bh=ErptMl5i8gx4N+lL+avKxkgDFmFKvL43Bvagw2Vk0Ss=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ToSHN4y7hLlH8I9LV7XHJ3I0/wl4Vzf/vH4Eu4cfkGGpLGnTsWwlMMVsA9n+D1wXs
	 adWet2TzMRbdGWPkLxgnXVb86jVkAfLSMo5ccK/tP0MBggr/kazM7zFA5NtcVNLNCA
	 /A+l6bGAjeJNE9PLmzZlmiPfRvmpc/ls3QHETKaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfC3RaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730582AbfC3RaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:30:12 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553967011;
        bh=ErptMl5i8gx4N+lL+avKxkgDFmFKvL43Bvagw2Vk0Ss=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vzK1LUVRYEBNV2zvrNp6ilISKybWZWgU1qKEL5MTqQxdaHyr1QXrv8ZEfYUVS3fS0
         jRvAcDKVlLz6RAb2X4UVR2ss71Xx/vpT1CZ0GegD4xYN5OixcJW3Cb4yq9gEFFS3KC
         STs3DQT5XMidEUaiRgyJehAKc3IcovWRv086+quc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jUqQz3hY6JONcWfuLG8Bnn9vtZQcWWPnyE=PYOpVXRJQ@mail.gmail.com>
References: <CAJZ5v0jUqQz3hY6JONcWfuLG8Bnn9vtZQcWWPnyE=PYOpVXRJQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jUqQz3hY6JONcWfuLG8Bnn9vtZQcWWPnyE=PYOpVXRJQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc3
X-PR-Tracked-Commit-Id: 31d4c528cea4023cf36f6148c03bb960cedefeef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e377a1c7e2465831b39dbe24ec04c0a8b36fc76
Message-Id: <155396701175.21865.15726909985095376042.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 17:30:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 01:37:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e377a1c7e2465831b39dbe24ec04c0a8b36fc76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
