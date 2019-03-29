Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F24218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553896215;
	bh=mnRlFW6WiTDA/Bpdu9VJv0FFz0GI+gH06CfMJuiwtRs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Mg8gmokq9bUpBMHoOWLKRh5dqhP2rgI2nXD9AlTiMsl/y4ewMFMe7NqM1fqVPCt6T
	 3CA8ES3MGJY8fVwRufiSIWHZZFj6IYukuHHUGNDv2s9OAB5OQPcfxIxCRnQjKBz+pu
	 X7hhX0uQGML5ES8T2Fh5vOcoOPI3WdjZ2lfCr5Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfC2VuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbfC2VuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:50:11 -0400
Subject: Re: [GIT PULL] xfs: bug fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553896211;
        bh=mnRlFW6WiTDA/Bpdu9VJv0FFz0GI+gH06CfMJuiwtRs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c8KZ/W3U7A1au8KVZXFxR4anCwFky0XkWFKtz/R2aXiuF+vucVPEMl2CzS5iu4So7
         ll0uUyOx3CkaKwvr0L/Fya+xoDHUNqlZ8uZBzQJi45DkeLmpY2eNoLJ03GgDY+w6wo
         LHzxAdAK7DuENx73W4S9m56qvpwXuzMzJMPMAsYA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190329133311.GD18833@magnolia>
References: <20190329133311.GD18833@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190329133311.GD18833@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.1-fixes-1
X-PR-Tracked-Commit-Id: 2032a8a27b5cc0f578d37fa16fa2494b80a0d00a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6503f12d135a616b25be99a492765fc9e9fe07e
Message-Id: <155389621112.28625.10371773111263951960.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 21:50:11 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 06:33:11 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.1-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6503f12d135a616b25be99a492765fc9e9fe07e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
