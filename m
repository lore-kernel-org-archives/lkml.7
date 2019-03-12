Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1567C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB70214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552354817;
	bh=kYR7wRuBi3ZdAL1WDSF1UdBZPbzu6J3OurADWBurCH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2buRt76wbFdl+XInZkO+vWfknek0ILFAH2MQbH1ZBIiZ/4l85Amd13HRFPZa161Rb
	 4UKNAK12E4UExnlyRRTMJnsR8Jss8q6V6+lRzLWQAFZo6fl4r8Lg489EuGJ0klVMdb
	 yldrIdgmFjFOga8VxGo5DPrBoN8tmDB0wmXBro2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfCLBkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfCLBkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:40:15 -0400
Subject: Re: [git pull] m68knommu fix for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552354815;
        bh=kYR7wRuBi3ZdAL1WDSF1UdBZPbzu6J3OurADWBurCH0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZYzxRpSv83qssk+j14Dq5NBKHpLelGIMZZf4qWt2pxAT4WHQFZhaWmbOfiKCIvsGx
         ti7VUwDGoyj/8p0b0PTSYHmsusq8G+CP3Kv1TSWUJaNLnCWxkYn8wNz5gwQkdU07YM
         VDIJB44usEO2tdB2uzRg1T9IPQwpA0iOt9AG24Rs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c2d18bdf-e9ed-6c43-57ea-695b82417530@linux-m68k.org>
References: <c2d18bdf-e9ed-6c43-57ea-695b82417530@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c2d18bdf-e9ed-6c43-57ea-695b82417530@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
X-PR-Tracked-Commit-Id: d7e9d01ac2920959b474c6363dba269a868f4db9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3124ccf025caf25b764d900d1f9c49731673e49
Message-Id: <155235481501.20947.14003435778204488682.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 01:40:15 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Mar 2019 10:25:31 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3124ccf025caf25b764d900d1f9c49731673e49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
