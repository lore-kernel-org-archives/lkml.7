Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E787C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EA624682
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLPBMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 20:12:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfLPBMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 20:12:07 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 985B2CDD63BEC5C7C7A8;
        Mon, 16 Dec 2019 09:12:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 09:11:54 +0800
Subject: Re: [PATCH] EDAC: remove set but not used variable 'ecc_loc'
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191213121036.8886-1-yukuai3@huawei.com>
 <20191213231117.GA793@agluck-desk2.amr.corp.intel.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <adf6f7d0-5e92-78a0-7b2e-7252e3eec99c@huawei.com>
Date:   Mon, 16 Dec 2019 09:11:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191213231117.GA793@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/14 7:11, Luck, Tony wrote:
> On Fri, Dec 13, 2019 at 08:10:36PM +0800, yu kuai wrote:
>> @@ -499,7 +498,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, int chan,
>>   		pci_read_config_dword(pdev, I5100_REDMEMA, &dw2);
>>   		syndrome = dw2;
>>   		pci_read_config_dword(pdev, I5100_REDMEMB, &dw2);
>> -		ecc_loc = i5100_redmemb_ecc_locator(dw2);
>>   	}
>>   
>>   	if (i5100_validlog_recmemvalid(dw)) {
> 
> This deletes the only call to i5100_redmemb_ecc_locator(). Should
> we delete the definition of the function too?
Thank you for your response!
Yes, I think we can do that.

Thanks
Yu Kuai
> 
> Is it worth making cosmetic cleanups to a driver for 12 year old h/w?
> 
> -Tony
> 
> .
> 

