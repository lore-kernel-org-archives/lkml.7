Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA015C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE7C20835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574742320;
	bh=sRhAKmjhRtThVrUK8jTLDaOtav0++el3x2YSI1NFU9E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BBDoN/TtM4mBHzPojwwGxAbqfMGqUCgP8pSqkzp/+dQPru6EMomw72wHMp8L5zYHD
	 S+5YVidG7VfPw0ntbbbzPUaPebODr3QRPv9ue+bk8nHZ7ZRIUMXt8VAw85pusvPiF5
	 Av+OsZTWT/mw6cdFhwxCPJLvIt0IESspxTdKKfMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKZEZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfKZEZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 23:25:13 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574742313;
        bh=sRhAKmjhRtThVrUK8jTLDaOtav0++el3x2YSI1NFU9E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tRa0je8KqMcDBHSfoRUMUf92jjC/rGskTnLTv9AV2L4JQdzRgdcB5P+PF4FQZqpVN
         iEupGC1hCvxTeyqiaAK/xN5Ar/kIXAa1D6Yx0QsriaHoSvceqhS8D2IRxjkF6LxCw1
         UAViQUNbr0QQNHFR3YiVbRKhK5uCYEIoa0zor05k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125.160113.1695634327047749358.davem@davemloft.net>
References: <20191125.160113.1695634327047749358.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125.160113.1695634327047749358.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 622dc5ad8052f4f0c6b7a12787696a5caa3c6a58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 386403a115f95997c2715691226e11a7b5cffcfd
Message-Id: <157474231313.2264.6064984677202893016.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 04:25:13 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 16:01:13 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/386403a115f95997c2715691226e11a7b5cffcfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
