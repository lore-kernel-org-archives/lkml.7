Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882E1C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65197216B7
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564335023;
	bh=/YkFdD0soKHMiLm11rubIJfNZZQmKPy402JozfyqE0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lEBFkvYOrRvFncXFvwe0kGFFk6tf7VPfRcaGuKIOdOOV6wiUONR7NDSHUy2wyWWdP
	 17cbdx4fxm1i//Rr0CUBZwEQNYjyU41ohGW0aHDwmQ6KHjpwWBvzqzmtugQeN/YjP+
	 hxHxUyhHfqWipI+XWwsGoaCLyD6Cp1mHYsk+dT7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfG1RaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfG1RaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:30:19 -0400
Subject: Re: [GIT PULL] SPDX fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564335019;
        bh=/YkFdD0soKHMiLm11rubIJfNZZQmKPy402JozfyqE0o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yyanB3g72HnDA6gzPOp0NLjtt2aH9MAOvkkXtRJMZ8ONNhHPyo/w0sh8phn+jz/tD
         yrxd3gtsavC+wLgkRSb0OowTo4mYTqpkyXhmrl+1blhMwIQkji3wFJRZuWa9ScXByY
         ZaerkPTaVvJSFZYcZDC6lCp93mW1PJ4VTBVou2AQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190728120102.GA16018@kroah.com>
References: <20190728120102.GA16018@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190728120102.GA16018@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
 tags/spdx-5.3-rc2
X-PR-Tracked-Commit-Id: 0ce38c5f929c83dff8ea805f6c6ef2eb97b66431
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad28fd1cb2bd7d67f9240f596ea4740c95545fdf
Message-Id: <156433501951.9558.9975876246508481211.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 17:30:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jul 2019 14:01:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad28fd1cb2bd7d67f9240f596ea4740c95545fdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
