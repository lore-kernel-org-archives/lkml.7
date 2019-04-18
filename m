Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A48EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ED520643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbfDRSYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:24:46 -0400
Received: from david.siemens.de ([192.35.17.14]:49281 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391567AbfDRSYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:24:37 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x3IIOT2r028860
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 20:24:30 +0200
Received: from [139.22.35.105] ([139.22.35.105])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x3IIOS7i027425;
        Thu, 18 Apr 2019 20:24:29 +0200
Subject: Re: [PATCH] stmmac: pci: Adjust IOT2000 matching
To:     David Miller <davem@davemloft.net>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        baocheng.su@siemens.com, andy.shevchenko@gmail.com
References: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
 <20190418.104344.957038152341042514.davem@davemloft.net>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <642a6059-8a28-b995-919f-68d03200ee11@siemens.com>
Date:   Thu, 18 Apr 2019 20:24:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190418.104344.957038152341042514.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.19 19:43, David Miller wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Date: Thu, 18 Apr 2019 11:14:56 +0200
> 
>> @@ -170,8 +176,6 @@ static const struct dmi_system_id quark_pci_dmi[] = {
>>   	{
>>   		.matches = {
>>   			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
>> -			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
>> -					"6ES7647-0AA00-1YA2"),
>>   		},
>>   		.driver_data = (void *)&iot2040_stmmac_dmi_data,
> 
> So really, every IOT2000 that doesn't have the IOT2020 asset tag will be
> a 2040?  Forever?
> 

Yes, seriously. The next version won't have all that DMI and ACPI stuff. And if 
there will ever be a version with that again, it will not be labeled "IOT2000" 
via the board name entry. And it will have more robust hardware discovery as 
well. Lesson(s) learned, in fact not only for this product series.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
