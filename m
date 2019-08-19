Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB7DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFAF22CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfHSRY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:24:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:36964 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfHSRY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:24:59 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hzlOo-00023q-HO; Mon, 19 Aug 2019 20:24:54 +0300
Subject: Re: [PATCHv2] lib/test_kasan: add roundtrip tests
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20190819161449.30248-1-mark.rutland@arm.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a699eb44-87ff-aa2b-140f-79de11374bdf@virtuozzo.com>
Date:   Mon, 19 Aug 2019 20:25:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819161449.30248-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/19 7:14 PM, Mark Rutland wrote:
> In several places we need to be able to operate on pointers which have
> gone via a roundtrip:
> 
> 	virt -> {phys,page} -> virt
> 
> With KASAN_SW_TAGS, we can't preserve the tag for SLUB objects, and the
> {phys,page} -> virt conversion will use KASAN_TAG_KERNEL.
> 
> This patch adds tests to ensure that this works as expected, without
> false positives which have recently been spotted [1,2] in testing.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20190819114420.2535-1-walter-zh.wu@mediatek.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20190819132347.GB9927@lakrids.cambridge.arm.com/
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---


Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
