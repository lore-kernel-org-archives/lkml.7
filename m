Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB4C282DE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A17217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554779722;
	bh=XZ7ThNKlvNWZioL+kzojx/CgX1h+fthvi2G1RQ7d60g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=F8EEz9pcOAZnlBnimMksywhNBtjdCDeshwlwIK/v9vOMumZcWH+lPwxOZDr5Xnw6Z
	 4CF02BiJxiZVxInHQENVCfhu60mlxMPtrVONcjJP/08NuKLXM1wSv2xLBB6ux3a19N
	 pUTyZsHxJAQ0afcvZ+2TLL/6PnoGKBkJVWgYFh/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfDIDPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfDIDPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:15:08 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554779707;
        bh=XZ7ThNKlvNWZioL+kzojx/CgX1h+fthvi2G1RQ7d60g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ie/Y9m/0Z67jmmoG/sXo6sh+UzzE7Roq6uajPQkzR6CXu4bfbLD0+sVnK/QFgrq9z
         Ega1v+e20u5Zw4kxpjVFBBkl2bQP5++cbfmqHsx35YIVPD0dQtpzEOHCm0Nl0cipIN
         L5wpILxSnrgYdJH5+Q47yKEB9Ek6Svw+Kah8J1bo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190408.192127.739987515695173484.davem@davemloft.net>
References: <20190408.192127.739987515695173484.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190408.192127.739987515695173484.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: e063f4598249480edaea947679ff950d56f2cc32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 869e3305f23dfeacdaa234717c92ccb237815d90
Message-Id: <155477970766.3610.14807189185678379519.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Apr 2019 03:15:07 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Apr 2019 19:21:27 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/869e3305f23dfeacdaa234717c92ccb237815d90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
