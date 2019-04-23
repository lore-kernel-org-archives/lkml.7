Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92117C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A5F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556046107;
	bh=pIiKOOgCR/TNxE6yXzwzJFRERUw2hVqbz11aHRTY6RU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CAtvuGHhqJ64EvOY6tMpHTmNYDElClzhjCdulQj6ZSzG/ZI9mMbHeQuKvhb18doVA
	 6q9/beAHBXAcElIfv/qLrEIQY8tg6BHP4GuOyslYFV5wsZajbjWSyEAGsHx/ccM85O
	 EwGkPt1+29INlY1m7RRfcl0LD7ggUyNvMe0LwGdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfDWTBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:01:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:01:46 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52444E1A;
        Tue, 23 Apr 2019 19:01:45 +0000 (UTC)
Date:   Tue, 23 Apr 2019 12:01:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: fix never set ALLOC_NOFRAGMENT flag
Message-Id: <20190423120143.f555f77df02a266ba2a7f1fc@linux-foundation.org>
In-Reply-To: <20190423120806.3503-2-aryabinin@virtuozzo.com>
References: <20190423120806.3503-1-aryabinin@virtuozzo.com>
        <20190423120806.3503-2-aryabinin@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 15:08:06 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> Commit 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> removed setting of the ALLOC_NOFRAGMENT flag. Bring it back.

What are the runtime effects of this fix?
