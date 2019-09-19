Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FC221929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568858106;
	bh=+nQrQkXOkRxZhzdXX1FnDHOxD+aWBM3cUYJtYy5Em1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JD8wo2nU2Ca71i2uuLbI2PZCCHQ4T5G9QHhs+bfMw7V9xoGlexVYgdEUMaQoKyxjk
	 JVNc2u9GAhWM7vpfW+NHK7jeYoj5EDrRuMxbG3B/RdjrlUu+oPe8h8rSXlD/5OjzPI
	 Eu+fERiGDvg7EPtOwmE8sGjlXQ0H54hRW61udHQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfISBzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388303AbfISBzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:55:05 -0400
Subject: Re: [GIT PULL] vfs: prohibit writes to active swap devices
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568858104;
        bh=+nQrQkXOkRxZhzdXX1FnDHOxD+aWBM3cUYJtYy5Em1c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TvI5YotcIH3dsA9T3qwczl/QP+D2gyt5w5VOLC8DwVKzb1ZQU5+c5ls58ifV1D/zu
         NIR2fYiRicQXVfWQ+96gqZVWMsGmNBisSSI008St0CudFfEQPFs4uNMnssbOdKvbbZ
         fT08Go3HaAwlEhrZmmrUc83rxewcHaWdkx0mU31k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917150608.GT2229799@magnolia>
References: <20190917150608.GT2229799@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917150608.GT2229799@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-5.4-merge-1
X-PR-Tracked-Commit-Id: dc617f29dbe5ef0c8ced65ce62c464af1daaab3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-Id: <156885810471.31089.18252628030141305511.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 01:55:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 08:06:09 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.4-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6bc9de714972cac34daa1dc1567ee48a47a9342

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
