Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FA020740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573839313;
	bh=yb+p8AukHHEeYK0fFoJRlqO+FcytnsIIcby/a1z4TKY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aNJZasBdGUWPJ2jzZcv7BWALSMmdvMY4+WqWuYxvvHL/QVZDspZtIEPJT+cgJMH7U
	 W965StBDMi5kY7xeHmCWXwUKsupclipMGGAcW661/JzwNdf4khCDzkEV7t/FlfVlUn
	 uxrq+uVjSaEqZPvkktSJPqicM8OIXSrPjgoCThXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfKORfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfKORfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:35:07 -0500
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573839306;
        bh=yb+p8AukHHEeYK0fFoJRlqO+FcytnsIIcby/a1z4TKY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I1s+MoyZcQhJzbBiaUsmQfsUqArF2z9+WNP7lWf0CxHDQPfe3pCk4WffsrBbirKx3
         HUKCTcukOemId2mAYvglqhDLkKtxtfafaI+iW7KjX2dkHjYGvPtR3cvZJOEeNdk3yo
         wXQ4nVtlUDcnRhFOffjgJCd0fGQehu/plLg49Nv4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191115050453.zcgijwj7qt7uvx2c@pburton-laptop>
References: <20191115050453.zcgijwj7qt7uvx2c@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191115050453.zcgijwj7qt7uvx2c@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.4_4
X-PR-Tracked-Commit-Id: f6929c92e283a35b183c293574adcbca409bf144
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34b38f5abd1f0793e75cc97c4781d04b6c7f4d9e
Message-Id: <157383930688.31249.15811969390125666464.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Nov 2019 17:35:06 +0000
To:     Paul Burton <paulburton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Nov 2019 21:04:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.4_4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34b38f5abd1f0793e75cc97c4781d04b6c7f4d9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
