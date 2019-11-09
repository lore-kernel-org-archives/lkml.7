Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8913C17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B420865
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573266906;
	bh=ZnfK/xdvUd4/XUscNHvzylDj0cqnh+/IIfsSY8oJja8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EjU8Qnl8GtKW+h9KxnC18sWU54rJmYikeupgt1GyUkLGm31KH8QYDJdRqgqkxGlbC
	 /P7eRa43kDcwSCJrGF9c4gGaV/8MUow5YT0VWbENP7yV4CcwPR6dldZD6DiJ8Eygsu
	 ktA3UCfqP9QbFOK9dDzxBdBXPRd50a/yCDJb1bVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfKICfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 21:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfKICfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:35:05 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573266904;
        bh=ZnfK/xdvUd4/XUscNHvzylDj0cqnh+/IIfsSY8oJja8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xFPZjqNURR+/wYdQsZQvl5jwEX7fJqlLuplVonjrLq30eUaLywiG1WcgYSRs/DnsI
         YeuspYUSkn8vpWPfs1UAstM0JdEtYSDkGyBibfEkWclMurncoXNeYN2lHogg03FQQb
         h5RRJ8bl492xEvX9szmLMI9xFN/pwTxqWpwoJR/s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108.173432.1139057558916119461.davem@davemloft.net>
References: <20191108.173432.1139057558916119461.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108.173432.1139057558916119461.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: a2582cdc32f071422e0197a6c59bd1235b426ce2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0058b0a506e40d9a2c62015fe92eb64a44d78cd9
Message-Id: <157326690465.18517.1376695479110349158.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Nov 2019 02:35:04 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Nov 2019 17:34:32 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0058b0a506e40d9a2c62015fe92eb64a44d78cd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
