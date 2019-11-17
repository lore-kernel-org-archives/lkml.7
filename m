Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75217C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F3720730
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574008508;
	bh=7DML9Q3jxT2KrMtabpA4cmYVdkAuL0MIgZecgdds7hI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rVgLxVS0ORejP2df/fQX63mWbrcM3uLLLt/yvaq5WsqBoC9okHj7Vgtd6cYjVEyq2
	 yzUtkxeFFmMzhs6SMk78hcjEgFMCZXcJGHeqsu2IPwSflzYvg5MSVUFxP8O+aSqDpl
	 4qdUxVpbaIKv/lD0W5mZ5QrlKi9Gu3DlTf0oWMbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfKQQfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 11:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfKQQfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 11:35:05 -0500
Subject: Re: [PULL REQUEST] i2c for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574008505;
        bh=7DML9Q3jxT2KrMtabpA4cmYVdkAuL0MIgZecgdds7hI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ffNypmwMRCFHf/qaES2xrl9UQPnSB1tQGONq5JDJ25w4NaVFGQSJd3bGhtbkEICg0
         Y4gosBBgAOyd2QK96BESLASNFtTmNPyimPNARsKlU6SYvVHk31UaEsjcVhpfsPpwTh
         lG5ZgjDbfcgOVn+LyaGTGkm/LqZBRcuMGGMU39vo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191117072838.GA1428@kunai>
References: <20191117072838.GA1428@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191117072838.GA1428@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: a4c2fec16f5e6a5fee4865e6e0e91e2bc2d10f37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b27354cca8e9d9ab7c5bfb8a34101d52b5e48c4
Message-Id: <157400850501.10370.6617602374762785945.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 16:35:05 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Nov 2019 08:28:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b27354cca8e9d9ab7c5bfb8a34101d52b5e48c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
