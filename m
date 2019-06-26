Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC3C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F8221670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kOdAPlvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfFZOnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:43:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:43:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5QEgYSO026643;
        Wed, 26 Jun 2019 09:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561560154;
        bh=JQTsc372ZbtieW6Fo3QsbkjZrLLE5ueFi63b7dRTl4c=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=kOdAPlvju6ImTTkUKJpjLOaQbVwlSty9CUpFjGolXUM/l/Y1TvDpAlIcJj8kqo/P9
         OXZRDV+CAYR1DjQAP/57Z5/0okfurKo9+2WzM2kblpSl2aVMXbd/Iv1J1sWUkX7K5g
         TnxoIRX+kXX7gyrpx4ZPallDebew116A7zzBBn10=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5QEgYjd113018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 09:42:34 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 26
 Jun 2019 09:42:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 26 Jun 2019 09:42:34 -0500
Received: from [10.250.96.121] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5QEgTNu089437;
        Wed, 26 Jun 2019 09:42:30 -0500
Subject: Re: [RFC PATCH v4 net-next 10/11] ARM: dts: am57xx-idk: add dt nodes
 for new cpsw switch dev driver
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <20190621181314.20778-1-grygorii.strashko@ti.com>
 <20190621181314.20778-11-grygorii.strashko@ti.com>
 <20190625224953.GD6485@khorivan>
From:   grygorii <grygorii.strashko@ti.com>
Message-ID: <311aa679-2656-ad1c-d2fb-b16efa1c33c4@ti.com>
Date:   Wed, 26 Jun 2019 17:42:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625224953.GD6485@khorivan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/06/2019 01:49, Ivan Khoronzhuk wrote:
> On Fri, Jun 21, 2019 at 09:13:13PM +0300, Grygorii Strashko wrote:
>> Add DT nodes for new cpsw switch dev driver.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> arch/arm/boot/dts/am571x-idk.dts         | 28 +++++++++++++
>> arch/arm/boot/dts/am572x-idk.dts         |  5 +++
>> arch/arm/boot/dts/am574x-idk.dts         |  5 +++
>> arch/arm/boot/dts/am57xx-idk-common.dtsi |  2 +-
>> arch/arm/boot/dts/dra7-l4.dtsi           | 53 ++++++++++++++++++++++++
>> 5 files changed, 92 insertions(+), 1 deletion(-)
>>
> 
> [...]
> 
>> diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
>> index f7bd26458915..5c7663699efa 100644
>> --- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
>> +++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
>> @@ -367,7 +367,7 @@
>> };
>>
>> &mac {
>> -    status = "okay";
>> +//    status = "okay";
> ?

This i'm going to clean up as part of next submission.

-- 
Best regards,
grygorii
