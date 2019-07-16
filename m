Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6631C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1292173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FKSFGu7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbfGPKow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:44:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58864 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732524AbfGPKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:44:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6GAiism017500;
        Tue, 16 Jul 2019 05:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563273884;
        bh=xAUeoAyBbOBCb3mEnXWmyizdBhqwUzcNWgmgEUmhoeI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FKSFGu7JJ2KD4x1wu8mJ0wJw9dC9x0iMgIeiYpYtbNMsj4UDPDXXResfNsD/50bSd
         nzJNjkoJISnwf9eOUM11U65sTxYBDzN7H4KkuzIuwdO+rl6J67697A8gjteVBCPzT5
         678muO2ndffPko7HCBQsYZ0dSmj2QLx8vtcP2MMM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6GAiiju091125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 05:44:44 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 05:44:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 05:44:43 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6GAie9C058777;
        Tue, 16 Jul 2019 05:44:41 -0500
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
From:   grygorii <grygorii.strashko@ti.com>
Message-ID: <a2dae3a5-7e25-1de0-e722-8860b58cb3a2@ti.com>
Date:   Tue, 16 Jul 2019 16:14:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
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



On 06/07/2019 05:18, santosh.shilimkar@oracle.com wrote:
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

Thank you

-- 
Best regards,
grygorii
