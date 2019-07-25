Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F21C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593E622BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfGYJa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:30:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfGYJa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:30:58 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E1A46F2570EFC64F2F5;
        Thu, 25 Jul 2019 17:30:54 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Jul 2019
 17:30:52 +0800
Subject: Re: [PATCH] mm/mmap.c: silence variable 'new_start' set but not used
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190724140739.59532-1-yuehaibing@huawei.com>
 <20190724143445.ezii7bwbbxxxtu2k@black.fi.intel.com>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <yang.shi@linux.alibaba.com>, <jannh@google.com>,
        <walken@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <18e48f75-782d-0aba-4ac4-85347db74f68@huawei.com>
Date:   Thu, 25 Jul 2019 17:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190724143445.ezii7bwbbxxxtu2k@black.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/24 22:34, Kirill A. Shutemov wrote:
> On Wed, Jul 24, 2019 at 02:07:39PM +0000, YueHaibing wrote:
>> 'new_start' is used in is_hugepage_only_range(),
>> which do nothing in some arch. gcc will warning:
> 
> Make is_hugepage_only_range() reference the variable on such archs:
> 
> #define is_hugepage_only_range(mm, addr, len)   ((void) addr, 0)

Thank you for suggestion, I will try this.

> 

