Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FB3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C420621556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576097421;
	bh=wpbGIOJmfXLvXdQoMdWoHvpxTDwBm38Yi2uB/aep6nU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OJuQSpFW9svR5MoaWnmPH+pDiFTPqUbtIHN2VcyoARlR0X9f1i6HEUZ0cnTLoD97c
	 CWO6AxW+T2nH2YEkLeJKLs7yG8GfdsKg2vm436oCpmx8iiRCiAiDS1jB6zE0f/PfIm
	 tREeXEedP4acEnw85zfWDXh9e5Lk6ep5BFy6kbz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfLKUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfLKUuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:50:20 -0500
Subject: Re: [GIT PULL] tracing: More fixes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576097420;
        bh=wpbGIOJmfXLvXdQoMdWoHvpxTDwBm38Yi2uB/aep6nU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wJ++KdmqBLWDrOuhrvraBjuCQ3xhjwWp5Pb7TWFAjw/IwHI3Zc+qI04+ooxeedKGA
         rbUhzk7QSY8G+li563T/asn09fLrQtN8uppkfH1lQjby1COpWR22sAJ3Seuhgunbvo
         S6DTt2PwlvmiikAzJ2P2XfFJoSrT7ZvnhYu+dfSI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191211094249.2013d32a@gandalf.local.home>
References: <20191211094249.2013d32a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191211094249.2013d32a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.5-3
X-PR-Tracked-Commit-Id: ff205766dbbee024a4a716638868d98ffb17748a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6674fdb25a9effc620c95d4c231a6ccc97b2f9b1
Message-Id: <157609742020.20554.2371533624662593502.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Dec 2019 20:50:20 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Dec 2019 09:42:49 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6674fdb25a9effc620c95d4c231a6ccc97b2f9b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
