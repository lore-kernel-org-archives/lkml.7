Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12045C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D977D2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574906115;
	bh=NZEAe1BplVsAOKZRTkmyH9PPqhpxW6eWMdXQZ2hYyFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ov5wiETfTCwADyzG3aDZ1c3nvtUOE5QyTI0xprbRkvGH9P+6GoKXkzX/HQ15gVOQK
	 hsy03rpek4+yN2SvevUeOrR+tDZt53x6euRiCQBJq0iop5ARrklLSsaxwZpo8CdGTu
	 1vtfSKeSFV5hl0tIrDzLJPgrNhqXl8Dm+DO+9PXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfK1BzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfK1BzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:55:14 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574906114;
        bh=NZEAe1BplVsAOKZRTkmyH9PPqhpxW6eWMdXQZ2hYyFs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I1eRrF3fzyfsTwWjZZU6k9X56Is4fr3q+Pjq05VtTAzrdm/D2z7JYpEkCZ3Z71P1N
         D3EoD+zSDFcKB2jkE9WlbB5Z2eDZuRx9+BMW5g7chA+otprUAB+yYMqw6whDOTl7Vn
         4KepBShV2Al+/noXsnpbGcGx0Oepoh2pNtsKch7o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127.154349.1004587494590963649.davem@davemloft.net>
References: <20191127.154349.1004587494590963649.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127.154349.1004587494590963649.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
 refs/heads/master
X-PR-Tracked-Commit-Id: bac139a846697b290c74fefd6af54a9e192de315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c39f71ee2019e77ee14f88b1321b2348db51820
Message-Id: <157490611405.9858.6920197748409877323.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Nov 2019 01:55:14 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 15:43:49 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c39f71ee2019e77ee14f88b1321b2348db51820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
