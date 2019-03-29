Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA103C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F9721773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553896233;
	bh=UPaLjtPE1uRgT4hQGbTrgIbVMRO+WWxKrst+O2qg91o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uTFysumbhiWP7gIUH07YOZOCyMJnDoaDsHTcMTcLxoxyz4PcQ8DtgXNDCJ7N4/Sfn
	 GMqB0GXnYltbcvza3+HW2T8sqk8zdIculbTUcxxgmPIFV7WU/ZRRdORIvtZRvSru17
	 4EPKIF+SdzrMNIeuDHI9O9v40CW0ABA93Pd0v3mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfC2Vuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfC2VuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:50:12 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553896211;
        bh=UPaLjtPE1uRgT4hQGbTrgIbVMRO+WWxKrst+O2qg91o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sq6S5GBgH7pbU4xzuVdlx2ev1O+QsY9B/vP9UR6ibNlUXbZjB4yVpQsyVj3lXEUOc
         0tUu2nX7d9+jGTGoeafFSzdpgeWE1+xa72Mmu91RAvhhi2cWHsYrrLQbrVbqlXpkiW
         uPQUEQdIFB6Pn9+qbbtKEorLHEY+ahqOFoy7sit4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATH0b3ANTYa59b+AqY73LKON0=Xr73NgZGuJbWYgYDSDA@mail.gmail.com>
References: <CAK7LNATH0b3ANTYa59b+AqY73LKON0=Xr73NgZGuJbWYgYDSDA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATH0b3ANTYa59b+AqY73LKON0=Xr73NgZGuJbWYgYDSDA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.1
X-PR-Tracked-Commit-Id: 9c38f1f044080392603c497ecca4d7d09876ff99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e40da3efeb02ab0333d01abae20d421841db30a
Message-Id: <155389621163.28625.3545756317419319479.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 21:50:11 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 23:12:30 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e40da3efeb02ab0333d01abae20d421841db30a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
