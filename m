Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7F7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976BF2182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563382223;
	bh=BNU7nBW9Ix6ttu9a1iqtFkvarTUm3bOUxNU1/pfnUkQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1Y0izQdWs5SaZ2cjcYx8T0FGnWsduNxpq3mEiNqvnXF4GkZEsZePv+IYsFgKJzFf3
	 Z2lr9szuX/7Iocw57QcAgb2V4urPYk5a4VBdldozF3SsMRBxjZvAPRU6ZdUm2EH9LM
	 DaLN6aWGqzyK34z3drrCMmD785ADxiZIeorIq89Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfGQQuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729765AbfGQQuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:50:19 -0400
Subject: Re: [GIT PULL] MIPS changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563382219;
        bh=BNU7nBW9Ix6ttu9a1iqtFkvarTUm3bOUxNU1/pfnUkQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s5yp5s5tXLrZOvK21lppHFc0T8IsoPCDvoSkZcY4VZfMlgcJFwr74g5pCOgVc6f/C
         gsTFe6txNKnLUfY9+DWqrnQNPw5kzD+azxYK6RP0TPGCkZwe0oPhA2I50AhuYcybGM
         xvP67Ow65b+3sGX6Nb+rs2BTC+NRIyvSmsoGPRs4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190717152545.bhdnhjdf2tlhuv3o@pburton-laptop>
References: <20190717152545.bhdnhjdf2tlhuv3o@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190717152545.bhdnhjdf2tlhuv3o@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.3
X-PR-Tracked-Commit-Id: e5793cd1b5fedb39337cfa62251a25030f526e56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa121bb3fed6313b1f0af23952301e06cf6d32ed
Message-Id: <156338221916.6265.9350078517015520928.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 16:50:19 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 15:25:47 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa121bb3fed6313b1f0af23952301e06cf6d32ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
