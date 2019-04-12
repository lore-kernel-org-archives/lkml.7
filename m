Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3824CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EB72171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083024;
	bh=LVLlYU1mja7fPUF1NB0GxrteCIGNGgN2+dBuEY0MMzY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UvRHdq90W7f9xfI6Acls+jggtooKLGCvdodEAArDM7rv5ysacB5huIDHxiGJLEfAF
	 9c7AjO9a9s/ASEUCsbgjlZC7glTI3Z3q9y6t2L6uynAkA8pAok4V4wtdns54DB46ja
	 UtRfbuZYIOraHOU7pGOAFX8QoXV+K9O7f1Ql4HYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDLPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfDLPaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:06 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083005;
        bh=LVLlYU1mja7fPUF1NB0GxrteCIGNGgN2+dBuEY0MMzY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SIedByLA68UI+WBf8qRNh3Zq5ogAth8hbnMnqw9qej8KK5JRJPStV5ldCgwue7PjA
         Vv3W+swwOR8yFvHXSfCzp9WzOvOJwklQplLwpGRRAAYB2FXoIWfzmZDfcocB1otdaP
         r/UNu6bwNImhe2QwEBJdFmMZj5c2aN8nZ13JfP9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jfyUSTRs909hsPhDSEt__MGPKC+1UBsG8oieWE07nn5A@mail.gmail.com>
References: <CAJZ5v0jfyUSTRs909hsPhDSEt__MGPKC+1UBsG8oieWE07nn5A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jfyUSTRs909hsPhDSEt__MGPKC+1UBsG8oieWE07nn5A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.1-rc5
X-PR-Tracked-Commit-Id: c5781ffbbd4f742a58263458145fe7f0ac01d9e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2a7346955e56cacdc2f4ec6165537cc6fe5689a
Message-Id: <155508300584.31973.4807584345812902892.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Apr 2019 15:30:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 10:11:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2a7346955e56cacdc2f4ec6165537cc6fe5689a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
