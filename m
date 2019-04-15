Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B75C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E8F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfDOQCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:02:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32923 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfDOQCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:02:38 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BF8DD429EBB36F720BE5;
        Mon, 15 Apr 2019 17:02:36 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by lhreml702-cah.china.huawei.com
 (10.201.108.43) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 17:02:30 +0100
Subject: Re: [RESEND][PATCH 0/3] DMA dts changes for hi3660
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <xuwei5@hisilicon.com>
References: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5420f497-1316-c4ba-5b8a-1116f680cb01@hisilicon.com>
Date:   Mon, 15 Apr 2019 17:02:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 4/4/2019 9:16 AM, John Stultz wrote:
> Here are a few dts changes which didn't get picked up
> for the last merge window to enable support for code
> changes that did land in v5.1.
> 
> Let me know if you have any objecitons or feedback!
> 
> thanks
> -john
> 
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> 
> 
> John Stultz (2):
>   arm64: dts: hi3660: Add dma to uart nodes
>   arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask
> 
> Youlin Wang (1):
>   arm64: dts: hi3660: Add hisi asp dma device
> 
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

Thanks!
Applied the series to the hisilicon dts tree.

Best Regards,
Wei

