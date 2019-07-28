Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65374C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353B92075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564343420;
	bh=rbnZiVZlX39cLL7ZxLXP/c4nG2+MCbyEEYUp0GqZPz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=omnm2vf0TfxlwRuNhpnHqicpAI1nxiyeJfe/FkoPaRI58GAyHEhVUsIY0fJlrQ0Fy
	 +qdPo48iArvE6+1+HZIAB2+nQv3zGNTQLZ9gy1EHKulLU04bieZWE6YtKrnHVloWHb
	 X6vlUK62GYfW+YlpGW9zYvMC9ZfWOVdtqORk8JHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfG1TuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfG1TuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:50:18 -0400
Subject: Re: [GIT PULL] meminit fix for v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564343417;
        bh=rbnZiVZlX39cLL7ZxLXP/c4nG2+MCbyEEYUp0GqZPz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TNsNtWq4I/aK7n/bx8z3meNQ6U6+tUxj/0vKSnPG1jvaIBGqP0g4iYh8nJ7n7JS9C
         xdAcVUAtJjRCsCvz5gsat7c7Xp99LQktLshyM/FgqBBF6oa8vjwhpwY+t3LCty47gB
         N0P9VFKSvFi+PBHJ78ae+iaQYb3tRoUnNv5+2mfI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201907281218.F6D2C2DD@keescook>
References: <201907281218.F6D2C2DD@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201907281218.F6D2C2DD@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/meminit-v5.3-rc2
X-PR-Tracked-Commit-Id: 173e6ee21e2b3f477f07548a79c43b8d9cfbb37d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c622fc5f54cb0c7ea2e6fedba27ba533b97657d8
Message-Id: <156434341718.3105.18443731846830184351.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 19:50:17 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jul 2019 12:21:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/meminit-v5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c622fc5f54cb0c7ea2e6fedba27ba533b97657d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
