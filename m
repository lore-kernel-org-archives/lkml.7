Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DCAC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFCA21773
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565368515;
	bh=9G0aXhvJqY5xiPO9mT5KoZGhNeafvb1dvF8/rxhngCE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=STMQuIIrjYitikT4mDlxOnudJ7uXIKyVKkyYY89lTKBRHbD4WT3Sgr7PlaJ2hYwQ5
	 KqM+CQXkB+7ZcPtpZSgppNsPaI5u5TBKId6HUUbaCWIrOpnGZA0FZnTVTOmoGNgrsa
	 c7cW1yvEiB3YVwnxqvDOK7vrP09Wn4xytG53cTVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437364AbfHIQfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437328AbfHIQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:10 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368509;
        bh=9G0aXhvJqY5xiPO9mT5KoZGhNeafvb1dvF8/rxhngCE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DulcdwuhINLZ5ukHkar5ac80wg2J+6VL8YcglX2yRfvXZzvuujAWsYySTsPJrp3oE
         vgJcMu2//+calfTSzed+G2tHslfZkhFswLCoaMuy/dSLGjG+8UFyw+QYcx+Whv5THp
         vhEfY6ZMMr3I55spGWzkXYGdjW/rLLVkRWfKRBAM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190809100149.7027-1-ulf.hansson@linaro.org>
References: <20190809100149.7027-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190809100149.7027-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc3
X-PR-Tracked-Commit-Id: b803974a86039913d5280add083d730b2b9ed8ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 461d2815ac9ec1b3f66fc243cc39bd2374facafa
Message-Id: <156536850939.6429.15936631477318963292.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:09 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  9 Aug 2019 12:01:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/461d2815ac9ec1b3f66fc243cc39bd2374facafa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
