Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA86CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1678920874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390617AbfJ2QoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:44:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:56230 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390364AbfJ2QoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:44:18 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iPUbL-0006X9-ST; Tue, 29 Oct 2019 19:44:11 +0300
Subject: Re: [PATCH v10 2/5] kasan: add test for vmalloc
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
References: <20191029042059.28541-1-dja@axtens.net>
 <20191029042059.28541-3-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <780d2085-5bfd-e206-b760-ea528844b68e@virtuozzo.com>
Date:   Tue, 29 Oct 2019 19:43:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029042059.28541-3-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/19 7:20 AM, Daniel Axtens wrote:
> Test kasan vmalloc support by adding a new test to the module.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

