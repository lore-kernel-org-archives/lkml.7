Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168E5C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E412521E70
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfGWBtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:49:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731922AbfGWBtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:49:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3523DDCD025E4E7C7BA0;
        Tue, 23 Jul 2019 09:49:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 09:49:02 +0800
Subject: Re: [PATCH] ACPI/IORT: Fix off-by-one check in iort_dev_find_its_id()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-acpi@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
References: <20190722162548.23610-1-lorenzo.pieralisi@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <1d18ce4f-ecd5-4295-60ea-aff5a0d83cb2@huawei.com>
Date:   Tue, 23 Jul 2019 09:48:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190722162548.23610-1-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/23 0:25, Lorenzo Pieralisi wrote:
> Static analysis identified that index comparison against ITS entries in
> iort_dev_find_its_id() is off by one.
> 
> Update the comparison condition and clarify the resulting error
> message.
> 
> Fixes: 4bf2efd26d76 ("ACPI: Add new IORT functions to support MSI domain handling")
> Link: https://lore.kernel.org/linux-arm-kernel/20190613065410.GB16334@mwanda/
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

