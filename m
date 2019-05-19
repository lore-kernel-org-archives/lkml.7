Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB8FC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2CF2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558287921;
	bh=p39cSE+YEWhDHipYq4l9ZwR+n0AoruN4qVTWJAWJBQs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sF8sOEnm454hMOLGZa9zE0kuOsH4z3BgFb8sfHe3XbVxsl7I4P3TpihOmD/M42Ze/
	 FCB7tybciihaNVBdHZL2G8+QEWsUxma5T2CAXCOqOB0SRJzJ4TN8ih5dFZOj0az4z2
	 o8R0IbAhTsoYn+sRG282l4l+E7mHeO/9ECyBScwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfESRpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfESRpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:45:20 -0400
Subject: Re: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1 v3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558287919;
        bh=p39cSE+YEWhDHipYq4l9ZwR+n0AoruN4qVTWJAWJBQs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g/N50TXJro8HgipULDBQ0NRm6iWMMBeUcu0xAdPvcDyuyf5IvpXumGiVkSVOtTgN3
         jfVLkpkoZt/HujSErPZRON8IcSnrqFQ9tHIhxbfG/gLESnr3vF3rSDxa6+7MZkLFie
         uECoogAOSAfEOIHnIN52UoKAI1H/UIvKCKnn8lSs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-2cfcab49-74d1-4656-9913-36853a5be29d@palmer-si-x1e>
References: <mhng-2cfcab49-74d1-4656-9913-36853a5be29d@palmer-si-x1e>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-2cfcab49-74d1-4656-9913-36853a5be29d@palmer-si-x1e>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
 tags/riscv-for-linus-5.2-mw2
X-PR-Tracked-Commit-Id: 8fef9900d43feb9d5017c72840966733085e3e82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0bb1269b9788a35af68587505d8df90498df75f
Message-Id: <155828791965.9186.7458955761237233525.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 17:45:19 +0000
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 15:54:33 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.2-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0bb1269b9788a35af68587505d8df90498df75f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
