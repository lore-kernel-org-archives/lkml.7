Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D535C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4139A21734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578014717;
	bh=wuJ6jyetQrQE5AgzbPce08e3RKECGcbyg5676m6mvhY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u2axJBvtGeb4POj3HSJKutGll8VKOjluQtDpBYtY9xanO13cphej3CLNXajm/SnxU
	 cKFge7jnPPLQf24T4PfJWdW5cUYSYwtXNrdDjmgRoP7kVvgFoAxbA1KarhJbF3SWMk
	 cxkZXgNrbFx3q5IXo282a1cJ0mkMyuA+7WAGjzCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgACBZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgACBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Subject: Re: [GIT PULL] gcc-plugins fix for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578014705;
        bh=wuJ6jyetQrQE5AgzbPce08e3RKECGcbyg5676m6mvhY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jdrPbdFjbgKAhQyxM4wF0mKmlFd2pZ2tu1WEq/Lp7g22+k8UNlT93PqaXgh/hpXU9
         1dN4wqV5ti6IjMDZnOMyhDsAqW5pX64+HGtwvxjfMStO/ug52AJO9PtKxbZ/dZPs9r
         YQnX6II11CqNJ4f5jmuEBq7q3jmHNUUXawn/A1cQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202001021335.14622751ED@keescook>
References: <202001021335.14622751ED@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202001021335.14622751ED@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.5-rc5
X-PR-Tracked-Commit-Id: a5b0dc5a46c221725c43bd9b01570239a4cd78b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90e0a47be934644944e7c6a29b8fc561be168ee1
Message-Id: <157801470583.30243.4425392975724560462.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 01:25:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jan 2020 13:38:15 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90e0a47be934644944e7c6a29b8fc561be168ee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
