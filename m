Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D20CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAB12082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574734508;
	bh=Yg5y6XK5exzyqkIXwlNbhLwM9M2YtuNymQUC03+OnUE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yWcx4dngl+Qt61EiIVlEVxmE3mmnRJzXeNT8bnd22o9tkXvBmXZ5t45q3vOLJTpMI
	 6+wp/oAduNsvX3r2Ize1N385ojrzia36ytIo01kRNMEUgroCsuLN+EeUApAw5Hwp3L
	 2cXqwOplxWvsxe5k3kujpuO3nfBfkGPwqpLfGBAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKZCPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfKZCPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:06 -0500
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.5.rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734505;
        bh=Yg5y6XK5exzyqkIXwlNbhLwM9M2YtuNymQUC03+OnUE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xd2xeDfQoq5O+JD9snhyHupb1RDIRjdtKzLw/ZSEDp6s64Anur1qE8mTd4dP18O0z
         OWfm8/N72trUrRpSoXM+l3FaE2hVEIkIOdI9KG++6BaNxqan34TfSf1uXvgxsnKqMn
         iei0WdVnF3gH+yCQoTpEmyGvNHtAFhbNhONLhOD8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ab38f85c-cd96-d79a-b359-32d599203c25@linuxfoundation.org>
References: <ab38f85c-cd96-d79a-b359-32d599203c25@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab38f85c-cd96-d79a-b359-32d599203c25@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.5-rc1-fixes
X-PR-Tracked-Commit-Id: ed2d8fa734e7759ac3788a19f308d3243d0eb164
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db7d275415d774de3d2151d6885bf61c33243419
Message-Id: <157473450562.11733.13735431578713069444.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:05 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 12:41:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.5-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db7d275415d774de3d2151d6885bf61c33243419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
