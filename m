Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F677C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE6A2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048039;
	bh=uB9btGFvU3ST9i2bbbYXjKVqVCPXlrZ2oc7qL4xnSxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZShqvGFQDkkUn9OV1HbMNLKnfhiy7WgjodPu5jd9IRw5J3PwC0ZJTat06cNjfyqS2
	 7gKb6Bv2Hk1rFLjWhfgX5V7GeUyJ33Tc2x/jN/FXAM4UJ8tBwDPnmvXGysitKFFpZd
	 vjKsTHY00FCx0blTcnJemEaYXAzKrYgIHFOy8yk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfCaQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731379AbfCaQAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:13 -0400
Subject: Re: [GIT pull] perf updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048013;
        bh=uB9btGFvU3ST9i2bbbYXjKVqVCPXlrZ2oc7qL4xnSxQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r7qRqhpERDpXvtyBC85wlXirt326935NgyWQI1OOJf0o1Ru+Swker4GOaO2pHhq0G
         hQfsR6auTO1ocACioV/X3WBgqXOCdUYCvqnU74/HWngN9vCfDyY5Wbd31XQwG5w7mo
         tMtxiXDQu2pWIvvh/okdS3j6iYxRF2d04orI9T/Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155402878327.25983.14339659161296384728.tglx@nanos.tec.linutronix.de>
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
 <155402878327.25983.14339659161296384728.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155402878327.25983.14339659161296384728.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 22261fdf68f23df3ddf359642696d6ce98e584fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 590627f755bc385bd2b2fbd87de312a462889222
Message-Id: <155404801315.15219.13151055641259813803.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 10:39:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/590627f755bc385bd2b2fbd87de312a462889222

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
