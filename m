Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A7BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBD122437
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568836535;
	bh=Ktt/nlqD6vDYLc7TW+CH0PhtRNs9bOOVzv0fjCiwGe8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jaJe9ofhUvKSrosGOSfo1KJsh9pH8k3mdOu0mCoDzD2Ql8yXymvUdeZOQtz586RzL
	 zFaxv+XcoDh2gfeTUfR2pWBRFRVErZmqNbQJ7Rc/6EYmsNEIap5u1uva8rUPuBG0Tm
	 Akwa4IIMz+UzDHXGBwKBJT/g9ZD2lOaeX35Lam4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbfIRTze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388204AbfIRTz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:55:27 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568836526;
        bh=Ktt/nlqD6vDYLc7TW+CH0PhtRNs9bOOVzv0fjCiwGe8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eLQx/WwRvggMBhKhP5s3p7WlbFQFi1vVpmwolWaNQ20t4RF++eYKSBLPj/e6BQEMU
         9WJj9a1l0aXCQ3tc5MVKlUR60hWgA4SyB4SqU0cOSxTXQFrLY1dlZyrZW2ZyrRVXeR
         a3mknmD72+LEpQov1S04NqFfQ8PbH0aVrUp//lM4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190918.003903.2143222297141990229.davem@davemloft.net>
References: <20190918.003903.2143222297141990229.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190918.003903.2143222297141990229.davem@davemloft.net>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 1bab8d4c488be22d57f9dd09968c90a0ddc413bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81160dda9a7aad13c04e78bb2cfd3c4630e3afab
Message-Id: <156883652685.14539.17509162451547564964.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 19:55:26 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 00:39:03 +0200 (CEST):

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81160dda9a7aad13c04e78bb2cfd3c4630e3afab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
