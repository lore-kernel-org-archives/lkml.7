Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F34C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7978E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfDOQAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:00:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfDOQAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:00:34 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9FD57692480B34D1C664;
        Mon, 15 Apr 2019 17:00:32 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by lhreml707-cah.china.huawei.com
 (10.201.108.48) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 17:00:24 +0100
Subject: Re: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller
 support
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <liwei213@huawei.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <guodong.xu@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amit.kucheria@linaro.org>, <john.stultz@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-next@vger.kernel.org>, <xuwei5@hisilicon.com>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
 <20190220113508.GB7498@ulmo> <yq18syak0c2.fsf@oracle.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <fc511f16-d04f-a376-7173-6d1b26b591b5@hisilicon.com>
Date:   Mon, 15 Apr 2019 17:00:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <yq18syak0c2.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On 2/20/2019 2:21 PM, Martin K. Petersen wrote:
> 
> Hi Thierry,
> 
>> it looks like you picked this up into the SCSI tree (perhaps
>> inadvertently). It's been causing linux-next to fail to build since
>> Monday (next-20190218) because it references a phandle (&crg_rst)
>> that's not available.
> 
> I dropped the offending patch from the SCSI tree yesterday. When Stephen
> updates -next, things should be fine.
> 

Thanks!
Applied the dts patch to the hisilicon dts tree.

Best Regards,
Wei

