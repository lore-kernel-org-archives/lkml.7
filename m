Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6616EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FF3218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfCUK1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:27:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfCUK1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:27:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C916BF6068DCA1B90B1;
        Thu, 21 Mar 2019 18:27:28 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 18:27:20 +0800
Subject: Re: [PATCH] scsi: hisi_sas: Add softreset in
 hisi_sas_I_T_nexus_reset()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1553077294-129863-1-git-send-email-john.garry@huawei.com>
 <yq1k1gt8kt7.fsf@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9f30134f-d9a8-4944-b5cc-46ef0bbf8f91@huawei.com>
Date:   Thu, 21 Mar 2019 10:27:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1k1gt8kt7.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2019 18:25, Martin K. Petersen wrote:
>
> John,
>
>> We need to always follow an internal abort with a software reset, as
>> per HW programming flow, so add this.
>
> Mangled patch. Applied it by hand to 5.1/scsi-fixes but please use git
> send-email.
>

Hi Martin,

I'm not sure what happened. Patch 
https://patchwork.kernel.org/patch/10861283/mbox/ applied ok for me, and 
I did use git send-email.

Thanks,
John

