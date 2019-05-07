Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D475C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D506E208CB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557258912;
	bh=rLgIlP/8Mj6sFqDDwTyarVMcGbDfOIwOHgfHb84yOn0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U3McbFqybVKOvfQWlOAswLGGjNf2YbEKgqjvj/uxIQ3Yp6N5BeC3iXdo7aC4ziJG1
	 qUTd4v2g4AHphA7wTKa9/65Qpch/mrq98CnAX305OVH7WcwiIiazf9UBkZ/LclNN7G
	 iVtlM+ARlxAOx65IV96D0iYWHD0LeLCtlEUVZuWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEGTzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGTzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:10 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258910;
        bh=rLgIlP/8Mj6sFqDDwTyarVMcGbDfOIwOHgfHb84yOn0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KGqxgDXNnMsmbwIjuOBqGlkX0gsKnkkYMDYEPIoFKDHvSwBNWRMv4S09bUrjLBFtn
         FP84gdEe4T91X2tay1pUUAtGij9/A8LMD8tllLrmQ2eDXYxDIcyKjNla3BymHxgcTP
         hvPr4EnXXpe/ioem45OcFfzE2t3sQgZ/sy/rAVyE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1557148716.git.dsterba@suse.com>
References: <cover.1557148716.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1557148716.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-tag
X-PR-Tracked-Commit-Id: b1c16ac978fd40ae636e629bb69a652df7eebdc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f2e3a53f7ec9ef55e9d01bc29a6285d291c151e
Message-Id: <155725891011.4809.15619592822017659104.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:10 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 May 2019 15:31:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f2e3a53f7ec9ef55e9d01bc29a6285d291c151e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
