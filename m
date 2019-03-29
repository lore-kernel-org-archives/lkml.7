Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA222184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hVK3w+9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfC2ODU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:03:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37030 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfC2ODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:03:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TE2Ut5085287;
        Fri, 29 Mar 2019 09:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553868150;
        bh=GagjIuOtTTI72XfIKpfHHE74VyvZGLZXg0U0l23SESY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hVK3w+9WQvChK/a6eeD+ScUKf2LhysDk0GsTnET7ml0vcdhrju6BK5L45zG56ny+d
         wjBGB375JPcjtkI/jB/TZQ6kxvHvgH/t6ZEmfIZw9V3o83y4Ptsribx061VwNCmW7u
         Eh16dBILy1i29bDiC3dPM6i45+lxbStgPpMRA4Io=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TE2URa093040
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:02:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 09:02:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 09:02:29 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TE2Q4f053476;
        Fri, 29 Mar 2019 09:02:26 -0500
Subject: Re: [PATCH 3/4] ARM: dts: dra7: add PRU-ICSS modules
To:     Tony Lindgren <tony@atomide.com>
CC:     <s-anna@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-4-git-send-email-rogerq@ti.com>
 <20190204180359.GM5720@atomide.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <454fbfc1-e05b-494e-6e27-0945ebed0154@ti.com>
Date:   Fri, 29 Mar 2019 16:02:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190204180359.GM5720@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 04/02/2019 20:03, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190204 15:54]:
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -167,6 +167,200 @@
>>  		l4_per3: interconnect@48800000 {
>>  		};
>>  
>> +		pru_icss1: target-module@4b200000 {
> 
> I suggest you add these into dra7-pruss.dtsi as they
> have internal interconnects. And eventually some of
> the *pruss.dtsi files might become shared :) And we
> avoid moving these around when we define the l3
> interconnects and avoid a lot of extra long dtsi
> line lengths with the added nestedness later on.

PRUSS is only present on AM57x variants.
I will move this to am57x-pruss.dtsi.

This means all AM57x boards will have to include it.

Is this OK?

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
