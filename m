Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57500C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A4C206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568763636;
	bh=QsD9Ft8k8/ZBv4qSv2VfLh7Yih4Wf1/7X2iQYJSWxCA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1AqSejtOIvpwL067l+9hps9cgNJYvXwi/wBsoQhmtjnZrt20UcUOsZt2iurHzEXXs
	 hSxmFozzs4T6PidsbQ7ofq9Z/UE3k0srrE8tk43K+pCMSdz0DRtDG8BPOleesFzfdb
	 AbIYW5omadF3MAypt10U7QwHAnzpcrtYTUbXOOYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfIQXkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfIQXkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:22 -0400
Subject: Re: [git pull] m68knommu changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763621;
        bh=QsD9Ft8k8/ZBv4qSv2VfLh7Yih4Wf1/7X2iQYJSWxCA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xfo79sfAzbmAS4YmaGCnKV334KzFpUOWtUi4MO+l1pnQ7Rpj1uz/ku5HBheX3gAqy
         HxpYdn9LMymqXVQ4WmyWVGAiuWOglOzWp0DrIFBIc/x9eCmaXdmaSto4yrgC+qOIQo
         fcMPnZj8PM3EfRH4LoqFeeFAhbyU/vc0iGw3xqWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a6d7c0bc-a6df-62be-ed2b-944551def5af@linux-m68k.org>
References: <a6d7c0bc-a6df-62be-ed2b-944551def5af@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a6d7c0bc-a6df-62be-ed2b-944551def5af@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
X-PR-Tracked-Commit-Id: 372ea263b3d9cdeb70f8cffa025b2e0875e51b62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16da0961d3d5521f6541a422c5485ea4ddfe860b
Message-Id: <156876362169.26432.9408900653411218770.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:21 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 13:38:17 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16da0961d3d5521f6541a422c5485ea4ddfe860b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
