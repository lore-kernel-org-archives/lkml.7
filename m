Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EAD21906
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569609627;
	bh=BaIneuTZYOYbJBBRwvAlATUPFvjHSADgwv+Q/RkkKeA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ywNJGePuu2y7Khjla9gMvpaWG16yOLPzjM2dCFeo68r4VXaxz6IooKWB9hbKrZ7EP
	 wp/zML1I1E4gy1dA0ijdK2A5pDUsNFpQxkx76705ZyxIfGx6U/3xqqMdkH5VsFLXf+
	 nzJvdAGukac0iq8z3yxncDrThq2L90+5yxjob3PY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfI0Sk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfI0SkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:40:25 -0400
Subject: Re: [git pull] drm fixes for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569609624;
        bh=BaIneuTZYOYbJBBRwvAlATUPFvjHSADgwv+Q/RkkKeA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NgmIwzUpb9rBp8TSRt6+EHLrvy8A0VrA8qxR0iliOcFYwGKl3foqCwedSHlmcKeyo
         9QRk381/HUs0POg7drwJHQ8evzjqitUSyccTnF2pmTF6/6FoGCeoavuWKKXbZnFJ7p
         QvYL1fN6dJTaxGbijiqEGJ2uTUF/+VzMJw5NpXwc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txTwuNKGpVGEr=GScQV1FKEJUubyM8UorvUVSHEXEJOkw@mail.gmail.com>
References: <CAPM=9txTwuNKGpVGEr=GScQV1FKEJUubyM8UorvUVSHEXEJOkw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txTwuNKGpVGEr=GScQV1FKEJUubyM8UorvUVSHEXEJOkw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-09-27
X-PR-Tracked-Commit-Id: 3e2cb6d89325dc36a03937a2b82fc7eb902c96b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 289991ce1cac18e7cd489902986ef986baa49568
Message-Id: <156960962446.11345.15901598601759799024.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 18:40:24 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Sep 2019 15:18:57 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-09-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/289991ce1cac18e7cd489902986ef986baa49568

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
