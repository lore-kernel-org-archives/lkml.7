Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC6620815
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCBBUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:20:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfCBBUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:20:54 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9742DA86CED8FE8DC9FE;
        Sat,  2 Mar 2019 09:20:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Sat, 2 Mar 2019
 09:20:49 +0800
Subject: Re: [PATCH -next] fbdev: omap2: omapfb: trivial code cleanup
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20190301015537epcas4p242dee277b9b0b4953775bb948985775c@epcas4p2.samsung.com>
 <20190301015342.28888-1-yuehaibing@huawei.com>
 <f14aa8d6-7cd7-4295-11d9-ee0aefdaa7c0@samsung.com>
CC:     <trivial@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <bdb40e58-ae8c-497f-cb35-baecdfbdd2a9@huawei.com>
Date:   Sat, 2 Mar 2019 09:20:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <f14aa8d6-7cd7-4295-11d9-ee0aefdaa7c0@samsung.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/1 22:50, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On 03/01/2019 02:53 AM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> After commit 60d2fa0dad06 ("fbdev: omap2: no need to check
>> return value of debugfs_create functions"), there are corner
>> code need to be cleaned.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thanks but I've already applied earlier patch from Anders Roxell:
> 
> https://marc.info/?l=linux-fbdev&m=155004766902831&w=2

Good to know this, Thanks!

> 
>> ---
>>  drivers/video/fbdev/omap2/omapfb/dss/core.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
>> index 7e6a3eb..b5956a1 100644
>> --- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
>> +++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
>> @@ -136,7 +136,6 @@ static inline void dss_uninitialize_debugfs(void)
>>  }
>>  void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
>>  {
>> -	return 0;
>>  }
>>  #endif /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
>>  
>> @@ -169,8 +168,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
>>  
>>  static int __init omap_dss_probe(struct platform_device *pdev)
>>  {
>> -	int r;
>> -
>>  	core.pdev = pdev;
>>  
>>  	dss_features_init(omapdss_get_version());
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 

