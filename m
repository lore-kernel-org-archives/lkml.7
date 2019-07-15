Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F690C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ED021655
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563150616;
	bh=Zqe3Bif38VGdfHqkGKyP909Nfkdoz56H/UBLyahcrJ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pvl4uT7E9nZAQyMlaXUnq/U7Tjv0evcBbJn1OAFI2f11ASKyLXt56JsVdU0QuFGox
	 jYXc6csPpsfHpheXAJUmXB5QkvdqzG/BmGhJ3QXd0zN8LB8Njui+ttdDtXfBHfbh75
	 ZtnHrFOz8Wof+g1w4rYI8HHzCQIBy8E5oS/JxwCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfGOAaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbfGOAaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:30:14 -0400
Subject: Re: [GIT PULL] percpu changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563150614;
        bh=Zqe3Bif38VGdfHqkGKyP909Nfkdoz56H/UBLyahcrJ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hvOB55/C04tQafjYWj3gJsQ8aO7yD1S0r+kIUCVnWtNB1C3gfLopID8RIjI29phbH
         2pv4Ln9NhZW2fcVKgw4aRxdfj8z4cr6e/zkyvmDxfu4efopp5MFLZvWcPW+7SUAikf
         RQTubiplG9QphF2z6bM8IYzqtvv+iK3nmlawXyDs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190713041733.GA80860@dennisz-mbp.dhcp.thefacebook.com>
References: <20190713041733.GA80860@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190713041733.GA80860@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.3
X-PR-Tracked-Commit-Id: 7d9ab9b6adffd9c474c1274acb5f6208f9a09cf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1240cf74e8228f7c80d44af17914c0ffc5633fb
Message-Id: <156315061441.32091.1681296873427251250.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Jul 2019 00:30:14 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Jul 2019 00:17:33 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1240cf74e8228f7c80d44af17914c0ffc5633fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
