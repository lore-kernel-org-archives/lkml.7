Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CCC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B773208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557789013;
	bh=+sDKpD9WqjkSOWrTGfPkry5NiPwppYaa3vRv9gSr+20=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=al3HZ0bySZQjm73UqTlVmpmxV5pt8Mp/S9+XDRJfhrX/QcqlysNaNxMbX0VlQnwSP
	 x3tmxRQ1w2MmCmLI+ZPAeD7/s6JpAaEr9WSQddvie4QTD2P/OyxrHr040TuTL+MP1J
	 AgWc63WEjBMVBcqUbhgs+pMjcmx7g0JtxX5ZPU/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEMXKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfEMXKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:10:12 -0400
Subject: Re: [GIT PULL] gcc-plugins fixes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557789011;
        bh=+sDKpD9WqjkSOWrTGfPkry5NiPwppYaa3vRv9gSr+20=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WiCNoNfcVh8gZxlikqN9sDbL1q1VfGYqrpO0WVIOBIEfj3oh7WMxPW5Q/F5iIMB28
         +Gi3UazqA87U6A8cbCL/eYp2jTxfZYFSqphjiQvFFhPUpHwjTOUk5LcP9nfKn3AgmT
         r884njmAlbHoHCx4RPtncJ9/m+wKROQR6zCxXuIc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201905131404.7A6A4B8FCA@keescook>
References: <201905131404.7A6A4B8FCA@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201905131404.7A6A4B8FCA@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.2-rc1
X-PR-Tracked-Commit-Id: 259799ea5a9aa099a267f3b99e1f7078bbaf5c5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63863ee8e2f6f6ae47be3dff4af2f2806f5ca2dd
Message-Id: <155778901175.19125.2141919100562912797.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 23:10:11 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Douglas Anderson <dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 14:05:25 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63863ee8e2f6f6ae47be3dff4af2f2806f5ca2dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
