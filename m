Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC2FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E5720825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BFSW/p+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390745AbfIETdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:33:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38226 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbfIETdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:33:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x85JXVf1013274;
        Thu, 5 Sep 2019 14:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567712012;
        bh=kkAMWtH2lSDWQdmzGtIiji4XCoqJUTR6qG2fZ+Vzpqc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BFSW/p+jNL5LX1/ko200OssuvJytWR4GBiX5gGhcP6SgNOs8u+6qORlPMLg51rKtj
         0vCvmEn+3EbUhSaOjeBRWK76TR3XuFDIlJTQRe9Ojl2DmYFTOYeaEQB81AIuiGulUl
         SBSi6TnBnrlfsND5HFXVJUcEI8XhXfPFptAFxl7k=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x85JXVeO012448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Sep 2019 14:33:31 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 5 Sep
 2019 14:33:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 5 Sep 2019 14:33:31 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x85JXSQZ069292;
        Thu, 5 Sep 2019 14:33:29 -0500
Subject: Re: [RESEND PATCH next v2 0/6] ARM: keystone: update dt and enable
 cpts support
To:     <santosh.shilimkar@oracle.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190705151247.30422-1-grygorii.strashko@ti.com>
 <2ef8b34e-7a6e-b3e4-90e0-c4e7f16c2e99@oracle.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <323c1835-e6b0-9153-8d1e-06200d5e2201@ti.com>
Date:   Thu, 5 Sep 2019 22:33:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2ef8b34e-7a6e-b3e4-90e0-c4e7f16c2e99@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On 06/07/2019 02:48, santosh.shilimkar@oracle.com wrote:
> On 7/5/19 8:12 AM, Grygorii Strashko wrote:
>> Hi Santosh,
>>
>> This series is set of platform changes required to enable NETCP CPTS reference
>> clock selection and final patch to enable CPTS for Keystone 66AK2E/L/HK SoCs.
>>
>> Those patches were posted already [1] together with driver's changes, so this
>> is re-send of DT/platform specific changes only, as driver's changes have
>> been merged already.
>>
>> Patches 1-5: CPTS DT nodes update for TI Keystone 2 66AK2HK/E/L SoCs.
>> Patch 6: enables CPTS for TI Keystone 2 66AK2HK/E/L SoCs.
>>
>> [1] https://patchwork.kernel.org/cover/10980037/
>>
>> Grygorii Strashko (6):
>>    ARM: dts: keystone-clocks: add input fixed clocks
>>    ARM: dts: k2e-clocks: add input ext. fixed clocks tsipclka/b
>>    ARM: dts: k2e-netcp: add cpts refclk_mux node
>>    ARM: dts: k2hk-netcp: add cpts refclk_mux node
>>    ARM: dts: k2l-netcp: add cpts refclk_mux node
>>    ARM: configs: keystone: enable cpts
>>
> Will add these for 5.4 queue. Thanks !!

Sry, that I'm disturbing you, but I do not see those patches applied?



-- 
Best regards,
grygorii
