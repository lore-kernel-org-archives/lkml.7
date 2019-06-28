Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8CEC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AE820B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561682710;
	bh=5zHfczyHjUWu/83GxABVcJZO5nIACC3newO9jZ0LBnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KMSrfeLx9fE5G0pPGOnb6nhFmwhTPjKqvYQ2VoawVl+XI5ZQc9/BMgwBOCIHlSmrZ
	 +7FP17F8APrazVLktHAoWTkFWhfdAFHRdEEv30omQsdy+MRBXwbaSvvXzciLkG5bk9
	 R75COb5WtNv1iG+74leCg3vLJUHnkhH37vIKi8G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfF1ApI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfF1ApF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:45:05 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561682705;
        bh=5zHfczyHjUWu/83GxABVcJZO5nIACC3newO9jZ0LBnQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nKTB+ODBeRztbeI1TXFWU9Lt/zhWxu4iDLSIGx/unZpvs0kS8H73Hmmf36g3y1odo
         ZE+q+H3P6M8icdKhBxRKlwION+i5Oh80O8W2htRgwfvnEo8dxTc+pD2XrAIIWwKzAs
         de5PvTyD11kynOAIgiEsZp1Dr+llmyupHSLuGFxY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190627024508.x5opgsq4tjk32m6j@localhost>
References: <20190627024508.x5opgsq4tjk32m6j@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190627024508.x5opgsq4tjk32m6j@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: e73f65930f8880fafaccf2cc1e5c44272e9523ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe2da896fd9469317ff693fb08a86d9c435e101a
Message-Id: <156168270520.1895.4863534535075761015.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:45:05 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Jun 2019 19:45:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe2da896fd9469317ff693fb08a86d9c435e101a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
