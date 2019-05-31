Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C1226D65
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559325016;
	bh=Upw0bSe04yZ+hesGmaVG1df5ZyXOAOkYgiv7+SHJs+E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d12NxmZMKHLtzdGV06FJBdXzH05crPWz26kc/wmMMQCMHyyQbMRqgdcAaC5BWluV2
	 S+Eyh97g/RBwcQqm8PGdTWLo1pkIpS46iJca+M7k0PdwvRi05cFmK8rsM1Cmqt9T5n
	 s8ZJC3SSX81WyK9j0Ayu7Jl2EsgmdxUeGOi+YEsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfEaRuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfEaRuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:50:14 -0400
Subject: Re: [GIT PULL] gcc-plugins update for v5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559325014;
        bh=Upw0bSe04yZ+hesGmaVG1df5ZyXOAOkYgiv7+SHJs+E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qj1BtQ5c4pfeD1XBzT47o2+uAJUh1Xz6ouvkmzoq4Ka4KMQJ++xr1pS52xowQqvox
         L0xq83AyT0lXl7kryM99NTjjuUAa0VCHg5zKVbDcXz1TobOKzU42XlDyk5qOr+oH/E
         FGYr7HyOsMbTA0dBXRlTbA0tp6BAT7e69ImON6JA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201905301916.79D7BF6AB8@keescook>
References: <201905301916.79D7BF6AB8@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201905301916.79D7BF6AB8@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.2-rc3
X-PR-Tracked-Commit-Id: 7210e060155b9cf557fb13128353c3e494fa5ed3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72cea7ac5f14ee25cb96c7863a05223ba5a2c9a9
Message-Id: <155932501414.32255.5273588884121822421.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 17:50:14 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 19:18:00 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72cea7ac5f14ee25cb96c7863a05223ba5a2c9a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
