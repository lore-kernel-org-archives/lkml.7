Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2426AC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07BC20854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfB1Ldh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:33:37 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:34189 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfB1Ldh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:33:37 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 7652D1C20BD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:33:35 +0000 (GMT)
Received: (qmail 27096 invoked from network); 28 Feb 2019 11:33:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Feb 2019 11:33:35 -0000
Date:   Thu, 28 Feb 2019 11:33:33 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 3/4] mm/compaction: pass pgdat to too_many_isolated()
 instead of zone
Message-ID: <20190228113333.GF9565@techsingularity.net>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
 <20190228083329.31892-3-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190228083329.31892-3-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:33:28AM +0300, Andrey Ryabinin wrote:
> too_many_isolated() in mm/compaction.c looks only at node state,
> so it makes more sense to change argument to pgdat instead of zone.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Rik van Riel <riel@surriel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
