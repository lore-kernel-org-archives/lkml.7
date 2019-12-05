Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C2FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D0024671
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575578741;
	bh=4PwQH4H/YtEqPmLpUS3xk4NWALPxDy7UVP2naXYXj3g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JauX2DXdqL2n3My+bOYMAt1lr9QeYrjpBE19lpFXGVbMC8Swu7lCpf5LA7WB/mKdZ
	 J/PeXz7h6E1l7zn2117pVNm2zyaewW0VCEFnHEIWirqNM/GUyOloGKOFEiMBCETnRt
	 +RXQcNDDeY471HgphrtufwI6CIRjjG2c3BGFpsh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfLEUpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730206AbfLEUpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:36 -0500
Subject: Re: [GIT PULL] Modules updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578735;
        bh=4PwQH4H/YtEqPmLpUS3xk4NWALPxDy7UVP2naXYXj3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oerrm3K5mjnz/2cZAjKtxhAHhDcWzhqIm/mIokk+LCmFI0XAR7LDQOELvS1GilwCB
         3HyrbGytnbBA5UwUurJLZZYWrO3sBKL79HBUYNBF27TbkqaQNOiXaZgFWkRbJTc/BF
         41+Kr5bExQexw1FPp/NGYuOl52k9T/ooIvskdQ4Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205200945.GA1750@linux-8ccs>
References: <20191205200945.GA1750@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205200945.GA1750@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.5
X-PR-Tracked-Commit-Id: 5d603311615f612320bb77bd2a82553ef1ced5b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f137416247fe92c0779a9ab49e912a7006869e8
Message-Id: <157557873592.26858.2254245864922941283.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:35 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Dec 2019 21:09:45 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f137416247fe92c0779a9ab49e912a7006869e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
