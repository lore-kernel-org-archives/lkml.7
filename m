Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A165C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4681A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552353638;
	bh=xa5kC5YzryJdodN0UlInO1ntlxrLHJ8KBE4JG1n52DI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bdNKzf1a+urC7COlzipAPMTNkym5FzmNDo9jgRdYF1HHPn/rG3XbJOr66PFWz2Z9P
	 kRKPNjNzJ1bBoXGIf/YTWHcrZWrDhLPsz7fUn4K2v0ARsNddVDSZQoHBH0QDAX4ONN
	 Gif3SMnhc1tG2WXmx85tbR4hNxmobfyulejTUkw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCLBUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfCLBUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:20:16 -0400
Subject: Re: [GIT PULL] xen: fixes and features for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552353616;
        bh=xa5kC5YzryJdodN0UlInO1ntlxrLHJ8KBE4JG1n52DI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uUpF0xflvVrW7cy3EZgooWwX/m3vwK5RyW0pBlv0lle6kOzLXH/gleYJHiP5bCkVD
         B2gXfjKG5DOygLvXcepUthIF18b/kKwPQWu+82EJiqKsHX/uHSkrXUA6LgoYnI8f60
         fY2gdE0vkUHJjbCIE8Bxvqy5PbLFHGXLUS96H4i0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190311093951.18085-1-jgross@suse.com>
References: <20190311093951.18085-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190311093951.18085-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.1a-rc1-tag
X-PR-Tracked-Commit-Id: 01bd2ac2f55a1916d81dace12fa8d7ae1c79b5ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d14d7f14f177834788a276fc7b1317b539cedca2
Message-Id: <155235361596.2216.14646913224859772431.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 01:20:15 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Mar 2019 10:39:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.1a-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d14d7f14f177834788a276fc7b1317b539cedca2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
