Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D9EC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB44B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558030833;
	bh=cCta8mspC0x/R1N+ty0X1sDTKU88igEO2QpOpAzg8r8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=et2zZ3EPSJ+k/M2Qk+JbAgARC0qUCG5TX8A03UyjSpWQO6oBx9Vn1mzTilZUE02CY
	 bhuy1jbcmlqxBTeR6iCFAYIwh34WKUwM4H9RYwmOAe9ynyfgJDITOx7i906LNDxHG3
	 MJsluflBcLPi+ygJDKOPgMKU/vCwyFwNJnZMplQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfEPSU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfEPSU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:20:26 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558030826;
        bh=cCta8mspC0x/R1N+ty0X1sDTKU88igEO2QpOpAzg8r8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BbRSaCaCtlNM3WEzWjgVxPLpOFICbKiMve6klUvKjVqRm5frsuboySVTgpp948nW2
         vPYtaZXXBgN4ElIvzAmYZvnwWfAfXegV/JuI7yqeNRi2hllrMS53mYjMnQX61M1OLY
         Rzg+SEj5CX1dRbgj8JOVFRQVa5Qo6o/WCtDKf5YU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516162616.GA15490@gmail.com>
References: <20190516162616.GA15490@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516162616.GA15490@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 9d8d0294e78a164d407133dea05caf4b84247d6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d396360acdf7e57edcd9e2d080343b0353d65d63
Message-Id: <155803082602.23531.11466880363187071734.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 18:20:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 18:26:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d396360acdf7e57edcd9e2d080343b0353d65d63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
