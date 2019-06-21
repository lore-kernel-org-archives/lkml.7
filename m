Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683D9C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F56E208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561137914;
	bh=MSQ+NVLwrOu3RZWOmPtCiYi6KlWTrDLsJmCDFMkBHRA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a+SMWn4KZofvb4u+Ol3IHcKEd1XMkv1JAoEdYJglh4F8nMiQayvqHtnUkEGNRQgz0
	 6ieKyrWmHqIZDl6RpT/Y/MG8r6ATlZxwlZ+JqCMXBPGptjiITz2OuIM/jaU+a4tVd/
	 Yh0qpycfuFnl3Vh9QGeiZ4+PtZWFromN1onV8/f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfFURZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFURZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:25:08 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561137907;
        bh=MSQ+NVLwrOu3RZWOmPtCiYi6KlWTrDLsJmCDFMkBHRA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N7G2ZAG/EpHtkv2x3ltmMRdFxdn/N0v0027kdDJe/aXQ4YKFNehdZwPVRA/AFnTfZ
         VbMeB0uYaVMon3iJeRcpruqr4IsZi/OXcXdKffYl5LGRutsNKav+kKVcyC9Ic6k12i
         VblOEt0kMlQ9O5juAHY3F7Hbsikiqq36+vUHMcpU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190621081042.GA27967@kroah.com>
References: <20190621081042.GA27967@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190621081042.GA27967@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.2-rc6
X-PR-Tracked-Commit-Id: 6f828c55e26769666e0ae56b037f948dc26fe0d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7b8a44f3abab51cc2772c5ced2fe2f51a1ad2b8
Message-Id: <156113790700.2072.17813014124225335919.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 17:25:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jun 2019 10:10:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7b8a44f3abab51cc2772c5ced2fe2f51a1ad2b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
