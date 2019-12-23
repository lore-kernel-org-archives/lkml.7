Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D17AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BFE206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mIotBoYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLWMed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:34:33 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33970 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLWMed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:34:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNCYQVr111236;
        Mon, 23 Dec 2019 06:34:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577104466;
        bh=luhAp8x69B7pBfJnUY11gQs7GAIFTA9VMCqiV9I3CoQ=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=mIotBoYGH4Wi7Q9O+3qotWB+ABYFvbtwgbueUsDd5dfMbszs27BJ4fH7TEoM1ubUE
         nIpGpI/remtyz4jjNyur5FQeAFHzEGC6YREwrKOwKM24+rEeGOBvFz3C2kKv/ElQBA
         lzmY33F5ani98+ZOunZccsrai42KzsSMKcN7Dy5s=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNCYQGc028128
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 06:34:26 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 06:34:24 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 06:34:24 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNCYLSk080203;
        Mon, 23 Dec 2019 06:34:22 -0600
Subject: Re: [PATCH v1] phy: Add DisplayPort configuration options
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>
CC:     <praneeth@ti.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>
References: <1577084071-5332-1-git-send-email-yamonkar@cadence.com>
 <ca6d9a16-0cba-cde7-f60c-75305f88bf33@ti.com>
Message-ID: <64987727-12bd-ec92-ff80-0b3c330b12a3@ti.com>
Date:   Mon, 23 Dec 2019 18:06:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ca6d9a16-0cba-cde7-f60c-75305f88bf33@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Maxime (Fixed Maxime's email address)

On 23/12/19 5:57 PM, Kishon Vijay Abraham I wrote:
> + Maxime
> 
> Hi,
> 
> On 23/12/19 12:24 PM, Yuti Amonkar wrote:
>> Allow DisplayPort PHYs to be configured through the generic
>> functions through a custom structure added to the generic union.
>> The configuration structure is used for reconfiguration of
>> DisplayPort PHYs during link training operation.
>>
>> The parameters added here are the ones defined in the DisplayPort
>> spec which include link rate, number of lanes, voltage swing
>> and pre-emphasis.
> 
> Which version of display port specification?
> 
> Rest of commit log should move below the "---"
> 
> 
>>
>> This patch was a part of [1] series earlier but we think that it needs
>> to have a separate attention of the reviewers. Also as both [1] & [2] are
>> dependent on this patch, our sincere request to reviewers to have a
>> faster review of this patch.
>>
>> [1]
>>
>> https://lkml.org/lkml/2019/12/11/455
>>
>> [2]
>>
>> https://patchwork.kernel.org/cover/11271191/
> 
> Thanks
> Kishon
> 
>>
>> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
>> ---
>>   include/linux/phy/phy-dp.h | 95
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/phy/phy.h    |  4 ++
>>   2 files changed, 99 insertions(+)
>>   create mode 100644 include/linux/phy/phy-dp.h
>>
>> diff --git a/include/linux/phy/phy-dp.h b/include/linux/phy/phy-dp.h
>> new file mode 100644
>> index 0000000..18cad23
>> --- /dev/null
>> +++ b/include/linux/phy/phy-dp.h
>> @@ -0,0 +1,95 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2019 Cadence Design Systems Inc.
>> + */
>> +
>> +#ifndef __PHY_DP_H_
>> +#define __PHY_DP_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/**
>> + * struct phy_configure_opts_dp - DisplayPort PHY configuration set
>> + *
>> + * This structure is used to represent the configuration state of a
>> + * DisplayPort phy.
>> + */
>> +struct phy_configure_opts_dp {
>> +    /**
>> +     * @link_rate:
>> +     *
>> +     * Link Rate, in Mb/s, of the main link.
>> +     *
>> +     * Allowed values: 1620, 2160, 2430, 2700, 3240, 4320, 5400, 8100
>> Mb/s
>> +     */
>> +    unsigned int link_rate;
>> +
>> +    /**
>> +     * @lanes:
>> +     *
>> +     * Number of active, consecutive, data lanes, starting from
>> +     * lane 0, used for the transmissions on main link.
>> +     *
>> +     * Allowed values: 1, 2, 4
>> +     */
>> +    unsigned int lanes;
>> +
>> +    /**
>> +     * @voltage:
>> +     *
>> +     * Voltage swing levels, as specified by DisplayPort specification,
>> +     * to be used by particular lanes. One value per lane.
>> +     * voltage[0] is for lane 0, voltage[1] is for lane 1, etc.
>> +     *
>> +     * Maximum value: 3
>> +     */
>> +    unsigned int voltage[4];
>> +
>> +    /**
>> +     * @pre:
>> +     *
>> +     * Pre-emphasis levels, as specified by DisplayPort
>> specification, to be
>> +     * used by particular lanes. One value per lane.
>> +     *
>> +     * Maximum value: 3
>> +     */
>> +    unsigned int pre[4];
>> +
>> +    /**
>> +     * @ssc:
>> +     *
>> +     * Flag indicating, whether or not to enable spread-spectrum
>> clocking.
>> +     *
>> +     */
>> +    u8 ssc : 1;
>> +
>> +    /**
>> +     * @set_rate:
>> +     *
>> +     * Flag indicating, whether or not reconfigure link rate and SSC to
>> +     * requested values.
>> +     *
>> +     */
>> +    u8 set_rate : 1;
>> +
>> +    /**
>> +     * @set_lanes:
>> +     *
>> +     * Flag indicating, whether or not reconfigure lane count to
>> +     * requested value.
>> +     *
>> +     */
>> +    u8 set_lanes : 1;
>> +
>> +    /**
>> +     * @set_voltages:
>> +     *
>> +     * Flag indicating, whether or not reconfigure voltage swing
>> +     * and pre-emphasis to requested values. Only lanes specified
>> +     * by "lanes" parameter will be affected.
>> +     *
>> +     */
>> +    u8 set_voltages : 1;
>> +};
>> +
>> +#endif /* __PHY_DP_H_ */
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index 15032f14..ba0aab5 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -16,6 +16,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regulator/consumer.h>
>>   +#include <linux/phy/phy-dp.h>
>>   #include <linux/phy/phy-mipi-dphy.h>
>>     struct phy;
>> @@ -46,9 +47,12 @@ enum phy_mode {
>>    *
>>    * @mipi_dphy:    Configuration set applicable for phys supporting
>>    *        the MIPI_DPHY phy mode.
>> + * @dp:        Configuration set applicable for phys supporting
>> + *        the DisplayPort protocol.
>>    */
>>   union phy_configure_opts {
>>       struct phy_configure_opts_mipi_dphy    mipi_dphy;
>> +    struct phy_configure_opts_dp        dp;
>>   };
>>     /**
>>
