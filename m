Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE0C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0E920663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfDRG3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:29:14 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:41071 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfDRG3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:29:13 -0400
X-IronPort-AV: E=Sophos;i="5.60,364,1549922400"; 
   d="scan'208";a="217000148"
Subject: Re: [PATCH v2 1/2] power: reset: nvmem-reboot-mode: use NVMEM as
 reboot mode write interface
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20190411055341.9263-1-nandor.han@vaisala.com>
 <20190411055341.9263-2-nandor.han@vaisala.com>
 <20190417215649.ejrvd6zekfmvjtn5@earth.universe>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <b046dc29-002c-39a9-5a54-562c49adb691@vaisala.com>
Date:   Thu, 18 Apr 2019 09:29:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190417215649.ejrvd6zekfmvjtn5@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2019 06:29:08.0317 (UTC) FILETIME=[071FF0D0:01D4F5B0]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 12:56 AM, Sebastian Reichel wrote:
> On Thu, Apr 11, 2019 at 05:54:09AM +0000, Han Nandor wrote:
>> Add a new reboot mode write interface that is using an NVMEM cell
>> to store the reboot mode magic.
>>
>> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
>> ---

<snip>

>> +module_platform_driver(nvmem_reboot_mode_driver);
>> +
>> +MODULE_AUTHOR("Nandor Han <nandor.han@vaisala.com>");
>> +MODULE_DESCRIPTION("NVMEM reboot mode driver");
>> +MODULE_LICENSE("GPL v2");
> 
> I suppose as of bf7fbeeae6db "GPL v2" is deprecated, before it was
> often read as GPL v2 only. In both cases it makes sense to just
> use "GPL". Otherwise the driver looks fine to me, but I'm waiting
> for Rob's review of the DT bindings before merging this.
> 
> -- Sebastian
> 

Thanks Sebastian.

Do you want me to send a new revision with license changed to "GPL"?..or 
will you change it when it's merged?

Nandor
