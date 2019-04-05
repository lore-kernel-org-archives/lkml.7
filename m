Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE277206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429317;
	bh=4G2UzrIPT/jXiQ0MqgSb8ygxHABTmX7PxLCN6wxgra0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=htqiU/o4xxodsZ87cFlZJsgZOLuFmeaPjjDdtEHd7Fj8Il7Bz5KHYOBa4/bHtcw8D
	 7EJqn2/izRRrz765FBdwgigpFIsoluww7KGp76XgGxbz/C7+WKxHSZ5zGo/dwOeXZg
	 5EBT6pkMUt9erymuq+1svpqA+31uCUVfRbERttr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfDEBzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbfDEBzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:55:08 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554429308;
        bh=4G2UzrIPT/jXiQ0MqgSb8ygxHABTmX7PxLCN6wxgra0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CFb1kC5RBIRWRsuIFw+QdwoOVFjk53vwd1HCFFAUqiVk14hXZePXK8SYdTmR/r8uf
         i79AroVhszG8Msq759v7Kx7td8S2h5l0RZMNHesE1kDpqkr66T8piDnvs01yzr2Alw
         Fnz6s5ykGIg91a7o9aTDZE75rSR7jSd5QOh35CSc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g=1Cdme_bigvg9JtxREs=e-kkpRo5-7HUuGEiy1bw0gA@mail.gmail.com>
References: <CAJZ5v0g=1Cdme_bigvg9JtxREs=e-kkpRo5-7HUuGEiy1bw0gA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g=1Cdme_bigvg9JtxREs=e-kkpRo5-7HUuGEiy1bw0gA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.1-rc4
X-PR-Tracked-Commit-Id: b59fb7ef5240c301ca8b5b70d4298c0f053bb0c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b512f71221d0bcb07ab32f3e958a84e164c85881
Message-Id: <155442930798.31474.11389041453540921430.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 01:55:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Apr 2019 22:30:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b512f71221d0bcb07ab32f3e958a84e164c85881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
