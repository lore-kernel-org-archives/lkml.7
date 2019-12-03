Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA132C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C12084F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="c5bT86/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfLCWTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:19:19 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12841 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfLCWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:19:19 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de6df570000>; Tue, 03 Dec 2019 14:19:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Dec 2019 14:19:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Dec 2019 14:19:17 -0800
Received: from [10.2.160.125] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Dec
 2019 22:19:15 +0000
Subject: Re: [PATCH v1 03/17] dt-bindings: soc: tegra-pmc: Add Tegra PMC clock
 ids
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <mark.rutland@arm.com>,
        <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-4-git-send-email-skomatineni@nvidia.com>
 <20191203220850.GB22716@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <50f7db27-a1bd-6e2a-0994-82740b4ef6cb@nvidia.com>
Date:   Tue, 3 Dec 2019 14:19:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191203220850.GB22716@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575411543; bh=0IKNAVktirUsylXHSyz6GuS3zjLJXwqxN2fIYWCdxn0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=c5bT86/Lv5nwl2ZV/7cNK6nZUqNWH+hTofWP+zr42J7cZxRwZaDohpOZXOBESZgSZ
         +iLN7mElqBL1NvU1sgN23Aq1PeloHw+ehrQoNT1lXidQxMXxT4Mm9896JWpAyNEsuu
         fUdZ22RXQLrky3mP2Cgpcq4q5chC3D9ijEh/ejsStO59IbUVIFUGGT530na4AhjcMM
         nxB3rMtqFIGmshurtdKOIJfCD7mee0YVo4D6ansUoakxTdeY2TVLVRfN/2L2sbAx1/
         XH2UfVAUFzdMn2z6TZMmQtOaO2DIgjSunkFOv/rmZwnJRWzkTNzRcJRk2dsqXgVTLz
         q26YdTfOyF5ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/19 2:08 PM, Rob Herring wrote:
> On Mon, Nov 18, 2019 at 10:50:20PM -0800, Sowjanya Komatineni wrote:
>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 clocks and each of
>> these clocks has mux and a gate as a part of PMC controller.
>>
>> This patch adds ids for each of these PMC clock mux and gates to
>> use with the devicetree.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   include/dt-bindings/soc/tegra-pmc.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>   create mode 100644 include/dt-bindings/soc/tegra-pmc.h
> This should be part of the binding patch.
ok, will combine in v3
>> diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
>> new file mode 100644
>> index 000000000000..fa1ccfc2514b
>> --- /dev/null
>> +++ b/include/dt-bindings/soc/tegra-pmc.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2019-2020, NVIDIA CORPORATION.  All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_SOC_TEGRA_PMC_H
>> +#define _DT_BINDINGS_SOC_TEGRA_PMC_H
>> +
>> +#define TEGRA_PMC_CLK_OUT_1_MUX		0
>> +#define TEGRA_PMC_CLK_OUT_1		1
>> +#define TEGRA_PMC_CLK_OUT_2_MUX		2
>> +#define TEGRA_PMC_CLK_OUT_2		3
>> +#define TEGRA_PMC_CLK_OUT_3_MUX		4
>> +#define TEGRA_PMC_CLK_OUT_3		5
>> +
>> +#endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
>> -- 
>> 2.7.4
>>
