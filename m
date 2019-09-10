Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA26C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E242081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbfIJMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:45:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22841 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726193AbfIJMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:45:57 -0400
X-UUID: ea7760d474544bb18f6fd74ca1614a77-20190910
X-UUID: ea7760d474544bb18f6fd74ca1614a77-20190910
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1580390971; Tue, 10 Sep 2019 20:45:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Sep 2019 20:45:48 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Sep 2019 20:45:48 +0800
Message-ID: <1568119549.24886.18.camel@mtksdccf07>
Subject: Re: [PATCH v2 0/2] mm/kasan: dump alloc/free stack for page
 allocator
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 10 Sep 2019 20:45:49 +0800
In-Reply-To: <4faedb4d-f16c-1917-9eaa-b0f9c169fa50@suse.cz>
References: <20190909082412.24356-1-walter-zh.wu@mediatek.com>
         <d53d88df-d9a4-c126-32a8-4baeb0645a2c@suse.cz>
         <a7863965-90ab-5dae-65e7-8f68f4b4beb5@virtuozzo.com>
         <4faedb4d-f16c-1917-9eaa-b0f9c169fa50@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 13:53 +0200, Vlastimil Babka wrote:
> On 9/10/19 12:50 PM, Andrey Ryabinin wrote:
> > 
> > 
> > For slab objects we memorize both alloc and free stacks. You'll never know in advance what information will be usefull
> > to fix an issue, so it usually better to provide more information. I don't think we should do anything different for pages.
> 
> Exactly, thanks.
> 
> > Given that we already have the page_owner responsible for providing alloc/free stacks for pages, all that we should in KASAN do is to
> > enable the feature by default. Free stack saving should be decoupled from debug_pagealloc into separate option so that it can be enabled
> > by KASAN and/or debug_pagealloc.
> 
> Right. Walter, can you do it that way, or should I?
> 
> Thanks,
> Vlastimil

I will send new patch v3.

