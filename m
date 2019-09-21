Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD5C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951C221882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569085830;
	bh=F8HVTXFDyOVcIZS3tEiIuySfZ8YoIFGTiypeLpycHAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wJ7CSFgv7qgzohHHD9H7+KywEyRwYy+/XW+I4Kx7/nXFDEj4NCXL3ZmYhxm76ylSz
	 yXahCDJz+fqBtRd+tviWAzsFK6yPBQzTFZWwAuh3mMxViGdwrKRMjaJUJgGZ0QdmAP
	 pML/MEkEdcolfGcwaFbR0q9dYsLaIGKHefNRJuvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfIURK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731129AbfIURKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:10:24 -0400
Subject: Re: [GIT PULL] compiler-attributes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085824;
        bh=F8HVTXFDyOVcIZS3tEiIuySfZ8YoIFGTiypeLpycHAw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LwwEawjvFHqbZoVxXuxyye5tRy5yxzaoh9wvSBH/eJsfimRbJmdRSj3QIyId01pFH
         47HAYCkg4BXJdzCwtH+GfPe6w9KJ6LqYJimOgI2mawnhkpXFULn+qEr6jpuw7i0UWy
         m8h2VaLh/o1wIypL6QWigDPSrBV8nfe1k3vPnKMo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919215353.GA16429@gmail.com>
References: <20190919215353.GA16429@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919215353.GA16429@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/compiler-attributes-for-linus-v5.4
X-PR-Tracked-Commit-Id: 32ee8230b2b06c50f583e14fcd174d7d2edb52f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 227c3e9eb5cf3552c2cc83225df6d14adb05f8e8
Message-Id: <156908582410.8665.10608553148108459825.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 17:10:24 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 23:54:21 +0200:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/227c3e9eb5cf3552c2cc83225df6d14adb05f8e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
