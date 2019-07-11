Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB5C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21676208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562820019;
	bh=XyCtee9fm5ygHg2MQYxM/NJrc318IJPhG1x70nQ29FU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xC3dy4uZDv5wesf/kan8EHzAQ8wCCBWVD/wYHj/4oy9Wr3WofGA3SiaNenNcRloFX
	 OzHEztQnQJOSho2/cBNsBTRVL3k10phYzRfn7c6Il8vru2vdbJWHPpUUvHcGNctaHa
	 /YusI2QC7BjivGn6hfok3TXNcLjIUsD9VrY2ow04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfGKEkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 00:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfGKEkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:13 -0400
Subject: Re: [GIT PULL] gfs2: 5.3 merge
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820012;
        bh=XyCtee9fm5ygHg2MQYxM/NJrc318IJPhG1x70nQ29FU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rV8t1EOvevk0szrIWeUtC0mNX9o4K31W0C1hLcuGGSXNWGUaq50uo/2psxkwYz5ln
         bsr1Re5E3MmDO9R9O7ZApkdFBq8K8HrIfh6gst9Lnbeo0FDfVbabmyELzBhW7lJD0o
         +xKWQ6o1/YRgBso6inkkfZ/Kv0D9aRHPMJFtBwYk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710222227.27623-1-agruenba@redhat.com>
References: <20190710222227.27623-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710222227.27623-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-for-5.3
X-PR-Tracked-Commit-Id: bb4cb25dd319fa5630cc304c5bfa926266736935
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0248a8be6d21dad72b9ce80a7565cf13c11509d8
Message-Id: <156282001257.18259.10553090508810604140.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:12 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 00:22:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0248a8be6d21dad72b9ce80a7565cf13c11509d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
