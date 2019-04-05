Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9712175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554440709;
	bh=HhCnxdlJwbCZopn+EYSIqiSe4IRTXIyRPho6bfN3AOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TC1M4BNIZlDp1FhJNmxjWJeH9Xwn/FIoNhVMzjhgBAliz9woe65Lk16/wleIigPDv
	 g9tuv6fuWZAaeEh1ObN8LrZWz8afbsmQUxTaEmnnj40TlbLaS/PycKFeWCy1xuuEn+
	 oTjsTQrYsICetJPu0cfWnrAGW6XeijF4e5GPX6aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDEFFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEFFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:05:07 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554440707;
        bh=HhCnxdlJwbCZopn+EYSIqiSe4IRTXIyRPho6bfN3AOw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XMbQK6AQTpx9CtQ+EnPHdqlxOmbROxNbanj6mnAxMZQyBOosqmUv1x46SkiibsAKk
         PCtaiWHDp5pUskV6y+IeCXBcb9lSL8nLxG+E7+q0g4tObvzHzXAsc5cTGKzbESyRaM
         8qidpnT3A9JLwbhXMjA3ikwyqmBktL2CSGO0I4bY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190404.184718.1193600058567939028.davem@davemloft.net>
References: <20190404.184718.1193600058567939028.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190404.184718.1193600058567939028.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: bbd669a868bba591ffd38b7bc75a7b361bb54b04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0548740e53e6fe674f850d36db51eccb0557d938
Message-Id: <155444070719.4287.4471220588387673100.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 05:05:07 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Apr 2019 18:47:18 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0548740e53e6fe674f850d36db51eccb0557d938

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
