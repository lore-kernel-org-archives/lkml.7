Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D373C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388542466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfLFQYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:24:53 -0500
Received: from relay.sw.ru ([185.231.240.75]:51334 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfLFQYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:52 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1idGPK-00009T-Fv; Fri, 06 Dec 2019 19:24:42 +0300
Subject: Re: [PATCH 1/3] mm: add apply_to_existing_pages helper
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     daniel@iogearbox.net, cai@lca.pw,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191205140407.1874-1-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c4694ce0-2166-325c-bdca-1655c7c359f9@virtuozzo.com>
Date:   Fri, 6 Dec 2019 19:24:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191205140407.1874-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/19 5:04 PM, Daniel Axtens wrote:
> apply_to_page_range takes an address range, and if any parts of it
> are not covered by the existing page table hierarchy, it allocates
> memory to fill them in.
> 
> In some use cases, this is not what we want - we want to be able to
> operate exclusively on PTEs that are already in the tables.
> 
> Add apply_to_existing_pages for this. Adjust the walker functions
> for apply_to_page_range to take 'create', which switches them between
> the old and new modes.
> 
> This will be used in KASAN vmalloc.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
