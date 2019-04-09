Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08953C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86C920880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfDINIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:08:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:53486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfDINIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:08:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09070ACC1;
        Tue,  9 Apr 2019 13:08:00 +0000 (UTC)
Subject: Re: [PATCH v5 0/7] mm: Use slab_list list_head instead of lru
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190402230545.2929-1-tobin@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a4950b5e-1af8-4ce6-8b01-ea9c9caa45d0@suse.cz>
Date:   Tue, 9 Apr 2019 15:07:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402230545.2929-1-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 1:05 AM, Tobin C. Harding wrote:
> Tobin C. Harding (7):
>   list: Add function list_rotate_to_front()
>   slob: Respect list_head abstraction layer
>   slob: Use slab_list instead of lru
>   slub: Add comments to endif pre-processor macros
>   slub: Use slab_list instead of lru
>   slab: Use slab_list instead of lru
>   mm: Remove stale comment from page struct

For the whole series:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> 
>  include/linux/list.h     | 18 ++++++++++++
>  include/linux/mm_types.h |  2 +-
>  mm/slab.c                | 49 ++++++++++++++++----------------
>  mm/slob.c                | 59 +++++++++++++++++++++++++++------------
>  mm/slub.c                | 60 ++++++++++++++++++++--------------------
>  5 files changed, 115 insertions(+), 73 deletions(-)
> 

