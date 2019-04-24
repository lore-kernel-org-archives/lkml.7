Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B4CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F6021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfDXUA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:00:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730082AbfDXUA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:00:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 04D77B6C82414489A57F;
        Thu, 25 Apr 2019 04:00:54 +0800 (CST)
Received: from [127.0.0.1] (10.210.168.23) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Apr 2019
 04:00:43 +0800
Subject: Re: [PATCH 0/6] libsas: Some minor improvements and tidy-up
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1555059478-36224-1-git-send-email-john.garry@huawei.com>
 <yq1v9zehmij.fsf@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <yanaijie@huawei.com>, <chenxiang66@hisilicon.com>,
        <luojiaxing@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4a597316-4d52-13bb-35ce-676350b19f5d@huawei.com>
Date:   Wed, 24 Apr 2019 21:00:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1v9zehmij.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 00:33, Martin K. Petersen wrote:
>
> John,
>
>> This patchset introduces some minor improvements and tidy-up, including:
>> - fix PHY info in sysfs for PHY events
>> - min pathway rate programming improvement
>> - some other tidy-up and neatening
>
> Applied to 5.2/scsi-queue, thanks!
>

Hi Martin,

Sorry for the slow response.

> One thing that always bugged me is the ambiguous "ex" prefix for many
> libsas log messages.And in a way, your patch #3 makes things worse by
> replacing the more descriptive "Expander" with "ex". It does make things
> more consistent, though.

OK, understood. Personally I prefer the brevity of "ex". However, apart 
from this, adding the SAS address to the log does add value.

>
> I'd really like to see all the libsas messages be cleaned up with a
> sensible prefix and a consistent format where possible.

So all libsas messages do have the "sas: " prefix, but they still can be 
vague/inconsistent at times.

Anyway, I'll check what can be done here.

Thanks,


>



