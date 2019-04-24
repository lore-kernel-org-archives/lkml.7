Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E66AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF18920878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rdCT2peQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfDXJbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:31:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDXJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:31:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3O9V6ui103605;
        Wed, 24 Apr 2019 04:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556098266;
        bh=U01kyr9AdbHvnDi2ONIbZ1/62KSMGw51h4xxTIOYNos=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rdCT2peQ+PLE/TPQwDbeghqPEMMO8t9L1sXiUkvj5HId0NBC0fvp1pJx6RTvB3iEg
         OUbHxjND87P5RFztnZ+9vFs7OfbxF0q5bxSf5ppb30oUVfJ5CXgrX9gWazI/eHJJoq
         JgOBMoxPF+3QEx3u6KlKqtUD8JgPnBn8QrsNeA6Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3O9V5V0076311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 04:31:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 04:31:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 04:31:05 -0500
Received: from [172.22.181.92] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3O9V2jL068847;
        Wed, 24 Apr 2019 04:31:03 -0500
Subject: Re: [PATCH net-next 02/19] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
 <20190423172709.693f4784@cakuba.netronome.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <32d4f384-cf74-f34e-137f-58333c7d9073@ti.com>
Date:   Wed, 24 Apr 2019 12:31:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190423172709.693f4784@cakuba.netronome.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.04.19 03:27, Jakub Kicinski wrote:
> On Tue, 23 Apr 2019 16:08:53 +0300, Grygorii Strashko wrote:
>> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
>> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
>> config option.
>> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
>> make build work.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Last time I tried including the same object file in two different
> modules it backfired pretty badly.  Would you mind sparing some 
> details as to why you need to do this?

I've tried it as modules and inbuid and see no issues.
Issue with build happens if EXPORT_SYMBOL_GPL() not removed.

It's not expected and not supported to load more then one TI Net
driver at same hw, so modules also are just be loaded fine.

Why? It's to get rid of CONFIG options which were historically added,
but are not required now (and even can't be disabled of if disabled will
cause build failures) - result simplified build/Kconfig and code.


-- 
Best regards,
grygorii
