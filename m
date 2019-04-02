Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADD9205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gLbx2NKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfDBRHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:07:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48062 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBRHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:07:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32H6rgo047282;
        Tue, 2 Apr 2019 12:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554224813;
        bh=+/7po9A1i8sjerZ4j8FxSaGiLq6wV0jePtVrKCjce7o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gLbx2NKrdqs8grWX7M2lDjxEf2cX0TdMVNPcP+Y67bxUsrX1yegcCKRQUhNwkKqeO
         gxnDFa07y9M0mm9y1BtVhNaEkvaDpbgBMi+iFRXVIUqJEPudhbysi0qX03U91rxP8W
         EMI0ceO94iQY7RskqH/rEyG4192lCV4+wuE8yDnE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32H6rSU115636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 12:06:53 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 12:06:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 12:06:52 -0500
Received: from [172.22.126.131] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32H6qN8120656;
        Tue, 2 Apr 2019 12:06:52 -0500
Subject: Re: [RFC PATCH 2/5] dt: bindings: Add multicolor class dt bindings
 documention
To:     Marek Behun <marek.behun@nic.cz>
CC:     Pavel Machek <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <jacek.anaszewski@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-3-dmurphy@ti.com> <20190401212921.GB14681@amd>
 <f8655180-0c3a-7292-3a49-57d997473992@ti.com>
 <20190402181712.3eccdb4b@nic.cz>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c6abe495-d7fe-a784-0b9b-1c690b01e008@ti.com>
Date:   Tue, 2 Apr 2019 12:06:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402181712.3eccdb4b@nic.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek

On 4/2/19 11:17 AM, Marek Behun wrote:
> On Tue, 2 Apr 2019 06:40:53 -0500
> Dan Murphy <dmurphy@ti.com> wrote:
> 
>> I have had off line conversations with Jacek about this brightness model node.
>>
>> Your concern was actually one of my concerns as well.  Not only millions of entries but also having a huge
>> DT binary.
>>
>> We wanted to RFC this to get feedback.  And this is why I have not added any support for this in the framework code.
>>
>> Dan
>>
> 
> What if we just stuck to color spaces and defined channel curves in the
> device tree?
> 

Vesa did a good summary of the current MC framework implementations that are being proposed
The thread also documents Pavel's requirements

https://lore.kernel.org/patchwork/patch/1037147/

And here is the series with a single brightness file and passing in multiple integers.
I did not document this code as I was pretty certain it was not the way to go.

https://patches.linaro.org/project/linux-leds/list/?series=18022

Dan

> The curve could then be defined via an array of integer pairs, which
> would be interpreted as points via which the curve passes and the curve
> would be approximated by linear segemts...
> 
>   led@0 {
>     colorspace = <COLOR_SPACE_ID_RGB>;
>     red-curve = <0 0>, <255 255>;
>     green-curve = <0 0>, <255 128>;
>     blue-curve = <0 0>, <255 128>;
>   };
> 


-- 
------------------
Dan Murphy
