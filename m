Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F10C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD30D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfDWOfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:35:18 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:49972 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727228AbfDWOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:35:18 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id C04AC1C25D3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:35:16 +0100 (IST)
Received: (qmail 21554 invoked from network); 23 Apr 2019 14:35:16 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Apr 2019 14:35:16 -0000
Date:   Tue, 23 Apr 2019 15:35:15 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: fix never set ALLOC_NOFRAGMENT flag
Message-ID: <20190423143515.GP18914@techsingularity.net>
References: <20190423120806.3503-1-aryabinin@virtuozzo.com>
 <20190423120806.3503-2-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190423120806.3503-2-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:08:06PM +0300, Andrey Ryabinin wrote:
> Commit 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> removed setting of the ALLOC_NOFRAGMENT flag. Bring it back.
> 
> Fixes: 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
