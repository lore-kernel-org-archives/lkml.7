Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91643C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F25208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897028;
	bh=+HcF83HyyAFRPjqwpy2EhBvlqeA0KqUPLtsH0xY7//o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oBlebvqhCEW6sqbyxZjBjVAcfMhy8QC8d1JaI53VMoKlzu6EzGXm78wVnWG9I7H0D
	 2hYuJNwi0ZMDpRNrlKQ7AgLWdC2Be93lPklecIkpuPiLWQKS7hYER1oS7fMe/8y2IS
	 M2XhYpmMgeUFY+FmceWF8syXFdJmNJDVhbW2MSWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCFSa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfCFSaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:19 -0500
Subject: Re: [GIT PULL 3/6] ARM: SoC driver updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897018;
        bh=+HcF83HyyAFRPjqwpy2EhBvlqeA0KqUPLtsH0xY7//o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K9t/njDxq9zirbltB7dZt9kIwHyDVWqFqqaAwsistK/ij9JplLq3fw9AdWsPzb6Jd
         niYaH1CKtbm0IxaWCw1Slk6KcmUphOBvZJRep/6Fkaqm3Tu482IO8dkBJW8PerOn/G
         XPMl6N9eaJEVKzf59pfsl1Ti875xbn26ouky1oPU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers
X-PR-Tracked-Commit-Id: 8ceb820b69fe6ff58234ff604146a9e88e6c1974
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 384d11fa0e2ca15a3e7e52db34a4e43bedf0dc70
Message-Id: <155189701851.14612.12258987590976845226.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:18 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:34:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/384d11fa0e2ca15a3e7e52db34a4e43bedf0dc70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
