Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AA62186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDLL2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:28:20 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:42963 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbfDLL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:28:20 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 984751C2F7F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:28:18 +0100 (IST)
Received: (qmail 4311 invoked from network); 12 Apr 2019 11:28:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Apr 2019 11:28:18 -0000
Date:   Fri, 12 Apr 2019 12:28:16 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
Message-ID: <20190412112816.GD18914@techsingularity.net>
References: <20190410024714.26607-1-tobin@kernel.org>
 <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
 <alpine.DEB.2.21.1904101452340.100430@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904101452340.100430@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:53:34PM -0700, David Rientjes wrote:
> > FWIW, our enterprise kernel use it (latest is 4.12 based), and openSUSE
> > kernels as well (with openSUSE Tumbleweed that includes latest
> > kernel.org stables). AFAIK we don't enable SLAB_DEBUG even in general
> > debug kernel flavours as it's just too slow.
> > 
> > IIRC last time Mel evaluated switching to SLUB, it wasn't a clear
> > winner, but I'll just CC him for details :)
> > 
> 
> We also use CONFIG_SLAB and disable CONFIG_SLAB_DEBUG for the same reason.

Would it be possible to re-evaluate using mainline kernel 5.0?

-- 
Mel Gorman
SUSE Labs
