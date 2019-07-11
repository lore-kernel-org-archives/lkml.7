Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A35C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492132166E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562884210;
	bh=azM/iQw6mFyNziY4O9DT+9lgfZilCxsmxvNVyQtdPDw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xGuGPko4ngRGgBsVOo418NZ6uVv2gFDMFKHCQ6rjbZXn72xZXgC+cK+t8QnSu7fId
	 Dl39pqPBwiffnSycDPkz4t1zow6unnK1FqtgTy9zjnGPY2HL0GaL44rwbQYFB1j7Mt
	 SS1nXgt2fja+0kUTXlpXBf1R+Z5Tr1KkKDKd39sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfGKWaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfGKWaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:30:08 -0400
Subject: Re: [GIT PULL] pstore updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562884208;
        bh=azM/iQw6mFyNziY4O9DT+9lgfZilCxsmxvNVyQtdPDw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EncO+IVOnyohRUkZBu/lm6JNHjHLWG27ClHgb886kkyKfz+/ziELR8ZmQeC+fAbcJ
         EFontKBLn2Q1rUUtUJY1XK3gg8OPc06tD75FWQqCtQUbo6QbAi4safsqt65XdMN23j
         70gl0LXiRJUtToQWhHZx07Jg0ia8hp72rnb8qbI8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201907082110.3C6AF83FA@keescook>
References: <201907082110.3C6AF83FA@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201907082110.3C6AF83FA@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.3-rc1
X-PR-Tracked-Commit-Id: 4c6d80e1144bdf48cae6b602ae30d41f3e5c76a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b44fccdb8cdcc7c1df522529307566aa89a4ab1
Message-Id: <156288420807.10140.18357845799990350658.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:30:08 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Norbert Manthey <nmanthey@amazon.de>,
        Tony Luck <tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 21:11:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b44fccdb8cdcc7c1df522529307566aa89a4ab1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
