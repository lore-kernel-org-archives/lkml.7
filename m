Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D3F2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfFKOfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:35:54 -0400
Received: from foss.arm.com ([217.140.110.172]:34416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389344AbfFKOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:35:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB88346;
        Tue, 11 Jun 2019 07:35:52 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D7B3F557;
        Tue, 11 Jun 2019 07:35:51 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 3/8] iommu/arm-smmu-v3: Support platform SSID
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-4-jean-philippe.brucker@arm.com>
 <20190611104214.00001f2c@huawei.com>
Message-ID: <ea6f9c3b-8a4e-d13c-206e-6c64d1c99d8b@arm.com>
Date:   Tue, 11 Jun 2019 15:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611104214.00001f2c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 10:42, Jonathan Cameron wrote:
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 519e40fb23ce..b91df613385f 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -536,6 +536,7 @@ struct iommu_fwspec {
>>  	struct fwnode_handle	*iommu_fwnode;
>>  	void			*iommu_priv;
>>  	u32			flags;
>> +	u32			num_pasid_bits;
> 
> This structure has kernel doc so you need to add something for this.

Good catch

Thanks,
Jean
