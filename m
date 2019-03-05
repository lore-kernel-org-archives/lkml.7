Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB594C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A6920842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757215;
	bh=RXEtUi6vl/0GJq83Ttx8fUBdzN9A1cUWIk6Hw7OECVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1gOjrWjbsjm4kSJqplDDEkiB9H+HJEnQgCbVWVj8woV8THQqv3FsL4N6OF3hiDIPE
	 lIjxMJ9Gplhs35V89XfgbbCiXjk2tMgHPo0WMGAABArL8Bcw8iLQwZB4/3VAQtccUZ
	 JjEnBIFSMpVMRa0Kk+tZJBtwXuodHxcm/6reLjDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfCEDkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfCEDkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:05 -0500
Subject: Re: [GIT PULL] hwmon updates for hwmon-for-v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757205;
        bh=RXEtUi6vl/0GJq83Ttx8fUBdzN9A1cUWIk6Hw7OECVA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s42mXcYkCmw1z9Tutt03m9lCmETodJbBZzEP0ddsvyTcwrp6lGoyUnCvL/O2d6Fgw
         GuB+fe13fYlOhLrT+wWBM8m26h8fHcB23O/XplXuF+3004+tZtBo+z5bMnCVac45B0
         kyXnQb8/5PkFXZUptHBqr5H3MPXCTrILtL0sG8dk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1551709595-18246-1-git-send-email-linux@roeck-us.net>
References: <1551709595-18246-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1551709595-18246-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.1
X-PR-Tracked-Commit-Id: 985e225142cf0cb826401f5448763f13ee712b3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7629bac64204ff256d3b2415767a7acb1401047b
Message-Id: <155175720523.14960.392967588723234902.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:05 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  4 Mar 2019 06:26:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7629bac64204ff256d3b2415767a7acb1401047b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
