Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AD62087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897014;
	bh=9AWsIGDpXU8Ck5RMseGE0bg5dHJZyAVM72Cq0qMyudg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1hTdXkyzZupVFwKalcjekn/ASYKf127JBd+MvaYhiS6wUZ5ujfAK7s30IGCSUjDtq
	 yHiB/ujaN40IXMQZ4PMwAjbaLtoiJDJSKYIQZSX12Zm604JM6Mdw475NSLC9UDkvdb
	 CLxlySBs0C9W+C5vMJb1BIyy9N/UJW8XLaOf0D+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfCFSaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfCFSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:12 -0500
Subject: Re: [GIT PULL] EFI changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897011;
        bh=9AWsIGDpXU8Ck5RMseGE0bg5dHJZyAVM72Cq0qMyudg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mJbegXRpAJKIaOCwobFuGcvkVX8JejCUCoOUkZhzxZpdlvwcwsf7rnCyqPGj9ncHe
         y3pvJEcSr7/PtQ1pJXWJFafZRwL7+3RWMSQkdKJCS92mXO8Ia2cVN4PbjGwN0Fe61G
         jwe4vPg75qmiIyKyf545dIaoiK3hgC0yv4a7cJ9w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305122038.GA2472@gmail.com>
References: <20190305122038.GA2472@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305122038.GA2472@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
X-PR-Tracked-Commit-Id: 5c418dc789a3898717ebf2caa5716ba91a7150b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8f5ed6ef972ed4fd10b0c2e2baec3b6803d3c73
Message-Id: <155189701154.14612.16713548884736621197.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 13:20:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8f5ed6ef972ed4fd10b0c2e2baec3b6803d3c73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
