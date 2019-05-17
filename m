Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41498C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136D5204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558059926;
	bh=5LVb/Trl5R8hUDFGLByVNXODThqTgA+K4gqqZ6y8gTM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MaO3UWLlskww1nJ1Z/jJRzmz6FT0xkEJYQU9p9S/V7j6cgAX7pJy3/QipDH4a6LQY
	 sKECOU1YgAjmjSxVOwGw7f1R6Z2xoBzKbHw059RXZK6LXFj9l6p6PYH+g7QOTtkk7J
	 ddxCaOMdqOJbyOlNnEbWfVUahMxLIYyFclK7xLG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfEQCZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfEQCZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:25:22 -0400
Subject: Re: [GIT PULL] Kselftest second update for Linux 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558059922;
        bh=5LVb/Trl5R8hUDFGLByVNXODThqTgA+K4gqqZ6y8gTM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WtM5A2oXSyu4SOCL8tOCwllS/LUrUiXEqCoGL8ibTj0c2DVU29fQYTCbaXadF17MC
         Lwg6yruPPwyK8G1lOzROKrkq3hqyhayCEIlglERgelZbbFrcLAmmgWiu8eAg5WInTH
         yILY6B0Rt5cOIU8GcKoNgjLBXZrSh0HY9lqf5UeA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7af4f05b-abec-8d5b-3b99-a1eb12fd4a67@linuxfoundation.org>
References: <7af4f05b-abec-8d5b-3b99-a1eb12fd4a67@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7af4f05b-abec-8d5b-3b99-a1eb12fd4a67@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.2-rc1-2
X-PR-Tracked-Commit-Id: 61c2018c0743fe0c9ca68e308b5727b8a7c3d544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c7b63a32d54850a31a00f22131db417face70e4
Message-Id: <155805992221.6110.10769982533209572165.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 02:25:22 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, skhan@linuxfoundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 15:52:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c7b63a32d54850a31a00f22131db417face70e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
