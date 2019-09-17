Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451AAC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA912067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568682043;
	bh=I4NIFrMdlMutD9IU4xofBCwPU+5dl7IZYqXOeMmc1E4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IQAzE+G//FYuc62FMD8WWV9CDbxCWXiA0oZmi3eysRtl60hLdjCrFdBqOWRoow8Ck
	 kjHujy5CXoNI1/nKoA8EAo1vVtbV8GWL3i8yne9aYQhNrpSm503DzVFh3TGsundgWC
	 0b/+4jiE16aY/y92lYs61CDqlFkN3SvvJWLIC3gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbfIQBAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388496AbfIQBAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:24 -0400
Subject: Re: [GIT PULL] perf changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682023;
        bh=I4NIFrMdlMutD9IU4xofBCwPU+5dl7IZYqXOeMmc1E4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SWyjNYSsQgdmRZDNqdM99gkX9V4yjzUrqgdceMJTgMeAfhDZtVty7xmCkSaz65qQf
         /EB9A7nN860j9AbDl54lyDOqMURpLii1e4u0sj217HnZacuw5An5gGWFNqtDumCkpF
         0dubUtqTmCmIS8Lgwo+H1bHiFLNbdi35PZxOQbo0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916120314.GA31220@gmail.com>
References: <20190916120314.GA31220@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916120314.GA31220@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: e336b4027775cb458dc713745e526fa1a1996b2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 772c1d06bd402f7ee72c61a18c2db74cd74b6758
Message-Id: <156868202357.3683.10247344755698898190.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 14:03:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/772c1d06bd402f7ee72c61a18c2db74cd74b6758

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
