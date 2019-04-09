Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C31C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8490920880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554779709;
	bh=CGjy7j1vqfQFAZtjYj4k5nq6wXHvgQKgYeaSUvCRcqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iII8UGAleS2JpBT3DpDQswq+mJY3wIWwafWFv8263H659DVipAr3dv8SO/GzSRatK
	 txGTitudlWG9v/Ye0BK4n3c1eenYCkfZO8SMyANMYdz1LwZnHRY98VFiTHVFEOETZO
	 ymvBF20tQv/BM41KDY6TooodvHMxipdPXDbQpEv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDIDPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfDIDPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:15:07 -0400
Subject: Re: [GIT PULL] TPM fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554779707;
        bh=CGjy7j1vqfQFAZtjYj4k5nq6wXHvgQKgYeaSUvCRcqo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z5O37lMsT+pUK1ggnWHxSbNVxgWINbHyaRC4Kd1fC68JHA+qYY3EmVlJNd191OVa8
         WpUGP06pMvoOExwqfWGh8AWo31rd03hCtFzXoTzEPSHuauwruDnpDX6hy1C3SougSQ
         MRMvcoTYfz74iiZL5FJF6NE977+VNa6qgLkeJfnE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1904090905570.20894@namei.org>
References: <alpine.LRH.2.21.1904090905570.20894@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1904090905570.20894@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 fixes-v5.1
X-PR-Tracked-Commit-Id: 6da70580af9612accf042b37564d73e787af39b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a556810d8e06aa2da8bbe22da3d105eb5a0d0c7d
Message-Id: <155477970746.3610.2895354899366330993.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Apr 2019 03:15:07 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Apr 2019 09:07:10 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a556810d8e06aa2da8bbe22da3d105eb5a0d0c7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
