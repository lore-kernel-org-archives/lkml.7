Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE441C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDCD2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfCYNjl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:39:41 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:40717 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbfCYNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:39:41 -0400
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:62031 helo=[10.2.146.249])
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1h8Pot-0001Ei-2Z; Mon, 25 Mar 2019 14:39:21 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-arasan: Add DTS property to disable
 DCMDs.
From:   =?utf-8?Q?Christoph_M=C3=BCllner?= 
        <christoph.muellner@theobroma-systems.com>
In-Reply-To: <CAPDyKFrDq-zBsqqe23hj4ynfYnrGxAr0tWxvYEJu8Kvh0i=h9A@mail.gmail.com>
Date:   Mon, 25 Mar 2019 14:39:14 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Randy Li <ayaka@soulik.info>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2D2515D6-1E11-4EA3-B016-EC37A9E3091D@theobroma-systems.com>
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
 <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
 <CAPDyKFrDq-zBsqqe23hj4ynfYnrGxAr0tWxvYEJu8Kvh0i=h9A@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 25.03.2019, at 14:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
> <christoph.muellner@theobroma-systems.com> wrote:
>> 
>> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
>> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
>> which exposes a control register bit to enable the feature.
>> The current implementation sets this bit unconditionally.
>> 
>> This patch allows to suppress the feature activation,
>> by specifying the property disable-cqe-dcmd.
>> 
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Applied for next, thanks!
> 
> Perhaps both patch1 and patch2 should be tagged for stable? Then
> please tell me and I can add a tag.

Hi Ulf,

yes tagging for stable would be nice.
I guess, the following would fit:

Fixes: 84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1")

Thanks,
Christoph

> 
> Kind regards
> Uffe
> 
> 
> 
>> ---
>> drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index c9e3e050ccc8..88dc3f00a5be 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>                host->mmc_host_ops.start_signal_voltage_switch =
>>                                        sdhci_arasan_voltage_switch;
>>                sdhci_arasan->has_cqe = true;
>> -               host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>> +               host->mmc->caps2 |= MMC_CAP2_CQE;
>> +
>> +               if (!of_property_read_bool(np, "disable-cqe-dcmd"))
>> +                       host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>>        }
>> 
>>        ret = sdhci_arasan_add_host(sdhci_arasan);
>> --
>> 2.11.0
>> 

