Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A18C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 05:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48321530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 05:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557294017;
	bh=J496PWk1eLGWsHPf7iV/SSEef+bsxWodQCQSPUDL6cg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xlKyoAJSWV5UrEKnF5cd7SAZ3IXrTgk44CGrOwbyXm7ITN0JeRgD5DW6nx6cej+6X
	 CZXCcDcxc+CUZ+ON3qezPOPA8S6EY9cjE2+B4+Z+it6S+9dhyfIQVF9pEFpClYA/6O
	 qbplVPPQuUWW0psdJpQ9F8m1G+hIJYD1vJnSQTMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfEHFkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 01:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfEHFkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 01:40:14 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557294013;
        bh=J496PWk1eLGWsHPf7iV/SSEef+bsxWodQCQSPUDL6cg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bNAJHHYdEqBu2OGgoG9/In+g/lqVBDug+Mcg7eejNvaNkOsttAL/F/qOaxBo0LMU7
         axfgTFF3ptyM9RvhUFA9Mw1qUahDsAZTCn+z3D8pL32YQe1vXHPfod9+5RB0bKVFYg
         5LGumFlToV0pfWIrpsTYBsRzaiqG0GcsFRxD0R0k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507.180102.1682734091447758139.davem@davemloft.net>
References: <20190507.180102.1682734091447758139.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507.180102.1682734091447758139.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
 refs/heads/master
X-PR-Tracked-Commit-Id: a9e41a529681b38087c91ebc0bb91e12f510ca2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80f232121b69cc69a31ccb2b38c1665d770b0710
Message-Id: <155729401378.2342.9111999010699801294.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 05:40:13 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 07 May 2019 18:01:02 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80f232121b69cc69a31ccb2b38c1665d770b0710

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
