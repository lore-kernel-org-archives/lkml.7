Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA4C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F31321734
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897067;
	bh=sdVsdakRZJ47tLGzzcp9BOSz9PA3bKpu3fgWupPhjmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wTAZn0pqWq01vIwgcj7JaYDHiDYBfQbWgUqySoSKadv/fIiIzHUAOXUCeWzel5qz4
	 UPStkSTxKyNSO58CePxU3OpRrFdn2NvtDkgBfl6QcWc7cR3+6NlxJ9/W2gFtSXBBfD
	 R27X2XrORnPiCjZXKI5zgraF1ApXEWY9o1XsMk3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCFSaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbfCFSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:18 -0500
Subject: Re: [GIT PULL 2/6] ARM: SoC device tree updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897017;
        bh=sdVsdakRZJ47tLGzzcp9BOSz9PA3bKpu3fgWupPhjmU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cuu6N+P5YrHhuYdJE6dmE9ZLELJEHImJpKgIxlt1CrqUREoIyAKP/5mblIzMZgwJe
         NOs0TsyzwcZ72qTPYqyE9O8tYaH1f9RwcH866TnwVVLy334lPNBS5yRs8L6/L97m2Z
         fRMJcBI8MJiK4LJ/jG3UadpVMcFniYtPictLJPhA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a08Rxm_52q2xPvszukYGzbSEA0WypHjxCi9hXvLXNd41g@mail.gmail.com>
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a08Rxm_52q2xPvszukYGzbSEA0WypHjxCi9hXvLXNd41g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a08Rxm_52q2xPvszukYGzbSEA0WypHjxCi9hXvLXNd41g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt
X-PR-Tracked-Commit-Id: a3238924a820c1d7c977b632b769f3b5690cba09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ad63dec9c2c80710896edd1996e56c54a230870
Message-Id: <155189701777.14612.2324375283662876460.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:17 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:33:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ad63dec9c2c80710896edd1996e56c54a230870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
