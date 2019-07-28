Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9646CC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C652075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564335921;
	bh=cL9uf+9mTsINffEufKDWvHl6CFopK6dgqHD7jtl31qM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nEsVd688pbbyQwXbgXYUg/BQa57vHjMlNAZnlBqeoaEz5DHSAKCDwcHiuiXT2QoC9
	 lrLogUGnrUqAFmyxxBsb45CW4uR3cO+3eyzpjvY86p7ZOXkQUiPDV910VmwhzOfhSA
	 +pNBL4OviCpCSWqPjicSB2Ah/x+StaRlsug6VMwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfG1RpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfG1RpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:45:19 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564335918;
        bh=cL9uf+9mTsINffEufKDWvHl6CFopK6dgqHD7jtl31qM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TwQ6IGAkh6Wt+Dnx5eTIJu5PE8Nb2F3HaPXqbUxLPXS7QPE4QRtPqaHtrBTrDiXg0
         ylrIRo6o1Vv1E0XJFIhJ139T6uq9leSmbTSbd/lHGmPLpFBPCRz65uVk7y66DNTdb5
         u/01NQdJkeOEuwWa064jxmQlkZRhpa42wLLoB+Lc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATrjXdeMmptd0xRJwXexe_iJwJAUvEf0jQTaLkjWkaKfw@mail.gmail.com>
References: <CAK7LNATrjXdeMmptd0xRJwXexe_iJwJAUvEf0jQTaLkjWkaKfw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATrjXdeMmptd0xRJwXexe_iJwJAUvEf0jQTaLkjWkaKfw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.3
X-PR-Tracked-Commit-Id: b25e8a23d4ea7e8ade2c349c22efe88da88c0988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e61ea11c23b108c8ce062f791dfa737896da346
Message-Id: <156433591855.23734.4302005361552401783.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 17:45:18 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        masahiroy@kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Jul 2019 00:10:55 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e61ea11c23b108c8ce062f791dfa737896da346

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
