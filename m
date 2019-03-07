Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8CBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19A820684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551921617;
	bh=ngQxIWxqVl0Qa1OOmER5dQdjFU7+9WCqv01nhEnHB/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CEiFWbdFQHnImemcdc3h/KT6HnCnGEVSQf462+Si+nXZUoyD47pKNWrYt78yL8cF0
	 Mt9xNQklKgD+/V6MHo4J/rdvb0F2g0OGW19JfppP8Mkp6yoVHaIYSPswTQeaWeA28l
	 5rr+uqxsFl9gGcNsJ8yxb10gi5rdR5BktElrz/Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCGBUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfCGBUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:20:15 -0500
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551921615;
        bh=ngQxIWxqVl0Qa1OOmER5dQdjFU7+9WCqv01nhEnHB/A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lqUC5SrdM/4S7sh997QaB28hoZKtEYDmPWFMKO02Lp5U2DxUuzIseXdlErYkZdZdK
         JoUInvo85gzRnFOfYEjPixgJ0uX+ZkI+dn7lOKXHMayvCahyP8Sumzq5ZDKQdC4Nz2
         kTcTv68boTllHb5Hk2iHcsey53Nsg3M7ZN6Li1T4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306103324.GA10412@kroah.com>
References: <20190306103324.GA10412@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306103324.GA10412@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.1-rc1
X-PR-Tracked-Commit-Id: 142a0f83b216a607aebed42e54a1be620765e28c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45763bf4bc1ebdf8eb95697607e1fd042a3e1221
Message-Id: <155192161552.31671.4798722879337162307.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 01:20:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 11:33:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45763bf4bc1ebdf8eb95697607e1fd042a3e1221

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
