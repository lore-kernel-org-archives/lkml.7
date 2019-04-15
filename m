Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A304CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A03620818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfDOP6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:58:05 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32921 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfDOP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:58:04 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A9D326EF0F07A37406B1;
        Mon, 15 Apr 2019 16:58:03 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by lhreml705-cah.china.huawei.com
 (10.201.108.46) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 16:57:55 +0100
Subject: Re: [PATCH 0/3] Add MMC controller support for HI3670 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <amit.kucheria@linaro.org>,
        <guodong.xu@linaro.org>, <xuwei5@hisilicon.com>
References: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <49d86dbb-2d88-a1f3-53f7-eda90e961cbb@hisilicon.com>
Date:   Mon, 15 Apr 2019 16:57:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
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

On 2/28/2019 3:45 PM, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds MMC controller support for HI3670 SoC. Since HI3670
> SoC is architecturally same as the HI3660 SoC, HI3660 DWMMC driver is
> reused here with DT compatible fallback approach. Also, SD and WiFi
> supports are added for the HiKey970 board.
> 
> Wei:
> 
> Please apply this patchset along with the reset and UFS patches in the
> following order:
> 
> 1. Reset support patches
> 2. MMC support patches
> 3. UFS support patches
> 
> PS: Since there is no PMIC support available yet, fixed-regulator nodes
> are used to get the driver working (regulators are enabled by bootloader).
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (3):
>   dt-bindings: mmc: Add HI3670 MMC controller binding
>   arm64: dts: hisilicon: hi3670: Add MMC controller support
>   arm64: dts: hisilicon: hikey970: Add SD and WiFi support
> 
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt    |   2 +
>  .../boot/dts/hisilicon/hi3670-hikey970.dts    |  75 ++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  37 ++++++
>  .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 115 ++++++++++++++++++
>  4 files changed, 229 insertions(+)
> 

Thanks!
Applied the series to the hisilicon dts tree with the order.

Best Regards,
Wei

