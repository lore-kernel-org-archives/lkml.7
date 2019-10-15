Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8D5ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287A021835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfJOIra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:47:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbfJOIra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:47:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E5CBC381E56DCDE9C84C;
        Tue, 15 Oct 2019 16:47:28 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 16:47:19 +0800
Subject: Re: [RFC PATCH 6/6] ACPI/IORT: Drop code to set the PMCG
 software-defined model
To:     Hanjun Guo <guohanjun@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
 <1569854031-237636-7-git-send-email-john.garry@huawei.com>
 <e4e8adfd-a0af-82cb-c5f6-77153474330a@huawei.com>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4de3b360-710f-e109-93bf-30ff942d08c1@huawei.com>
Date:   Tue, 15 Oct 2019 09:47:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <e4e8adfd-a0af-82cb-c5f6-77153474330a@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 04:06, Hanjun Guo wrote:
>> -/*
>> > - * PMCG model identifiers for use in smmu pmu driver. Please note
>> > - * that this is purely for the use of software and has nothing to
>> > - * do with hardware or with IORT specification.
>> > - */
>> > -#define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
>> > -#define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
> Since only HiSilicon platform has such erratum, and I think it works with
> both old version of firmware, I'm fine with removing this erratum framework.
>

Yeah, seems a decent change on its own, even without the SMMU PMCG 
driver changes.

But we still need to check on patch "[PATCH RFC 2/6] iommu/arm-smmu-v3: 
Record IIDR in arm_smmu_device structure" to progress any of this.

Will, Robin, Any opinion on that patch?

https://lore.kernel.org/linux-iommu/1569854031-237636-1-git-send-email-john.garry@huawei.com/T/#m1e24771a23ee5426ec94ca2c4ec572642c155a77

> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Cheers,
John

>
> Thanks
> Hanjun
>
>
> .
>


