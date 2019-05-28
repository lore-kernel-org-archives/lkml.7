Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68579C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DE82081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nso+2l6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfE1Apm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 20:45:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34284 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfE1Apm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:45:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4S0jaiX058237;
        Mon, 27 May 2019 19:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559004336;
        bh=1JnGHZvHyL2VOmJQfXsquvMDTMdCkBKneNCnKVBEnjo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nso+2l6CVVL2pmQd0wDtsjoc63heTFxs8fkPdAhYcKGPkzK3MKjpCn4ODoS9a+tuE
         xfCWJv8AVjI5SPcIVG/bpYZHMFKgbhuY31e2mh6Z2gFo2awLVBGTNHVJn33mi5qGsW
         Gnwa/gWy8Ev0Bmot+JdTfSUBlaAqxFIvQhwZQxFg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4S0jaDH110968
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 May 2019 19:45:36 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 27
 May 2019 19:45:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 27 May 2019 19:45:36 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4S0jZuM037366;
        Mon, 27 May 2019 19:45:35 -0500
Subject: Re: [PATCH v3 1/9] leds: multicolor: Add sysfs interface definition
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190523190820.29375-1-dmurphy@ti.com>
 <20190523190820.29375-2-dmurphy@ti.com> <20190527103355.GA5287@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <522728b0-147b-3708-fea1-88a895491e05@ti.com>
Date:   Mon, 27 May 2019 19:45:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527103355.GA5287@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 5/27/19 5:33 AM, Pavel Machek wrote:
> On Thu 2019-05-23 14:08:12, Dan Murphy wrote:
>> Add a documentation of LED Multicolor LED class specific
>> sysfs attributes.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../ABI/testing/sysfs-class-led-multicolor    | 57 +++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
>> new file mode 100644
>> index 000000000000..2f102ede258b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
>> @@ -0,0 +1,57 @@
>> +What:		/sys/class/leds/<led>/colors/sync_enable
>> +Date:		April 2019
> I believe I suggested more reasonable interface. Why not use that?
>

Can you please provide the reference to your interface?

These patchsets have been around for a while (Decemeber 2018) and I 
cannot seem to find the reference to your suggestion.

The suggestion may have been mired in the brightness model discussions.

So I don't want to over look what you suggested as it may be more 
reasonable then what I have implemented.

Dan

