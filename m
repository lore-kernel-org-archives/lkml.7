Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C3CC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E273218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563582630;
	bh=KqVa0Ld/RvWV+a/BIirr1K8Q9WyDQZc+3uWNX1HAPxw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sCYE/WtWz8MgLPZ6okKCm0SViHlesYi5FdAvZD020mn/oKW2o+Ue5m0r8gmwANT3i
	 aIBxtF1ePqXXh95n0+0PLsInNoM0erSPKHtDEVErEdft12xjmCCaiVOu62f67HBqOs
	 GUVy/sfeuiESVl7DROJHUX1s3C3npSE0lQUdn5Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfGTAa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 20:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389375AbfGTAa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 20:30:26 -0400
Subject: Re: [GIT PULL 3/4] ARM: Device-tree updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563582626;
        bh=KqVa0Ld/RvWV+a/BIirr1K8Q9WyDQZc+3uWNX1HAPxw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=so4X+WTK56bU+cxoD2FCHs/EbFSweA8dIphRBzj/AL8ON+fEFI1rtQA05nJjn6Olb
         Ar7dkApoJLDHlbekTPXD88RlHlaXCjMQGQeJy2bJFNWsKF5wYIcSUjTlbnBu2ATtr3
         c2A1jPpNdS/HAVG5sEspEdvBFrk8816MyHDuoWx8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719235434.13214-4-olof@lixom.net>
References: <20190719235434.13214-1-olof@lixom.net>
 <20190719235434.13214-4-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719235434.13214-4-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt
X-PR-Tracked-Commit-Id: f90b8fda3a9d72a9422ea80ae95843697f94ea4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af6af87d7e4ff67324425daa699b9cda32e3161d
Message-Id: <156358262623.21220.7086278576954466612.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 00:30:26 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 16:54:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af6af87d7e4ff67324425daa699b9cda32e3161d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
