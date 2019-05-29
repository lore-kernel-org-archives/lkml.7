Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725AFC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473F92423A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559166329;
	bh=naStjqJwtWTMpk32IpOt/AJI3VZxuDjdkasrbDbHYU4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Fp4Ur0y7DSzYA5LhNFAzoBgrMc8A4nxTGKBuXDawiZSUuYHZ8HeLMk/kvztaHWy6i
	 1uDFipnmvjC7am/cGONly8UMYa+hIR3ujMLDnXl6AH2wFRoPZyX/KvJmjUQuy0E9J2
	 Y/HZlpqTRbPh/S9H6vQhet9Fgqpfur3rFJdpZcn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE2Vp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfE2VpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:45:15 -0400
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559166314;
        bh=naStjqJwtWTMpk32IpOt/AJI3VZxuDjdkasrbDbHYU4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aFRRmVHUoQ/4aKhYxob6qbXUsz4Lb5Lwf/7yK3WTMKsjEJnkGL9cp0Uwx8Yjukae5
         vGmFFRj7Uh97NupY8oqq0hxCp+SY40/z1PSEI9/7jQQw4YvIefSGoNrsw4cM2yAi6n
         DSRIclkoLmyrZsTw1uOiCu8qt4TidkVZVxSAPNXc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <966d12fc-d32e-c72c-7996-34b8250388dc@linuxfoundation.org>
References: <966d12fc-d32e-c72c-7996-34b8250388dc@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <966d12fc-d32e-c72c-7996-34b8250388dc@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.2-rc3
X-PR-Tracked-Commit-Id: eff82a263b5cfa3427fd9dbfedd96da94fdc9f19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b28601d62b01429d12e999fe3712aaf57ca2e26
Message-Id: <155916631475.28954.6802854701124316796.pr-tracker-bot@kernel.org>
Date:   Wed, 29 May 2019 21:45:14 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 May 2019 09:04:42 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b28601d62b01429d12e999fe3712aaf57ca2e26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
