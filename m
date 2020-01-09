Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE50CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09952067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578597451;
	bh=Fd+wZaFL9jB2QAaByf9y8qNx17ntwvlbUqGgYoDFaXI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=npiknAcriIgbEyXx0CO1TbWFqN1FzwTbXeiaivv9hCjxFBt8v2jS/GNazSMdj1TUf
	 B/ohgCFTx4fdlhgLzf5yOcl3zIo5dDFruGqPXYUvqxqO9OVNw7xmIo2Jux203J6gn8
	 3/fadnh5K/8gZv9Tg+Gc1iujO6FvlJ4S7XEI7Z4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgAITRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgAITR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:17:27 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578597305;
        bh=Fd+wZaFL9jB2QAaByf9y8qNx17ntwvlbUqGgYoDFaXI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SOcizeYCCOPXGFtdTyeRCNdmx6Lg9Nm2/H5Jj61/lLVqQngnlf7Y+MBqISozlPL00
         Ms00oadz5UD2ct1JyhkF1XNixCBMzpcsI9S671xPgJI6fJzwidt320V6B5764zV1c6
         Imcvji9J/7T9hK/FHFOVHV+tSX29ujEUpsQciIcY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200108.225547.2138089804633960284.davem@davemloft.net>
References: <20200108.225547.2138089804633960284.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200108.225547.2138089804633960284.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 9546a0b7ce0077d827470f603f2522b845ce5954
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5f48c7878d2365f6ff7008e9317abbc16f68847
Message-Id: <157859730525.26179.13101302128233079775.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Jan 2020 19:15:05 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 08 Jan 2020 22:55:47 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5f48c7878d2365f6ff7008e9317abbc16f68847

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
