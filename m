Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594E4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF4E217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfKAPcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:32:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbfKAPcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:32:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2BC87B0D3691E2CB7247;
        Fri,  1 Nov 2019 23:32:13 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 23:32:12 +0800
Message-ID: <5DBC4FFB.5030200@huawei.com>
Date:   Fri, 1 Nov 2019 23:32:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Borislav Petkov <bp@alien8.de>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com> <20191031110304.GE21133@nazgul.tnic> <5DBACB61.90809@huawei.com> <20191031154916.GA24152@nazgul.tnic> <5DBB03B0.5060003@huawei.com> <20191101084524.GA29724@nazgul.tnic>
In-Reply-To: <20191101084524.GA29724@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/1 16:45, Borislav Petkov wrote:
> On Thu, Oct 31, 2019 at 11:54:24PM +0800, zhong jiang wrote:
>> Yep,  WARN_ONCE alway return true in that case.
> Are you sure it does that always?
>
WARN_ONCE will alway return true if its condition is true.:-)

