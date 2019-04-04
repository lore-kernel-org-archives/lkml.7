Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CBFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35422075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pS7lccu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfDDTe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:34:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49222 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbfDDTe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:34:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34JYql2102847;
        Thu, 4 Apr 2019 14:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554406492;
        bh=OIIEK2+Bu82/IGMgAohkVDvSW8coc0iap3R7mDpvoco=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=pS7lccu7tvGdB3zRpSFtqtnfpxPY60y/XVQ7lTD69QBHOsS300M3HkvIGEES1AXr5
         yVS8E4MPpJuE/OcXbJjCvynFRdXdS+Sx2FAlU+ySE5etVglVoCtjAj/D9C0FIK1s7H
         VBF7oFM2isXm+sBMSUpL/S1rxI9v9LGMCVolFIig=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34JYqxf124135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 14:34:52 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 14:34:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 14:34:52 -0500
Received: from [172.22.84.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34JYphX033779;
        Thu, 4 Apr 2019 14:34:52 -0500
Subject: Re: [PATCH 3/5] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
From:   Dan Murphy <dmurphy@ti.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-4-dmurphy@ti.com>
 <4e38128a-fa8f-aa94-284f-2c5a4906e17d@gmail.com>
 <83e31761-714d-db83-8c35-cf45243cb50b@ti.com>
 <4983e0b6-ae2b-9d15-0408-fdb23869711a@gmail.com>
 <28007702-cee0-079b-ccda-864f98a7b520@ti.com>
Message-ID: <cdd8693f-8293-6336-6f0a-38a5d4fa7151@ti.com>
Date:   Thu, 4 Apr 2019 14:34:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <28007702-cee0-079b-ccda-864f98a7b520@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 4/4/19 2:27 PM, Dan Murphy wrote:
<snip>

>>>>
>>>
>>> Actually I was thinking this property could move to common.txt
>>> LM3697 would use it and it is also defined in leds-pwm.txt leds-netxbig.txt
>>
>> It was considered back in 2014 when I was working on LED flash
>> class framework. It was then assessed inappropriate for describing
>> physical property of a device. It needs to be kept in mind that
>> it was in the context of flash LEDs, where currents are much
>> higher than for common LEDs. Since then we have been always using
>> led-max-microamp.
>>
>> With max-brightness in Device Tree there is also another problem -
>> we don't know what it really means - greater allowed current or
>> greater resolution.
>>
>> Why not allow for maximum available brightness resolution for ti-lmu
>> always when the amperage is not an issue?
>>

Missed answering this question.  Full scale ramping only works in 8-bit mode as the
LSB is used for the ramp.  This is why, if the customer does not want ramping and wants full 11 bit control
they can set this parameter for 11 bit brightness control.  Otherwise I default this to the 8 bit control as the preferred
method.

7.3.4.1 8-Bit Control (Preferred)
The preferred operating mode is to control the high-voltage LED brightness by setting the Control Bank LSB
register (3 LSB's) to zero and using only the Control Bank MSB register (8 MSB's). In this mode the LM3697
controls the 3 LSB's to ramp the high-voltage LED current using all 11-bits.

Ramping does work in 11 bit mode but the ramp time may be shorter based on the brightness value set.

Of course the code can be made smarter that if the optional ramp properties are available then set 8 bit automatically
but it cannot assume 11 bit if they are not.

Dan

<snip>

-- 
------------------
Dan Murphy
