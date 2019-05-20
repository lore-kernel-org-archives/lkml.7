Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77040C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5511221479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391364AbfETMjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:39:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391027AbfETMjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:39:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD55920955D48F696694;
        Mon, 20 May 2019 20:39:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 20:39:09 +0800
Subject: Re: [PATCH] scsi: libsas: no need to join wide port again in
 sas_ex_discover_dev()
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190518094057.18046-1-yanaijie@huawei.com>
 <1860c624-1216-bb84-7091-d41a4d43f244@huawei.com>
 <61b6d28d-7b5f-f078-c035-77e855fbe8bf@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        <zhaohongjiang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <83a50fae-78f4-d236-a007-7e8d95553415@huawei.com>
Date:   Mon, 20 May 2019 13:39:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <61b6d28d-7b5f-f078-c035-77e855fbe8bf@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2019 13:06, Jason Yan wrote:
> OK.
>
>>
>> In case of "second fanout expander...", before this, we don't attempt
>> to discover, and just disable the PHY. In that case, is the log proper?
>>
>
> In that case the log is not proper. I think we can directly return in
> the case of "second fanout expander..."? Actually nothing to do after
> the phy is disabled.

Yeah, that looks fine.

>
>> And, if indeed proper, it would seem to merit a higher log level than
>> debug, maybe notice is better.


