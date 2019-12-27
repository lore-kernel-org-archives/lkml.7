Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE7C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD6421582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b+nDy6/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfL0Var (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:30:47 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7227 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0Var (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:30:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0677f80000>; Fri, 27 Dec 2019 13:30:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Dec 2019 13:30:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Dec 2019 13:30:46 -0800
Received: from [10.2.173.37] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Dec
 2019 21:30:43 +0000
Subject: Re: [PATCH v5 07/19] dt-bindings: soc: tegra-pmc: Add id for Tegra
 PMC 32KHz blink clock
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-8-git-send-email-skomatineni@nvidia.com>
 <c8a847fb-3d23-6e1e-59e2-a2d15b63ce02@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <b46c21ca-855e-cd81-ab8d-aa96b61ebb56@nvidia.com>
Date:   Fri, 27 Dec 2019 13:30:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c8a847fb-3d23-6e1e-59e2-a2d15b63ce02@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577482233; bh=1s3ZRlg3eLuA98uNtu0u1vLni2lsH91p6tEmhgqylhw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=b+nDy6/5A6GRzEUimt6Var6U6fQv34a8k3GLOuEB7/RmK8nruLnbuSgmzNLma/mMR
         kgHZGfW99Nw9z7eI67wjRwWZHNJ8LbpwNu+gQ3TxzK5bez7JWF1CTX7J5soUs2lFnW
         0WrThuFTNG1Ci69NrQcy2Eoq5+qoDtPtiUG0uI3TQPwzfhLAmBN8RMuxuoHLd7XB9u
         rYZl1/xGRyj3ZoS8/d6pseAEtcpkUE3uZKLAWr3DxyVk832WcXld9ll7tc2XgOelqN
         kSgrQY/sFMWIY9/Z9fu+vsyf0LQ6/SatkJQ0q5ce1MKXqvstbDlK0ZCOIB82aDXCoc
         03/0Xbb3LZ7Nw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/22/19 1:55 PM, Dmitry Osipenko wrote:
> 21.12.2019 01:26, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Tegra PMC has blink functionality that allows 32KHz clock out to
>> blink pin of the Tegra.
>>
>> This patch adds id for this blink clock to use for enabling or
>> disabling blink output through device tree.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   include/dt-bindings/soc/tegra-pmc.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/s=
oc/tegra-pmc.h
>> index f7c866404456..a99a457471ee 100644
>> --- a/include/dt-bindings/soc/tegra-pmc.h
>> +++ b/include/dt-bindings/soc/tegra-pmc.h
>> @@ -9,7 +9,8 @@
>>   #define TEGRA_PMC_CLK_OUT_1		0
>>   #define TEGRA_PMC_CLK_OUT_2		1
>>   #define TEGRA_PMC_CLK_OUT_3		2
>> +#define TEGRA_PMC_CLK_BLINK		3
>>  =20
>> -#define TEGRA_PMC_CLK_MAX		3
>> +#define TEGRA_PMC_CLK_MAX		4
>>  =20
>>   #endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
>>
> Could you please explain the reason of separating CLK_OUT and BLINK PMC
> patches?
No specific reason just thought to have BLINK as separate patch as its=20
different register configuration to have fixed 32Khz clock out.
>
> Also, you only documented CLK_OUT clocks in the DT binding and no BLINK.
missed to add BLINK to dt-binding doc. Will add in v6.
