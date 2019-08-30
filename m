Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC4C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D11E2341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S/gQ6c4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfH3PCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:02:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54142 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3PCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:02:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7UF24Tx029341;
        Fri, 30 Aug 2019 10:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567177324;
        bh=nfAqihWPleHpBk8WT3uGomvNKMkRIo6InAHlWj0/L1w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=S/gQ6c4WLLRF2MztR9tQ1NwHCcKq2OoxS36NLA2Y30XFZe0VrCgIzu1ZieAKLTpc8
         rftRKplxGQLU5KU0FW2WAWOCbZY1fvxZsDch8Q+ZCWAE1lyK1Sr0aJYNTEKMctIg1J
         lYVcPvlvVDaPXCoJzdlRQ5hyddfwNXeOLqGZwtXI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7UF247V103254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Aug 2019 10:02:04 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 30
 Aug 2019 10:02:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 30 Aug 2019 10:02:03 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7UF23cT101772;
        Fri, 30 Aug 2019 10:02:03 -0500
Subject: Re: [PATCH] leds: Move static keyword to the front of declarations
To:     Krzysztof Wilczynski <kw@linux.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190830090958.27108-1-kw@linux.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bdf6bc22-bc82-68ac-d3f2-4f3954d9e9e0@ti.com>
Date:   Fri, 30 Aug 2019 10:02:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830090958.27108-1-kw@linux.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzystof

Thanks for the patch

On 8/30/19 4:09 AM, Krzysztof Wilczynski wrote:
> Move the static keyword to the front of declarations.
>
> In drivers/leds/leds-lm3532.c for ramp_table, als_avrg_table
> and als_imp_table, and in drivers/leds/leds-lm3532.c for
> ramp_table.
>
> This will resolve the following compiler warnings that can
> be seen when building with warnings enabled (W=1):
>
> drivers/leds/leds-lm3532.c:209:1: warning:
>    ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>
> drivers/leds/leds-lm3532.c:266:1: warning:
>    ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>
> drivers/leds/leds-lm3532.c:281:1: warning:
>    ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>
> drivers/leds/leds-ti-lmu-common.c:14:1: warning:
>    ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
> Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com
>
>   drivers/leds/leds-lm3532.c        | 6 +++---
>   drivers/leds/leds-ti-lmu-common.c | 2 +-

This file is missing in the subject.

Maybe break it out into a separate patch since they do not have 
dependencies on each other.

Dan


