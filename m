Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF3208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251707;
	bh=Y1b8xY0c/spqs+BJnAyAoYQDlLG6WCWT2jxAwob5C8k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iari6ek9J6s2rfOxUR6qQ5uHy2G4eGXGh8fEyA3bBcPhWycEtV7sf1uqcEyI4K4tI
	 ujjlNMU+D5qMPB776fIALokonUTLIKXDXEQG1S2DCxAN24QnxNAKAGt1D54MkG9pbt
	 aFkf5qIk5rBUvylV7deS+C5HZFMVJPgBgjb5oGaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfEGRzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfEGRzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:55:04 -0400
Subject: Re: [GIT PULL] x86 FPU changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557251704;
        bh=Y1b8xY0c/spqs+BJnAyAoYQDlLG6WCWT2jxAwob5C8k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NO6i/lJR5Z+qYObb1lzqrRa20psJ1RWpUTPcMWbMmsOL4upbFvUze3wYoIH0hHr/s
         i4S5YnDsu7g6liCC/sUpRjNANKiCIgg2Q5a3svPFjPkE+q/MJ8e5bHxAgCJE41QPcT
         Y+eeILLu+cAKOvNnsdNajLOcL3oo+zDltYzLxNSs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507132632.GB26655@zn.tnic>
References: <20190507132632.GB26655@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507132632.GB26655@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: d9c9ce34ed5c892323cbf5b4f9a4c498e036316a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ff468c29e9a9c3afe9152c10c7b141343270bf3
Message-Id: <155725170435.24816.11533088367798432294.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:55:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 15:26:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ff468c29e9a9c3afe9152c10c7b141343270bf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
