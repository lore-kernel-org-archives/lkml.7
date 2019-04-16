Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E29C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CBA20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555450207;
	bh=RzVuj6aVU6nIuQwLZh+nxY08N3wUD985RYt5zBJKFWw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=I81s9YJ7yezOvhHVdTq1abavKeKRWpi2EoLMjq+Ld3x2YW+jogyZV8Fwp0d/NbwBM
	 tcGMOiwLT1ZVtX43qO6R7hUvQThqX+SYJK+RWl8Zby3x3BaTWRP7HJzHcPdIyj93rG
	 vtlDkbixAsCKUOFc7uHu+KEnyHB9SkJG1+u8Gb/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfDPVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPVaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:30:05 -0400
Subject: Re: [GIT PULL] RISC-V Patches for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555450205;
        bh=RzVuj6aVU6nIuQwLZh+nxY08N3wUD985RYt5zBJKFWw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uYb0tWEiEcdVr2HZjFzSyOEmqJW7m5843OJR8aou7IlcQGBtBjW+vYVQqDx3i5p4h
         kHeqE4Jc9AWAJxsqTQRm1jDGGu2y0jQXi6AeYRtd7kME4NIBkll2n6eEVVIg0GmctI
         8tjJbxjeCQSAYoEBQwrRse9jZf10pa6+Il+IS6hk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-c5019c5a-5f6a-43a2-b376-6a29a824e260@palmer-si-x1c4>
References: <mhng-c5019c5a-5f6a-43a2-b376-6a29a824e260@palmer-si-x1c4>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-c5019c5a-5f6a-43a2-b376-6a29a824e260@palmer-si-x1c4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
 tags/riscv-for-linus-5.1-rc6
X-PR-Tracked-Commit-Id: f05badde4e20d2e0f8c39d07a6873b2bfb0754f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 444fe991353987c1c9bc5ab1f903d01f1b4ad415
Message-Id: <155545020503.4861.16520339466805222893.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Apr 2019 21:30:05 +0000
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Apr 2019 10:24:46 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/444fe991353987c1c9bc5ab1f903d01f1b4ad415

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
