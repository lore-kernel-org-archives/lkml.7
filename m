Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A311C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E944E20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jXVeOMEW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UdAN+1qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfCaM1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:27:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38510 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:27:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8341F60790; Sun, 31 Mar 2019 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554035235;
        bh=zpshEU7cC/MWxSqfJ58hclwKbUXruOyuWJzaYd1nGRA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=jXVeOMEWaPQ/6Ty2Myr6OgRGG00XGNllJ4+xtlWP03rrIyRZZUvZJ7TbxP39PIcN6
         7bh149SBKlfwxloyG6R288s4h+ZOz8J4liUXjcYO9yuiWVOesAlG4cdVzprorf2C7Y
         wfp+ctyrK5mpLM6CcmNDNAQmPtX+9g/Q8B5sDwtQ=
Received: from [10.79.164.251] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AAE7602F8;
        Sun, 31 Mar 2019 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554035234;
        bh=zpshEU7cC/MWxSqfJ58hclwKbUXruOyuWJzaYd1nGRA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=UdAN+1qSJuwYEzDAkD7CverBi+etpYJv/atdzk7Mm/4738Kjkj9dkdNNMWW1Z/83Y
         30DYgmJ3MOEY3dkB+CP+Zt/0LBkvEXgVXvLiEo30VgzQLcVp+O+ZQ2z0KLh7DwrQzn
         IYumWss+puYfxJUj/i5LjX9dvJpPufv/eYWz1Sm8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AAE7602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] drivers/staging: Fix styling of the comment related to
 SPDX-License-Identifier in vt6656/*.h
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     Ojaswin Mujoo <ojaswin25111998@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190331073825.GA9087@gmail.com>
 <1554023786-12066-1-git-send-email-ojaswin25111998@gmail.com>
 <c99d1c58-f4c0-d83f-7a09-18272c11aa9c@codeaurora.org>
Message-ID: <8ac32dc2-c8a3-b067-eb43-32747f8ac331@codeaurora.org>
Date:   Sun, 31 Mar 2019 17:57:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c99d1c58-f4c0-d83f-7a09-18272c11aa9c@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2019 5:49 PM, Mukesh Ojha wrote:
>
> On 3/31/2019 2:44 PM, Ojaswin Mujoo wrote:
>> Fix checkpatch.pl styling error related to SPDX-License-Identifier
>> comment in vt6656/*.h
>> * v2: fix patch styling
> Above line should be after ---.
>>
>> Signed-off-by: Ojaswin Mujoo <ojaswin25111998@gmail.com>
>
> Although, it looks ok to me. but this is spread through out the tree 
> and a result of a copy paste.
>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> But, i would want other to comment on this, whether we really want 
> this kind of effort coming forward.
>
> or can it  be not done by some scripting?


Found the discussion and the script at https://lkml.org/lkml/2019/2/7/46.

Let's do that.

>
>
> Cheers,
> -Mukesh
>
>
>> ---
>>   drivers/staging/vt6656/baseband.h | 2 +-
>>   drivers/staging/vt6656/card.h     | 2 +-
>>   drivers/staging/vt6656/channel.h  | 2 +-
>>   drivers/staging/vt6656/desc.h     | 2 +-
>>   drivers/staging/vt6656/device.h   | 2 +-
>>   drivers/staging/vt6656/dpc.h      | 2 +-
>>   drivers/staging/vt6656/firmware.h | 2 +-
>>   drivers/staging/vt6656/int.h      | 2 +-
>>   drivers/staging/vt6656/key.h      | 2 +-
>>   drivers/staging/vt6656/power.h    | 2 +-
>>   drivers/staging/vt6656/rf.h       | 2 +-
>>   drivers/staging/vt6656/rxtx.h     | 2 +-
>>   drivers/staging/vt6656/usbpipe.h  | 2 +-
>>   drivers/staging/vt6656/wcmd.h     | 2 +-
>>   14 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/staging/vt6656/baseband.h 
>> b/drivers/staging/vt6656/baseband.h
>> index a907e30..c3b8bbd 100644
>> --- a/drivers/staging/vt6656/baseband.h
>> +++ b/drivers/staging/vt6656/baseband.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/card.h 
>> b/drivers/staging/vt6656/card.h
>> index 0a91d9b..75cd340 100644
>> --- a/drivers/staging/vt6656/card.h
>> +++ b/drivers/staging/vt6656/card.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/channel.h 
>> b/drivers/staging/vt6656/channel.h
>> index 6d0d282..cca330f 100644
>> --- a/drivers/staging/vt6656/channel.h
>> +++ b/drivers/staging/vt6656/channel.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/desc.h 
>> b/drivers/staging/vt6656/desc.h
>> index ac45ebb..3a83a9e 100644
>> --- a/drivers/staging/vt6656/desc.h
>> +++ b/drivers/staging/vt6656/desc.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/device.h 
>> b/drivers/staging/vt6656/device.h
>> index a2feeb9..6074ced 100644
>> --- a/drivers/staging/vt6656/device.h
>> +++ b/drivers/staging/vt6656/device.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/dpc.h b/drivers/staging/vt6656/dpc.h
>> index ddd0cb7..e080add 100644
>> --- a/drivers/staging/vt6656/dpc.h
>> +++ b/drivers/staging/vt6656/dpc.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/firmware.h 
>> b/drivers/staging/vt6656/firmware.h
>> index f30ae90..161126f 100644
>> --- a/drivers/staging/vt6656/firmware.h
>> +++ b/drivers/staging/vt6656/firmware.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/int.h b/drivers/staging/vt6656/int.h
>> index 1e6ff92..987c454e9 100644
>> --- a/drivers/staging/vt6656/int.h
>> +++ b/drivers/staging/vt6656/int.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/key.h b/drivers/staging/vt6656/key.h
>> index 1306ff4..918c07c 100644
>> --- a/drivers/staging/vt6656/key.h
>> +++ b/drivers/staging/vt6656/key.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/power.h 
>> b/drivers/staging/vt6656/power.h
>> index d5a3198..58755ae 100644
>> --- a/drivers/staging/vt6656/power.h
>> +++ b/drivers/staging/vt6656/power.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/rf.h b/drivers/staging/vt6656/rf.h
>> index f77866a..6103117 100644
>> --- a/drivers/staging/vt6656/rf.h
>> +++ b/drivers/staging/vt6656/rf.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/rxtx.h 
>> b/drivers/staging/vt6656/rxtx.h
>> index 44698f4..d528607 100644
>> --- a/drivers/staging/vt6656/rxtx.h
>> +++ b/drivers/staging/vt6656/rxtx.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/usbpipe.h 
>> b/drivers/staging/vt6656/usbpipe.h
>> index 5d7708f..2910ca5 100644
>> --- a/drivers/staging/vt6656/usbpipe.h
>> +++ b/drivers/staging/vt6656/usbpipe.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
>> diff --git a/drivers/staging/vt6656/wcmd.h 
>> b/drivers/staging/vt6656/wcmd.h
>> index 4a96f4d..a0d98cf 100644
>> --- a/drivers/staging/vt6656/wcmd.h
>> +++ b/drivers/staging/vt6656/wcmd.h
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>>    * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
>>    * All rights reserved.
