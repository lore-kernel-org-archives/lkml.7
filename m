Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1970CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8D62089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QcUswP8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633654AbfJRMW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:22:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39952 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442702AbfJRMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:22:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9ICMnuH077834;
        Fri, 18 Oct 2019 07:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571401369;
        bh=4iYQo7IvLqWbw0SSz1RqLvclFmxicJcx/8FoZq6ZB9I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QcUswP8a+bYP/LQW+nLcBQNuD2xO/QjoAUfojpc0YGViLhqK9Buy5N+7cw6OFjO+z
         I3iTY7XJFVla74ZkSkdxAQNJNUrxQbhDc267smMs2qn8qN3jwrJ1cNpChFnsjrHOYj
         1KF02I16vlGQm2idI85+CyavUrJdznTeca255buc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9ICMnMm087532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Oct 2019 07:22:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 18
 Oct 2019 07:22:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 18 Oct 2019 07:22:49 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9ICMlbs095303;
        Fri, 18 Oct 2019 07:22:47 -0500
Subject: Re: [PATCH 0/2] Add Support for MMC/SD for J721e-base-board
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <nm@ti.com>, <robh+dt@kernel.org>
References: <20190919153242.29399-1-faiz_abbas@ti.com>
 <f176e389-d181-8848-2bce-6680232b8fa8@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <b70ec99a-58af-3969-d32d-202f7aaec33a@ti.com>
Date:   Fri, 18 Oct 2019 15:22:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f176e389-d181-8848-2bce-6680232b8fa8@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 12:57, Faiz Abbas wrote:
> Hi,
> 
> On 19/09/19 9:02 PM, Faiz Abbas wrote:
>> The following are dts patches to add MMC/SD Support on TI's J721e base
>> board.
>>
>> Patches depend on Lokesh's gpio patches[1] and device exclusivity patches[2].
>>
>> [1] https://patchwork.kernel.org/cover/11085643/
>> [2] https://patchwork.kernel.org/cover/11051559/
>>
>> Faiz Abbas (2):
>>    arm64: dts: ti: j721e-main: Add SDHCI nodes
>>    arm64: dts: ti: j721e-common-proc-board: Add Support for eMMC and SD
>>      card
>>
>>   .../dts/ti/k3-j721e-common-proc-board.dts     | 34 +++++++++++++
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 50 +++++++++++++++++++
>>   2 files changed, 84 insertions(+)
>>
> 
> Gentle ping.

Queuing up towards 5.5, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
