Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A22C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656FE217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562973626;
	bh=kdDPXa8oriBlZTtqTDP6QTqhIVINZ49sUVusOpHRpX0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=h8QAvn9M9+rxTLi3RTJjeILmHnq1X/mfdVGannbJqNeD3Jcblr399K8sJ5JKnD/Xh
	 uawlMRQCgXWLhsIPdkLyt9+nv8TD3fWXcwHlPOBC97HlHFbB2U/62gaD9zectefz7D
	 74vMrEs74ABvphV/CZBVpguwuxyLFfzabtNXi+4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfGLXUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbfGLXUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:20:19 -0400
Subject: Re: [GIT PULL 1/2] Kbuild updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562973618;
        bh=kdDPXa8oriBlZTtqTDP6QTqhIVINZ49sUVusOpHRpX0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T0U78M4gd42HiW1V0/3/M/IsKDKOlM0kPOfTzVeAxaU4ifhh6ycApnMYgTCSCGe+A
         +N8Kr3Wb01d6TJdiTa14+v0Nz8uRUcoRiYZx6QRK/o1eqNJlJxHE66AjYlAhjDnLgI
         j+QI/Ukk4jYCXFJKwxskvqMW+CKmhFmA0Tts0ook=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATyxi5pjwi6zviW+kyZDWaYdt3tQNu+wFmyNeRDryGEKg@mail.gmail.com>
References: <CAK7LNATyxi5pjwi6zviW+kyZDWaYdt3tQNu+wFmyNeRDryGEKg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATyxi5pjwi6zviW+kyZDWaYdt3tQNu+wFmyNeRDryGEKg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.3
X-PR-Tracked-Commit-Id: d4a74bbfee03acf7bbddc77b9c9236462c744fc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39ceda5ce1b002e30563fcb8ad1bb5ac8e4d59ee
Message-Id: <156297361872.22922.8213971395954398076.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 23:20:18 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        masahiroy@kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Jul 2019 02:50:05 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39ceda5ce1b002e30563fcb8ad1bb5ac8e4d59ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
