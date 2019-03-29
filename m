Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B52BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4C62075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FTQr6Kw4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FTQr6Kw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfC2VFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:05:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfC2VFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:05:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E195D6087F; Fri, 29 Mar 2019 21:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553893514;
        bh=Bm+FhgcWpIOxRWZE783xh+grrAzGVTZ46mPn0ETr6Eg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FTQr6Kw4PEkGKhKQjiXqbt+EFixyNyzCr5goqfjpMQbtaeZOvJDnERHpr/x+4dhC8
         efBq8miCtuK8hLoez4sqwE9ks/ALxxEGMgLowqNsk1WfGBCKRN20EftdRtAaEjUQ8V
         l67avATSmU4p9KYZM/oS0jVpBpx84fWxhpMUvbkA=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79C40602FC;
        Fri, 29 Mar 2019 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553893514;
        bh=Bm+FhgcWpIOxRWZE783xh+grrAzGVTZ46mPn0ETr6Eg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FTQr6Kw4PEkGKhKQjiXqbt+EFixyNyzCr5goqfjpMQbtaeZOvJDnERHpr/x+4dhC8
         efBq8miCtuK8hLoez4sqwE9ks/ALxxEGMgLowqNsk1WfGBCKRN20EftdRtAaEjUQ8V
         l67avATSmU4p9KYZM/oS0jVpBpx84fWxhpMUvbkA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79C40602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Add maintainer and replacing reviewer
 ARM/NUVOTON NPCM
To:     Benjamin Fair <benjaminfair@google.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     joe@perches.com, avifishman70@gmail.com,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Tali Perry <tali.perry1@gmail.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <20190328235752.334462-1-tmaimon77@gmail.com>
 <20190328235752.334462-2-tmaimon77@gmail.com>
 <CADKL2t5VuWA=Cx9q9Ddx+rZGbe1YoRKMWwfdFOCyxuGiMCOiPg@mail.gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3fbe0a4e-bb9f-3a20-32e4-6ea0d3155a04@codeaurora.org>
Date:   Sat, 30 Mar 2019 02:35:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CADKL2t5VuWA=Cx9q9Ddx+rZGbe1YoRKMWwfdFOCyxuGiMCOiPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 11:02 PM, Benjamin Fair wrote:
> On Thu, Mar 28, 2019 at 4:58 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>> Adding Tali Perry as Nuvoton NPCM maintainer
>> Replacing Brendan Higgins Nuvoton NPCM reviewer with
>> Benjamin Fair.
>>
>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Benjamin Fair <benjaminfair@google.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

>
>> ---
>>   MAINTAINERS | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8b305d2f2a8a..4ece87fcc166 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1893,9 +1893,10 @@ T:       git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
>>   ARM/NUVOTON NPCM ARCHITECTURE
>>   M:     Avi Fishman <avifishman70@gmail.com>
>>   M:     Tomer Maimon <tmaimon77@gmail.com>
>> +M:     Tali Perry <tali.perry1@gmail.com>
>>   R:     Patrick Venture <venture@google.com>
>>   R:     Nancy Yuen <yuenn@google.com>
>> -R:     Brendan Higgins <brendanhiggins@google.com>
>> +R:     Benjamin Fair <benjaminfair@google.com>
>>   L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
>>   S:     Supported
>>   F:     arch/arm/mach-npcm/
>> --
>> 2.14.1
>>
