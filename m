Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74601C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AF120878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cYDVVyYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfDXJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:32:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44420 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfDXJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:32:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3O9W18t041434;
        Wed, 24 Apr 2019 04:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556098321;
        bh=dXx6qdx23FXvK2J3I42OZXhw3dLfl5e/c/Q/9dFqrwo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cYDVVyYNGkeY8oqFs2hyIQ/Lh5CgBbqhxeU65gMcRdFuM5A7E3SV8AWtG2S4+1Foh
         dzA/zl6xDXuiMO+vDPWdihqGnFtALV0qQzGyvVwwgWU4WJaOfO/L5MWVPouL6roOKJ
         HZNsPNpXBeNG4D5rL6NsQqd9lmLcH7TI+XcyqGeU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3O9W1K1077415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 04:32:01 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 04:32:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 04:32:01 -0500
Received: from [172.22.181.92] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3O9Vw00070092;
        Wed, 24 Apr 2019 04:31:58 -0500
Subject: Re: [PATCH net-next 01/19] net: ethernet: ti: convert to SPDX license
 identifiers
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-2-git-send-email-grygorii.strashko@ti.com>
 <20190423135825.GE3371@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0d7d0a34-94a4-711b-814a-568f2ff16e7a@ti.com>
Date:   Wed, 24 Apr 2019 12:31:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190423135825.GE3371@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On 23.04.19 16:58, Andrew Lunn wrote:
> On Tue, Apr 23, 2019 at 04:08:52PM +0300, Grygorii Strashko wrote:
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Copyright (C) 2006, 2007 Eugene Konev
>>   *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
> 
> Your SPDX says version 2. The text says version 2 or later. You need
> to add a + .
Thanks for your comments. I'll update and resend.

-- 
Best regards,
grygorii
