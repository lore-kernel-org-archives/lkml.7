Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3ADC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA542168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIDOmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:42:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729965AbfIDOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:42:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AF49BB8E4149F22B28EE;
        Wed,  4 Sep 2019 22:42:15 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 22:42:10 +0800
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
To:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
CC:     <broonie@kernel.org>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <shc_work@mail.ru>, <agross@kernel.org>, <khilman@baylibre.com>,
        <matthias.bgg@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <kgene@kernel.org>,
        Andi Shyti <andi@etezian.org>, <palmer@sifive.com>,
        <paul.walmsley@sifive.com>, <baohua@kernel.org>,
        <mripard@kernel.org>, <wens@csie.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <yamada.masahiro@socionext.com>, <michal.simek@xilinx.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-tegra@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <3595bac1-e426-b4f9-4e24-01e104fdfe5d@huawei.com>
Date:   Wed, 4 Sep 2019 22:42:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/4 22:28, Krzysztof Kozlowski wrote:
> On Wed, 4 Sep 2019 at 16:00, YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
> 
> This tag does not look real... First of all where is the report?

It is our internal CI robot, which is unavailable to external temporarily.

> Second, it was reported by coccinelle.
> Reported-by should be use to give real credits.
> 
> Best regards,
> Krzysztof
> 
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/spi/spi-s3c24xx.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
>> index aea8fd9..2d6e37f 100644
>> --- a/drivers/spi/spi-s3c24xx.c
>> +++ b/drivers/spi/spi-s3c24xx.c
>> @@ -487,7 +487,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>>         struct s3c2410_spi_info *pdata;
>>         struct s3c24xx_spi *hw;
>>         struct spi_master *master;
>> -       struct resource *res;
>>         int err = 0;
>>
>>         master = spi_alloc_master(&pdev->dev, sizeof(struct s3c24xx_spi));
>> @@ -536,8 +535,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>>         dev_dbg(hw->dev, "bitbang at %p\n", &hw->bitbang);
>>
>>         /* find and map our resources */
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       hw->regs = devm_ioremap_resource(&pdev->dev, res);
>> +       hw->regs = devm_platform_ioremap_resource(pdev, 0);
>>         if (IS_ERR(hw->regs)) {
>>                 err = PTR_ERR(hw->regs);
>>                 goto err_no_pdata;
>> --
>> 2.7.4
>>
>>
> 
> .
> 

