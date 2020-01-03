Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE235C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE73222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578014707;
	bh=zNbPi2PuJbBdVAveB7KK4k7YCBbzBzu4nIE5X20EKH4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=npMs4I/EPwnR1fes8hyw9ThlR6yNBhYDTMzvHZ2Ijizt2mM5T+gvmmseP7t/oy88V
	 AJ5fKO98xbcuekK+/FJe93SQBEEnV942DeJkkRmJTyaQbEdgB0MP88rwaxTXwly9nU
	 JvcTZ6ULlgSvGlVrJZCRibhTiSzL94JRwtH6/Qb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgACBZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgACBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Subject: Re: [GIT PULL] seccomp fixes for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578014705;
        bh=zNbPi2PuJbBdVAveB7KK4k7YCBbzBzu4nIE5X20EKH4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2SUIR9KChgcx61tbpf3VNeeqLFb82QvczBL8nTCcL7bkoqSuon9N1hAo3NA9Xa1aX
         vQkNnBycmmUGDqNLq7ZJDi8DXqZEmvl0ey6PPJP9Pa5sNuvya/7Nxrs+NyD6zfKFG6
         p4we30P448xwIXGQ2nI/dJ2K+UQyP3uZ+UC06wvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202001021325.8D02D326B2@keescook>
References: <202001021325.8D02D326B2@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202001021325.8D02D326B2@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/seccomp-v5.5-rc5
X-PR-Tracked-Commit-Id: e4ab5ccc357b978999328fadae164e098c26fa40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf6dd9a58ebaba2608d2aebd2a7a704014121f16
Message-Id: <157801470566.30243.18378798403018784687.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 01:25:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jan 2020 13:28:30 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf6dd9a58ebaba2608d2aebd2a7a704014121f16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
