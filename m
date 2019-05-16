Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BABC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B90020645
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558024829;
	bh=HSbXc+dslqbRehQvNmd6HvHCAtZzf9jaMx5NK/KADaE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Mi1C/oSI+byAgmoraugDN4E/oW/01nj8Ykvb4yzNysWulv882wcUv8osqCYbqJInd
	 HauNr3DbsX14F2oqXJiWFxzHmm5YsqhmMIzy53NEE29I75aPmLMvXlFICGmesWUPNI
	 R8ocqfQ5r87yw9MUy11TWJKUHRGBj1/KBPuSS14c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfEPQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfEPQkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:40:24 -0400
Subject: Re: [GIT PULL 4/4] ARM: SoC defconfig updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558024824;
        bh=HSbXc+dslqbRehQvNmd6HvHCAtZzf9jaMx5NK/KADaE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wBswkt7Neh0jKdBkv9e7AMTs9m9373qrNw7FMNEJtwy3cfG02kKgVx/hMFyzIJ2+1
         EJ2878m7YaxNyl8qVLS0evKn5DTjO2bCP5mxWvNuL2HFdk411aDmYQUM9B3h19V+AU
         rxEcC9etJlQ2Mgi3dzDAhu8QHo7+pnMibZNICbLI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516064304.24057-5-olof@lixom.net>
References: <20190516064304.24057-1-olof@lixom.net>
 <20190516064304.24057-5-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516064304.24057-5-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/armsoc-defconfig
X-PR-Tracked-Commit-Id: 85200317b324924be3bc72b7bfcce219020ced9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab02888e39212af2d1dddc565cd67192548b9fd8
Message-Id: <155802482418.32664.15280046775737034960.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 16:40:24 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 23:43:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab02888e39212af2d1dddc565cd67192548b9fd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
