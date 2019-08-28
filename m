Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A9E21883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfH1BdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:33:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:12709 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfH1BdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:33:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 18:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="355955307"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2019 18:33:18 -0700
Received: from [10.226.38.21] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id 484585800BD;
        Tue, 27 Aug 2019 18:33:15 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: sdhci-of-arasan: Add new
 compatible for Intel LGM eMMC
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAPDyKFpsvZ+LEwY91LiSExgm=4g=BhWNpkkJMniBNff+qch-QA@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <32e50682-9f5a-e0d2-f2d4-a72d0bb35f17@linux.intel.com>
Date:   Wed, 28 Aug 2019 09:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpsvZ+LEwY91LiSExgm=4g=BhWNpkkJMniBNff+qch-QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 27/8/2019 9:49 PM, Ulf Hansson wrote:
> On Mon, 26 Aug 2019 at 09:28, Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a new compatible to use the sdhc-arasan host controller driver
>> with the eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Applied for next, thanks!
>
> Kind regards
> Uffe

Thank you so much for review and applied for next.

Best Regards
Vadivel
>
>> ---
>>   Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 1edbb049cccb..7ca0aa7ccc0b 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -17,6 +17,8 @@ Required Properties:
>>         For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>>       - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
>>          Note: This binding has been deprecated and moved to [5].
>> +    - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
>> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>>
>>     [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>>
>> @@ -80,3 +82,18 @@ Example:
>>                  phy-names = "phy_arasan";
>>                  #clock-cells = <0>;
>>          };
>> +
>> +       emmc: sdhci@ec700000 {
>> +               compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
>> +               reg = <0xec700000 0x300>;
>> +               interrupt-parent = <&ioapic1>;
>> +               interrupts = <44 1>;
>> +               clocks = <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
>> +                        <&cgu0 LGM_GCLK_EMMC>;
>> +               clock-names = "clk_xin", "clk_ahb", "gate";
>> +               clock-output-names = "emmc_cardclock";
>> +               #clock-cells = <0>;
>> +               phys = <&emmc_phy>;
>> +               phy-names = "phy_arasan";
>> +               arasan,soc-ctl-syscon = <&sysconf>;
>> +       };
>> --
>> 2.11.0
>>
