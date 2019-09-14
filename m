Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A65BC4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F683206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568503526;
	bh=zN3AiQcN4OyiNPGhUtI2YBjvp2tsF6+c4sX8WDAP87o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yMUWI8nXqBQ4W/6WkUo1rIFDJg/NSzCo1+ZzqYM4uKgEk8nDcb0+iL7xcDv/SIcVl
	 2t039qgqZ10ucMlNsiCyAZqCESKjvl1Xi+9EyNaglzjL5z7Wk8Z7l3rXbxNLSm6tDi
	 nbmtJyH+Rkbf4tqKD/Stn4W+7n6V+OJ7RFNQQZuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfINXZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 19:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfINXZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 19:25:06 -0400
Subject: Re: [GIT PULL] Urgent RISC-V fix for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568503506;
        bh=zN3AiQcN4OyiNPGhUtI2YBjvp2tsF6+c4sX8WDAP87o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FgMzG401RLitCgZXMvXvc1xiSlLn4yaOOxbIvc+qJa3Gtpm8me5fPcEB+zyBlvWVS
         JkhZVCuipJELlCGbs8XzdMvUZO74w7a8t+8EE8QzFyRIW91oC5XlSL6z8bWnFchD5K
         PTPPt3S/D6ACZwcKGWdbHfaonECCHDrYx5Ct1qiM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1909140651430.10284@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1909140651430.10284@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1909140651430.10284@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.3
X-PR-Tracked-Commit-Id: 474efecb65dceb15f793b6e2f2b226e952f0f8e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b03c036e6f96340dd311817c7b964dad183c4141
Message-Id: <156850350617.2116.314351951829278963.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Sep 2019 23:25:06 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, palmer@sifive.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Sep 2019 06:52:48 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b03c036e6f96340dd311817c7b964dad183c4141

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
