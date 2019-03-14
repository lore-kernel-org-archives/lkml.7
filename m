Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56075C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2032E2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nuJeQyoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfCNMwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:52:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56724 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:52:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2ECqRDm052783;
        Thu, 14 Mar 2019 07:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552567947;
        bh=+wy31PUBcfnCdYEf2Jt+oa0CHFkSB9jj2I0npiBKs4g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nuJeQyoVT2upVZTOaDU4zFX4FpwkL0AH29CVa+oPehb5ujsuP/lscdQ8H49hUBa6k
         sILCMINpIk41zOZKp+sbPcSIpgzFeuHkmM79qot651muMbewJpjuad49l1EnziLxqN
         UKXfnYEPPlCG7hKYammT43uRFAuxh0KTdf23Ojbk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2ECqRTs033829
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 07:52:27 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Mar 2019 07:52:27 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Mar 2019 07:52:27 -0500
Received: from [172.22.77.5] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2ECqQjF008893;
        Thu, 14 Mar 2019 07:52:26 -0500
Subject: Re: [PATCH v4 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu
 doc
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <tony@atomide.com>, <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190313123249.17258-1-dmurphy@ti.com>
 <20190314093912.GA10637@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <75def574-5fe4-46c0-664f-8c6583b69668@ti.com>
Date:   Thu, 14 Mar 2019 07:52:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314093912.GA10637@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 3/14/19 4:39 AM, Pavel Machek wrote:
> Hi!
> 
> Could you maybe slow down a bit.
> 
> "Hey, I should review this". "Hmm, there are two new versions in the
> mailbox in the meantime, good thing I waited."
> 

Yes.  I am going to hold off on v5 until the code gets reviewed.

>> +	ramp-up-ms = <1024>;
>> +	ramp-down-ms = <65536>;
> 
> This is wrong.
> 

Ack.  Changed in it in the example I deleted.

>> +	led@1 {
>> +		reg = <1>;
>> +		led-sources = <1>;
>> +		ti,led-mode = <0>;
>> +		label = "keypad";
> 
> "platform::kbd_backlight"

Being an example does it have to match DT contents?

I can change it since I have to touch the file anyway.

Dan


> 									Pavel
> 


-- 
------------------
Dan Murphy
