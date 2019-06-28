Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E1C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8C1208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561681806;
	bh=VVcIGry/JFAOME8xVYDO/JMOARqybIAT2+oQDPKn37M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ji1IczloaM/W89nrJAI/dB74LPY6igG6piGqK13bHJ2WStwoxptfiBjIWq6t+AVMD
	 pgDVhE/+nQQjbQLFqMIHMeFzGG7Jjeb+9huCWLPJStuwWho7zepYYy6UxepWeQhnte
	 f8Cqw8IvxAdr5OR2zLBCTPrZSQjbpybTCNWY7jiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1AaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF1AaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:30:05 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561681804;
        bh=VVcIGry/JFAOME8xVYDO/JMOARqybIAT2+oQDPKn37M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NdMaOGIkBpGzhQAmpDZFJENkJO97O5cpasUXMO8ndZLKyWwAp94AYejXOlEOIb/lg
         tZa7z1JDBIAvYzqQcgIHzGqaeePLTGsXFrBgWNdRYnVmWdBs+h0Y8sk2SACNCVYxTv
         EbYpB1fXhcxyNFiNHcN6+g33cWbUg+M+0XhAJlSU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190626.195006.2073691861982062351.davem@davemloft.net>
References: <20190626.195006.2073691861982062351.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190626.195006.2073691861982062351.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 89ed5b519004a7706f50b70f611edbd3aaacff2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c84afab02c311b08b5cb8ea758cc177f81c95d11
Message-Id: <156168180428.19070.2360267794874347386.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:30:04 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Jun 2019 19:50:06 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c84afab02c311b08b5cb8ea758cc177f81c95d11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
