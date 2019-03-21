Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F31A218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553191812;
	bh=3s0gbHWrvU8A2W3hYUBVA4h3Yh8+nbBoFaOAGGYIExA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=brv1f0JHg5lz/oUxqh3KeqAS3/KxVJSCaHEWGpbVcKrCDXk89joj1FAAKUokJQIk0
	 QncX7fdvXqlP0aux57iC8PGB+fixBgBtxYIzXyCq1iD9UDuXYVEiNyZo3bDPQ+FGiw
	 TmFIlSrI3V/g35Z738e4iohaDgMhRjMEM+bpyWug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfCUSKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfCUSKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:10:04 -0400
Subject: Re: [GIT PULL] udf fixes for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553191803;
        bh=3s0gbHWrvU8A2W3hYUBVA4h3Yh8+nbBoFaOAGGYIExA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BeaIXptSNRmut6Q3t2XPvkJ0qhfCsbL/OmAAdUoZI2PyCXTTyR9FxTq4/fFMJD7dV
         /N/DFy8UdpTE+iUnjD41OHs+JWahSkC9pG6pFTE8yaQgAbAkHjfuOwdMljgZBnP5jV
         q9BWtSDWR8VmCliUdlDaY24xQ2Xkxg9YMb4TUl+E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190321090338.GB29086@quack2.suse.cz>
References: <20190321090338.GB29086@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190321090338.GB29086@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fixes_for_v5.1-rc2
X-PR-Tracked-Commit-Id: 2b42be5eb24564227b15e66f54f088e5a26549c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0939221e64687f7df9bc6572ace80ff5a90c9794
Message-Id: <155319180363.2124.535858486777318614.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Mar 2019 18:10:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Mar 2019 10:03:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0939221e64687f7df9bc6572ace80ff5a90c9794

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
