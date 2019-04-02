Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DDA2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mx0KFGcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfDBRHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:07:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47848 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:07:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32H7OCB068583;
        Tue, 2 Apr 2019 12:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554224844;
        bh=VQRbz/Rf05xHEH+meer5+H8VubFtHfFr9uyrhqkgQLg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Mx0KFGcdfUOWmNyFE92Hoq8ach/n2poQ5dF4WtaBlQMKJ7mOzm23bWM2bCOiN01tp
         gvmdk62GHD9hY+nlmEjyH7M3dJtVHq0VrVzFTgCpN6meqzeEAt/lBPTznytE3E3+l9
         ee3us6xay5HOqS8RmfsnGZsVA+/EFThbXwIUA1D8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32H7OE8088562
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 12:07:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 12:07:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 12:07:24 -0500
Received: from [172.22.126.131] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32H7N8X105035;
        Tue, 2 Apr 2019 12:07:23 -0500
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
To:     Pavel Machek <pavel@ucw.cz>
CC:     Brian Masney <masneyb@onstation.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
 <7bcd94ee-a4f8-c91b-697d-cc4c6337ec88@ti.com> <20190402164533.GA21197@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6717928c-0531-cc36-d22b-a53cc359fb97@ti.com>
Date:   Tue, 2 Apr 2019 12:07:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402164533.GA21197@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 11:45 AM, Pavel Machek wrote:
> On Tue 2019-04-02 08:45:40, Dan Murphy wrote:
>> Hello
>>
>> On 4/1/19 5:30 AM, Brian Masney wrote:
>>> Add device tree support to the lm3630a driver and allow configuring
>>> independently on both banks the mapping mode (linear or exponential),
>>> initial and maximum LED brightness.
>>>
>>> Driver was tested on a LG Nexus 5 (hammerhead) phone.
>>>
>>
>> Don't need this in the commit message.
> 
> Actually yes, we want that in commit message.
> 

Noted for future patches.

Dan

> 									Pavel
> 


-- 
------------------
Dan Murphy
