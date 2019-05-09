Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE687C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF4A217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557435022;
	bh=gIJEdJgaa6GXbK6N5/rL43It8AHH+QUeyq0uEvYq6FU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TJaTf0na1WxaWMSNnrlIbGF4gAm6uvzhBfwM0UnZVLqsuQQm3jSFYEhdcP+4SWVAm
	 5XzRZlrcEE0cfARn9rbMxtuNjtLRwmGPCRS42diGBTXQ0maBpVHW2+aEbFMrrm6a8A
	 htso8FLpoGRcbt8KfOx03Np5LjTH6/RDzA08OLTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfEIUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfEIUuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:50:16 -0400
Subject: Re: [GIT PULL] Security subsystem: Smack updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557435015;
        bh=gIJEdJgaa6GXbK6N5/rL43It8AHH+QUeyq0uEvYq6FU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mwIG5r0185QMyMQcvZTAXA9UpK1iXkEe1RstPra7YDMZjz8AhQdszuavGeUbjl2g/
         LLcn0SrMDwZWrEyvt90eBgGhdsG7RlHlGfJQGxg8jFk3pTIvq5972KFTwe0e0UgCHI
         8ONheii/niwoNB2KPWos6x7ehckXXwE1UzfRt1ww=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1905100325330.25349@namei.org>
References: <alpine.LRH.2.21.1905100325330.25349@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1905100325330.25349@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-smack
X-PR-Tracked-Commit-Id: 8d31a5c35ed179825a2145881ad7cd8f9907d94b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 800c608c976c3f0a6d02ed7fbc600f1f6962ac73
Message-Id: <155743501574.12157.3971455155840137875.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 20:50:15 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 03:28:49 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/800c608c976c3f0a6d02ed7fbc600f1f6962ac73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
