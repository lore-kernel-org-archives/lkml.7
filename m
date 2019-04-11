Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5927C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C090C2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDKMZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:25:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfDKMZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:25:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E19E3B67E15566250BCD;
        Thu, 11 Apr 2019 20:25:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Apr 2019
 20:25:24 +0800
Subject: Re: [PATCH -next] memory: tegra: Make terga20_mc_reset_ops static
To:     Thierry Reding <thierry.reding@gmail.com>
References: <20190410140450.31604-1-yuehaibing@huawei.com>
 <20190411093301.GC4633@ulmo>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>, <jroedel@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ceb5d977-afd2-a21a-11b8-e5f426288c68@huawei.com>
Date:   Thu, 11 Apr 2019 20:25:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190411093301.GC4633@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/11 17:33, Thierry Reding wrote:
> On Wed, Apr 10, 2019 at 10:04:50PM +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warning:
>>
>> drivers/memory/tegra/tegra20.c:277:33: warning:
>>  symbol 'terga20_mc_reset_ops' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/memory/tegra/tegra20.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied thanks. I noticed that you use a slightly different name in your
> git author settings and your email setup. The only difference seems to
> be a space between the first and last name, so you may want to look into
> that to avoid having any inconsistencies.

Yeah, indeed, I will fix my git config, thanks!

> 
> Thierry
> 

