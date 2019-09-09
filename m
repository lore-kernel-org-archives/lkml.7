Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1CC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245C8206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfIIPAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:00:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbfIIPAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:00:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92800AC35;
        Mon,  9 Sep 2019 14:59:58 +0000 (UTC)
Subject: Re: [PATCH 2/5] mm, slab_common: Remove unused kmalloc_cache_name()
To:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190903160430.1368-1-lpf.vector@gmail.com>
 <20190903160430.1368-3-lpf.vector@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <80fe024b-006e-b38e-1548-70441d917b41@suse.cz>
Date:   Mon, 9 Sep 2019 16:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903160430.1368-3-lpf.vector@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 6:04 PM, Pengfei Li wrote:
> Since the name of kmalloc can be obtained from kmalloc_info[],
> remove the kmalloc_cache_name() that is no longer used.

That could simply be part of patch 1/5 really.

> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>

Ack

> ---
>   mm/slab_common.c | 15 ---------------
>   1 file changed, 15 deletions(-)
