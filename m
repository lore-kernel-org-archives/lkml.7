Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14840C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE829218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OqNtzb0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCOTy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:54:56 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:60485 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbfCOTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:54:45 -0400
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 48B383500138;
        Fri, 15 Mar 2019 22:54:43 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9nNlSAWyfE-sfKOnHMd;
        Fri, 15 Mar 2019 22:54:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1552679682;
        bh=LgQ5SqAVCvRgHg1QvCQBGGqfZNz2IfTDPXHhEJSYZmo=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=OqNtzb0SxzzC9sNNQz5aIK4HD5kqRGNAdQcLoJVNWb3lwh9aOx4QXcjYEksnD9Q81
         nxupvJMDro5rqzzJnWhXNHReD7GXseBtsh96ZHQpWdv9wO84YR+CsyCpxpQLWAvKGK
         kG/WTQtUILlCu7tYrzES8LJY5R/SAGIJoumjYDyI=
Authentication-Results: mxback7g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva4-031ea4da33a1.qloud-c.yandex.net with HTTP;
        Fri, 15 Mar 2019 22:54:41 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     George Spelvin <lkml@sdf.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <cover.1552097842.git.lkml@sdf.org>
References: <cover.1552097842.git.lkml@sdf.org>
Subject: Re: [PATCH 0/5] lib/sort & lib/list_sort: faster and smaller
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 15 Mar 2019 22:54:41 +0300
Message-Id: <114231552679681@iva4-031ea4da33a1.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am pleased with this patch. Yes there is still a couple of controversial
issues but in my opinion, it is mostly "matter of taste", and whatever solutions
could be made, the patch is great.

So you may add me to the "Acked-by" section.

(And I mean the whole patch from 1 to 5)
With Best Regards, Andrey Abramov.
