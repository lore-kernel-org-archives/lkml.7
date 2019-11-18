Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12049C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F5620885
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKRQXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:23:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:57562 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfKRQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:23:03 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iWjnP-0006u4-8v; Mon, 18 Nov 2019 19:22:35 +0300
Subject: Re: [PATCH v4 1/3] kasan: No KASAN's memmove check if archs don't
 have it.
To:     Nick Hu <nickhu@andestech.com>, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, paul.walmsley@sifive.com,
        palmer@sifive.com, aou@eecs.berkeley.edu, tglx@linutronix.de,
        gregkh@linuxfoundation.org, alankao@andestech.com,
        Anup.Patel@wdc.com, atish.patra@wdc.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org, green.hu@gmail.com
References: <20191028024101.26655-1-nickhu@andestech.com>
 <20191028024101.26655-2-nickhu@andestech.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <73f11f1e-6df7-c217-e05d-049d04717600@virtuozzo.com>
Date:   Mon, 18 Nov 2019 19:22:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191028024101.26655-2-nickhu@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/19 5:40 AM, Nick Hu wrote:
> If archs don't have memmove then the C implementation from lib/string.c is used,
> and then it's instrumented by compiler. So there is no need to add KASAN's
> memmove to manual checks.
> 
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
