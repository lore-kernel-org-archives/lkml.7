Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFBBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA93020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552326616;
	bh=0GgjgSABX6RAHroA7MxdN7jLOV3mk5rhsCMf5sRw/no=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WQrw2HH4NPHz6pHYlHmwjgUH9YKmBAKfA+uSPO/Da9U42ON2gxOn1QEsIaAn9DUW4
	 iGIIRNGZwrc6vBxpIEwEgUJRMCvh/2hfChMp6YY8lFrLSLTlt671tM3yTrRJ70fV3Q
	 DffSvDdPqF3EhLB383KnQ2hoFnWKC5/YK2/ebJjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfCKRuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfCKRuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:50:15 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552326614;
        bh=0GgjgSABX6RAHroA7MxdN7jLOV3mk5rhsCMf5sRw/no=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wiI/oUC56tImlbdFqd1xG86Y76FccuKz2dR9LbygRaJbdKHT4ZorRYrAUsxhVr0cc
         CpfUVQzpPlHoBdKoOf8gbTwM6Pkdwwtt+bTiXgCfe34dTshQMjuED0QkQH14a4T5dw
         ZTKRf8VoDTFJohi+6Qz+nstnyt3EwqHjUZlvqHCc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190310.115643.161837775868545540.davem@davemloft.net>
References: <20190310.115643.161837775868545540.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190310.115643.161837775868545540.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 2a5ff07a0eb945f291e361aa6f6becca8340ba46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f49a658b4ea1d0205068da76b7c8c844817dc44
Message-Id: <155232661471.15626.18241911156847882939.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Mar 2019 17:50:14 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 11:56:43 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f49a658b4ea1d0205068da76b7c8c844817dc44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
