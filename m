Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCB6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DFE20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfDOPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:53:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32920 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbfDOPxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:53:49 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B9DE8915B1329F164F21;
        Mon, 15 Apr 2019 16:53:47 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by LHREML711-CAH.china.huawei.com
 (10.201.108.34) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 16:53:38 +0100
Subject: Re: [PATCH v2 0/2] Add Reset controller support for HI3670 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guodong.xu@linaro.org>, <john.stultz@linaro.org>,
        <xuwei5@hisilicon.com>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <fa2bf251-56f4-fe2c-b645-4b634a87940f@hisilicon.com>
Date:   Mon, 15 Apr 2019 16:53:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
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

On 2/15/2019 5:49 AM, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds Reset controller support for HiSilicon HI3670 SoC.
> HI3670 SoC is architecturally same as HI3660 SoC, hence the same driver
> is reused.
> 
> This patchset has been tested on HiKey970 board.
> 
> Thanks,
> Mani
> 
> Changes in v2:
> 
> * Used the DT compatible fallback approach instead of adding a new one
>   for HI3670
> 
> Manivannan Sadhasivam (2):
>   dt-bindings: reset: Add HI3670 reset controller binding
>   arm64: dts: hisilicon: hi3670: Add reset controller support
> 
>  .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi                  | 6 ++++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 

Thanks!
Applied the series to the hisilicon dts tree.

Best Regards,
Wei

