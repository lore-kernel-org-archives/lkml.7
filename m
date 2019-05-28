Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0662C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD9216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BjzA/Baj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfE1Rc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:32:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52630 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfE1Rc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:32:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4SHWLEc125462;
        Tue, 28 May 2019 12:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559064741;
        bh=+XAh1rn1DmZmFVkCu8Os6B8Nn8qFNsfps9mYhSpW/OU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BjzA/Baj5LeyaDfxIOsk6yuJaPFhKP7auVMPihrW5GVeZrTjtI4OdylSyEMgWgGlx
         ayb6HtHqmiM/zUqTd66v/ZihbcRlP6/UiUU4YBkwW0lt/cuK/THxHKKLKsKyPpjSZU
         KZuS0j9dpa7RJ5OFzFeYIrt3MHaTdJPLuPPOo+Js=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4SHWLeG073786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 12:32:21 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 12:32:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 12:32:21 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4SHWLho064319;
        Tue, 28 May 2019 12:32:21 -0500
Subject: Re: [PATCH v3 1/9] leds: multicolor: Add sysfs interface definition
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190523190820.29375-1-dmurphy@ti.com>
 <20190523190820.29375-2-dmurphy@ti.com>
 <f01ac400-efda-80a8-4d63-1e2add5e054a@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <185abdd6-100c-0a71-2da9-8f556d8ea701@ti.com>
Date:   Tue, 28 May 2019 12:32:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f01ac400-efda-80a8-4d63-1e2add5e054a@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 5/27/19 3:00 PM, Jacek Anaszewski wrote:
> Hi Dan,
>
> Thank you for the update.
>
> One thing is missing here - we need to document how legacy brightness
> levels map to the sub-LED color levels, i.e. what you do in
> multicolor_set_brightness().


Ok so i will need to document the algorithm that is used to determine 
the color LED brightness.


Dan

>
> Best regards,
> Jacek Anaszewski
>

<snip>

>
