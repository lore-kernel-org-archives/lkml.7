Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC11C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FEA20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897033;
	bh=MM1PlbiBlmQkFFbL3vSyxOkDWuF2vp8WaZdRino7jLs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m4TfmgQ8dHe33StqwjtHrdkp5roS8nO5Ng2Voa9jRXevahnyU5xmZzEuscsm40Xva
	 mA/hRWqZGZWZuXPd3vfWAx+h9Xk1o1W/OfHQ09/lGxDuL2zhnj3gusYViOEI9L6wCb
	 7xB79zJclqiGhK32fji5VXobrxZVv7bWM38jXDvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfCFSac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfCFSaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:19 -0500
Subject: Re: [GIT PULL 4/6] ARM: SoC defconfig updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897019;
        bh=MM1PlbiBlmQkFFbL3vSyxOkDWuF2vp8WaZdRino7jLs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zQR0HuSFUOSAffQ6OFpqeg1wAmuvrJbX2B4bLm5VQQjpE1F3q29iqaqgdoPge8xBn
         +bvbbnL3tOM9MiyhunYDcjcKhZS7DSuuInvO4n7ckgo+X5eJFk4euRCqWvoICOmmL8
         EluizVlyBBDjw31hhA9EdvwjhiBcvP/qHMV4D+VE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1k3y0ZHLxGNBoynF+tpej9PVQUT7PgP1RLCuXWonKmHg@mail.gmail.com>
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a1k3y0ZHLxGNBoynF+tpej9PVQUT7PgP1RLCuXWonKmHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1k3y0ZHLxGNBoynF+tpej9PVQUT7PgP1RLCuXWonKmHg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/armsoc-defconfig
X-PR-Tracked-Commit-Id: 31b0067e8d6d200f5c0a083ca7b3536022243a90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb686ad25be0343a9dab23acff674d0cb84bb516
Message-Id: <155189701928.14612.9186776493630133864.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:19 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:35:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb686ad25be0343a9dab23acff674d0cb84bb516

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
