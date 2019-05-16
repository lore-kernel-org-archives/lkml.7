Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777B0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C62020862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558034723;
	bh=ZkdlcUn6dsZ6TG3hhIkkEmefka59uTKUVXd4zSpQhDs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ga4lUGd8YQpl8ZThtat7NqPVKOI1UBuIVl+8uCJw9hZL0AN45et6jJoDKSfrs0tc7
	 bT6V6O7l17P1VG4zGEF7iXh87pWb4/tZSajvWRBwDy/2F6aIv54ik7v7aRF+i4RhBS
	 b+6lwi5JFBlsd1XJ1YgkbhDBCMMHMAETZzO2yCXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfEPTZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 15:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfEPTZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 15:25:22 -0400
Subject: Re: [GIT PULL] configfs update for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558034721;
        bh=ZkdlcUn6dsZ6TG3hhIkkEmefka59uTKUVXd4zSpQhDs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NyKOPIyWMPPWReu9ieI0EmLz/k7rzWBwH1ejOiuY4b6Hg2/jQI+YkbsRTx0xbsnZG
         B+cOOHxKmVQ5fI/Gkkq0IIgnv37/SExLivyq1hUEhFVHtCcdpteRtE0mmXgXNbwlPp
         Y2xf7XZ+gqb4nuLEDcWVwHzQiqjbfENw1EVY/cT8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516082942.GA19549@infradead.org>
References: <20190516082942.GA19549@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516082942.GA19549@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git
 tags/configfs-for-5.2
X-PR-Tracked-Commit-Id: 35399f87e271f7cf3048eab00a421a6519ac8441
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e785e8d9947f0f75e39cf3034dd6f55170c514b
Message-Id: <155803472154.27329.1202763119425514607.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 19:25:21 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 10:29:42 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e785e8d9947f0f75e39cf3034dd6f55170c514b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
