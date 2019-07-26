Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E65C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9E422BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564177220;
	bh=emBU+oPGje0smBOyOoPBoM1vo0glhiK92u22oNz4+Js=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1KIFcfGtDLGSQDxIBsfMhq0LJzH0/WeDq4PPveG/CVQapX3xYnnI8B7/5Mz4+NS/w
	 gLdeKyxM/NhFUaacnyTpi6rxTPb9SVTwJAgzP8HCikcP+BP0Sb0WxA4iYaAcG4ahtZ
	 1w1jx4g16SgKFLpgnQqcpVEADfoCicENub/gD2t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfGZVkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfGZVkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:40:19 -0400
Subject: Re: [PULL] drm-fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564177219;
        bh=emBU+oPGje0smBOyOoPBoM1vo0glhiK92u22oNz4+Js=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yKbz555GdrYsBy2/oTadiLaafo+HU144c9UtWqM5mieiESv/8TpScuRjhg0kfayTk
         zsgMVbFG2c1nwhXXA+XRdYqNt7VqJ4nEP8XltM2yUhmpsN6s9t3zaGDGZ4RsF1BeA8
         ehCdhN+FrAyt/MQI2rvUdTtR3JXEsg8BHMTGChxs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190726194555.GA30301@phenom.ffwll.local>
References: <20190726194555.GA30301@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726194555.GA30301@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-07-26
X-PR-Tracked-Commit-Id: 4d5308e7852741318e4d40fb8d43d9311b3984ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2921f9f95f1c1355a39e54dc038ad95b6e032be
Message-Id: <156417721902.826.16445476014312983791.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 21:40:19 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 21:45:55 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-07-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2921f9f95f1c1355a39e54dc038ad95b6e032be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
