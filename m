Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628BCC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A63206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573421710;
	bh=8aVicyz4gI+/WbuXxzRSFdIX9oSRVc4kFkhWPnZEBjQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D8oW/sQTmwkRF4sngMALcIPc1A6Qf8mKm+1XxbNCCp93n1HGJJAupzPyI/x1J2L0H
	 a8AiRZJ6aM4GgJQ0KTw+fiT/L9k/SJPJJeUs3/T67+R/H43Me7yS13kt+/FRzWNIEZ
	 b22fqqwuM/04ZxWlScF6WHsJ3gFnv5dAxSMuSV1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfKJVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfKJVfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:35:07 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573421707;
        bh=8aVicyz4gI+/WbuXxzRSFdIX9oSRVc4kFkhWPnZEBjQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mv6U3jc2HN3Hl9ynwB+CxT0oXjBdbtavYUMs/+mBKrTWdRN8hdbOaQLQglYi9w3kV
         /Ty+DO31eluw3n85QZqn0cbqZjk1+a9OAqY+zsW6GJmXQWS4QsUenbnLg/ROQJ4pkT
         kOinJkPZhSexoBno5wZ7gaeSZp5m58vuPU5k4NkI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191110154228.GA2867363@kroah.com>
References: <20191110154228.GA2867363@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191110154228.GA2867363@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.4-rc7
X-PR-Tracked-Commit-Id: 9d55499d8da49e9261e95a490f3fda41d955f505
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3de2a3e93700eb5df2abfe8b7ca9d5c813381a4e
Message-Id: <157342170732.28901.3630821457991676938.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:35:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 16:42:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3de2a3e93700eb5df2abfe8b7ca9d5c813381a4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
