Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E0FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB73A215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfKHWiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:38:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:40628 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfKHWiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:38:23 -0500
Received: from [192.168.15.61]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iTCtO-0006xF-D2; Sat, 09 Nov 2019 01:38:10 +0300
Subject: Re: [PATCH v11 0/4] kasan: support backing vmalloc space with real
 shadow memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
References: <20191031093909.9228-1-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <3f9d1163-b1e7-ebef-4099-d40093dfe947@virtuozzo.com>
Date:   Sat, 9 Nov 2019 01:36:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191031093909.9228-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/31/19 12:39 PM, Daniel Axtens wrote:

> Daniel Axtens (4):
>   kasan: support backing vmalloc space with real shadow memory
>   kasan: add test for vmalloc
>   fork: support VMAP_STACK with KASAN_VMALLOC
>   x86/kasan: support KASAN_VMALLOC
> 
>  Documentation/dev-tools/kasan.rst |  63 ++++++++
>  arch/Kconfig                      |   9 +-
>  arch/x86/Kconfig                  |   1 +
>  arch/x86/mm/kasan_init_64.c       |  61 ++++++++
>  include/linux/kasan.h             |  31 ++++
>  include/linux/moduleloader.h      |   2 +-
>  include/linux/vmalloc.h           |  12 ++
>  kernel/fork.c                     |   4 +
>  lib/Kconfig.kasan                 |  16 +++
>  lib/test_kasan.c                  |  26 ++++
>  mm/kasan/common.c                 | 231 ++++++++++++++++++++++++++++++
>  mm/kasan/generic_report.c         |   3 +
>  mm/kasan/kasan.h                  |   1 +
>  mm/vmalloc.c                      |  53 +++++--
>  14 files changed, 500 insertions(+), 13 deletions(-)
> 

Andrew, could pick this up please?
