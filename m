Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AABC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E4C2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217307;
	bh=no7+qR40Pxp+Bl6YYj2T2Ix0QGq4EKVyDu/Nhl8N9xg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TsaFu4AcDakATLihrjncN3W63jXDMsGgUnGo4PQCtqaE7jvnsGBQcwSKl01dTH08z
	 EnGnoCjgNUmeC7FKaMEpDO5ZKjcM6GlWVCJ4GgGluMsciHA670w/L245opiLXWMlgm
	 i7sDZ24Ref4fmjo7/cVKnVS5vici3VZnx1OYGcKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfDYSfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfDYSfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:35:05 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556217305;
        bh=no7+qR40Pxp+Bl6YYj2T2Ix0QGq4EKVyDu/Nhl8N9xg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tfeJWzUUM9AYJPPuwj8unMiFsvRxJsjjwgOx6Mo/SSAjoLjx3BksPLgfbjS6Olrx4
         gDZWnc2ILQN/2IdLRadRvKTRtHFvttbnpcODI0gkSlGIIUUx7rcDYbXptQwZ5LK3PS
         KFmJUsoLKzD0FOUJuyVD/ICnHBcZ4iOhAVFtVTdc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190425174739.27604-1-idryomov@gmail.com>
References: <20190425174739.27604-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190425174739.27604-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.1-rc7
X-PR-Tracked-Commit-Id: 37659182bff1eeaaeadcfc8f853c6d2b6dbc3f47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8113a85f872003a9f5c58f9f143054b0d8ec73a5
Message-Id: <155621730444.24029.13457956880929582266.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Apr 2019 18:35:04 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Apr 2019 19:47:39 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8113a85f872003a9f5c58f9f143054b0d8ec73a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
