Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00160C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BEA20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557200705;
	bh=qzNmPkgxKzzz2MIbG08Frik9CsTyw4jHKdomI3RJans=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GevqtRLADRYq1oPFHrUWtp4KYhIRwlN4aIFzSO9tR1Yb7LouHWmtIpQZmgoyjuOYc
	 mqqZ46/L3EQyU/eDnk3/ha24+SmOO7Gny4vs/NjMYZiIaoR5gGZBr+EVSYiO6CU4NU
	 eGBju1Tp95VPUf2XUrh+6onSOUfozfGKP+V+r3j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfEGDpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfEGDpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:45:04 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557200703;
        bh=qzNmPkgxKzzz2MIbG08Frik9CsTyw4jHKdomI3RJans=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pv6/4e6jrosIs7MRcnk82yNXWFUH5ChAy2NhRkfQgjqH+KTfbsd4/2tx9cMhf+Hd4
         OY/VEXFHRZdvx4kOz6/iMVg804B7vMotiUWqM+8gcgcwRLphyKLkWcu/v82hVoi/uK
         ZEYSYQIa8aybGyviTguD17onwUaK0vXoSwDulaAM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9b434125-44b6-0e83-4f70-d1fd28752407@linuxfoundation.org>
References: <9b434125-44b6-0e83-4f70-d1fd28752407@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9b434125-44b6-0e83-4f70-d1fd28752407@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.2-rc1
X-PR-Tracked-Commit-Id: d917fb876f6eaeeea8a2b620d2a266ce26372f4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71ae5fc87c34ecbdca293c2a5c563d6be2576558
Message-Id: <155720070369.8669.2043992716703088377.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 03:45:03 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:56:56 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71ae5fc87c34ecbdca293c2a5c563d6be2576558

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
