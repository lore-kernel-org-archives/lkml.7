Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD896C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09E9214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569719125;
	bh=SYJ6+b1K1jPXvtgamD0xDs8q1OYdSQhJHWUoXN9sx/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bsX4xcH9BdCZ5zW6Cek5q5HBT87ieHb+K25xa1kqWf30RqeAA/ykoOSIqt9y3Od6R
	 ruMwn8XW9OBumWbpkGLiETX2ML371AbSM9M/EkaZJyZK210UkA28/otXAOxUzEPml3
	 WVzw8lAA/pfE+11kPOwYS8w32SX+SvjWtdxK4kfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfI2BFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 21:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbfI2BFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 21:05:24 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569719124;
        bh=SYJ6+b1K1jPXvtgamD0xDs8q1OYdSQhJHWUoXN9sx/A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f2omKIPKX0qpKmQPXFiLUjBfkMXVAqXQcavpkQC3NLDD5xLF+/QQQ5D3LmCECV23P
         paB+DYkTj3coGSKgMskD0of5c7qLdUWiDq1r1Fuv24d0dRxYdYttZRLPXUaKJAw+OS
         A+P6LDeLAyFq+m4v9PHHKxciCtRqtUhLAkiqSKLQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190928.154921.125450732732799584.davem@davemloft.net>
References: <20190928.154921.125450732732799584.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190928.154921.125450732732799584.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: faeacb6ddb13b7a020b50b9246fe098653cfbd6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02dc96ef6c25f990452c114c59d75c368a1f4c8f
Message-Id: <156971912406.27111.11932369759446098952.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Sep 2019 01:05:24 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Sep 2019 15:49:21 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02dc96ef6c25f990452c114c59d75c368a1f4c8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
