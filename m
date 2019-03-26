Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C93C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0934D2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553622305;
	bh=xFDe7kbGNzS7xcJu0T49t0e5buGehMrpBGAEb69owGM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CltRg9lapmOurK0iaVRDiQQ7uMb3uvl2JwoshicFBJ2RUlqSVXXq0qwI0IUmFsACo
	 RTa7spKuijRqQp1Hh29kpSvvn4L9jPyIGVbnjeTFIVqp27KY1rkTB1XYP6GFi/ndVm
	 25LUdhkZQ8NCvwHjwGh3Z5J30TcIdlDovhSdmQ2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfCZRpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbfCZRpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:45:03 -0400
Subject: Re: [GIT PULL] file locking bugfix for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553622302;
        bh=xFDe7kbGNzS7xcJu0T49t0e5buGehMrpBGAEb69owGM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DdcdrnDjswqp27KcGP2aMJuYgY2YqojgyTcuTRczxwJvcM2XM2LKBB/8gwV54jc/H
         yBYNo6us7O5dBu4STNS0Lj7DIe6a4DPC6slG/xQiGPmd8ZLKdeZJYD3rETLcgjWpVu
         6jfiG6siZ8OI/7e4QPbfXLPbXhJcPayBcO42CJtc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <73ec5fc30bc902ba836eb9dabc8bf92023aa427c.camel@kernel.org>
References: <73ec5fc30bc902ba836eb9dabc8bf92023aa427c.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <73ec5fc30bc902ba836eb9dabc8bf92023aa427c.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 tags/locks-v5.1
X-PR-Tracked-Commit-Id: 945ab8f6de94430c23a82f3cf2e3f6d6f2945ff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9798a22df3a8a976932838b6375c064fc9e623e1
Message-Id: <155362230234.6747.18136626853649136559.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Mar 2019 17:45:02 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, "asn@redhat.com" <asn@redhat.com>,
        "bfields@vger.kernel.org" <bfields@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Mar 2019 06:56:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9798a22df3a8a976932838b6375c064fc9e623e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
