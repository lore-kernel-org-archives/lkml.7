Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE77C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AF321582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="K6OZ4CJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfL0Vfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:35:37 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7363 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfL0Vfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:35:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e06791a0000>; Fri, 27 Dec 2019 13:35:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Dec 2019 13:35:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Dec 2019 13:35:35 -0800
Received: from [10.2.173.37] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Dec
 2019 21:35:34 +0000
Subject: Re: [PATCH v5 07/19] dt-bindings: soc: tegra-pmc: Add id for Tegra
 PMC 32KHz blink clock
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-8-git-send-email-skomatineni@nvidia.com>
 <20191226181715.GA12506@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <fe48ca0e-c26e-5163-fb66-1eefe5f45bcc@nvidia.com>
Date:   Fri, 27 Dec 2019 13:35:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191226181715.GA12506@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577482522; bh=gjae7kUQaHVIjpNoyPiSKLPGAI2ivNMWILmjltYeLiE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=K6OZ4CJq4Va8v7nnJpw/+SiozblG0ejHVQsa4F2FrFQEl9IWWdC1lGgHOQC9Aszkb
         +frfb7f8J7BIy4fRS3KvrG4xuxn5yTJW1KJbf49h0gqJSxLqV+q9Z/KPbI3oMVKJoW
         C8x/6pPBkSz095930A1d1vZZ+cWYY1NCnU0R7wQ0LrXeCayKSIIPreujOn+WJtAlUD
         CH7ogj04glhJDaH6ZjujErBe0uYUSun1veNeBGjM2vdJK6fi1XCkWq/EDRiSl8lW2M
         F2nRwqhDRcZAi7t9j1Cml1YYzLd7ngOwu/GRBJP8llqblgDAHgE4S7ORtRPsDeRd/l
         9583OhnWmtjdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/26/19 10:17 AM, Rob Herring wrote:
> On Fri, 20 Dec 2019 14:26:53 -0800, Sowjanya Komatineni wrote:
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
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Sorry Rob, missed to add Acked-by tag for this patch in this series.

Will make sure of having all received Acked-by/Reviewed-by tags from 
next time.

