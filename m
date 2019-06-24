Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7632EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542D2205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfFXJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:57:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41013 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfFXJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:57:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so7203180pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8liBhKcb39ebbAYg76+t+P2qlg08D2vSZfhU2rq0AYs=;
        b=lvXC4vM03w7KoGyRYzrKXpLjYNV6MUQncQm0RzLP1vfklVTvnCvH+xGn/F/jZy51XJ
         2BgPUihM4pmDTsaXjVgvATwH/uNngGNst5yR64Yw3Y2+Dabc6DpFSK2H9TaSiEZWBuDj
         EKca/Prr4oyeWSWpZ7LJ5oZh+RPheeTyETMVd7dwPTvIg8cJJOKlkD7K1vcQTkgxoogZ
         Y8JpXZl+G4KM15HNYsiLc4JaCcI2gLHXQ/M0cGJKDdx2CX4JXcPLDDzl2wUfsQMk523K
         r5jdxWrLGLZVUd/i1z8V471hK1U9e7x3CDv3VWAAGKmwRW3UuFTluKnFfySstWlRTuht
         Eg1g==
X-Gm-Message-State: APjAAAVGZiWVld/7KWikVRxTqW52LuMClbYrf8gk8SAPBgHz0iIzpj88
        xv+KYAzWaLdTDIcD0haQZ317fA==
X-Google-Smtp-Source: APXvYqyFQrSA1wMPdPgsWifOWQDxpwRq5Ylg5kqketQSIRe779u7+RaIij7d5ol+NsCyDV7NpzMzhw==
X-Received: by 2002:a17:90a:8a17:: with SMTP id w23mr2129572pjn.139.1561370242621;
        Mon, 24 Jun 2019 02:57:22 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id x128sm18862198pfd.17.2019.06.24.02.57.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 02:57:22 -0700 (PDT)
Date:   Mon, 24 Jun 2019 02:57:22 -0700 (PDT)
X-Google-Original-Date: Mon, 24 Jun 2019 02:57:17 PDT (-0700)
Subject:     Re: [PATCH 2/2] net: macb: Kconfig: Rename Atmel to Cadence
In-Reply-To: <0c714db9-a3c1-e89b-8889-e9cdb2ac6c52@microchip.com>
CC:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Nicolas.Ferre@microchip.com
Message-ID: <mhng-87f5f418-acd4-4a29-b82e-6dc574a4828a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 02:49:16 PDT (-0700), Nicolas.Ferre@microchip.com wrote:
> On 24/06/2019 at 08:16, Palmer Dabbelt wrote:
>> External E-Mail
>> 
>> 
>> When touching the Kconfig for this driver I noticed that both the
>> Kconfig help text and a comment referred to this being an Atmel driver.
>> As far as I know, this is a Cadence driver.  The fix is just
> 
> Indeed: was written and then maintained by Atmel (now Microchip) for 
> years... So I would say that more than a "Cadence driver" it's a driver 
> that applies to a Cadence peripheral.
> 
> I won't hold the patch just for this as the patch makes perfect sense, 
> but would love that it's been highlighted...

OK, I don't mind changing it.  Does this look OK?  I have to submit a v2 anyway
for the first patch.

Author: Palmer Dabbelt <palmer@sifive.com>
Date:   Sun Jun 23 23:04:14 2019 -0700

    net: macb: Kconfig: Rename Atmel to Cadence

    The help text makes it look like NET_VENDOR_CADENCE enables support for
    Atmel devices, when in reality it's a driver written by Atmel that
    supports Cadence devices.  This may confuse users that have this device
    on a non-Atmel SoC.

    The fix is just s/Atmel/Cadence/, but I did go and re-wrap the Kconfig
    help text as that change caused it to go over 80 characters.

    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 74ee2bfd2369..29b6132b418e 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Atmel device configuration
+# Cadence device configuration
 #

 config NET_VENDOR_CADENCE
@@ -13,8 +13,8 @@ config NET_VENDOR_CADENCE
          If unsure, say Y.

          Note that the answer to this question doesn't directly affect the
-         kernel: saying N will just cause the configurator to skip all
-         the remaining Atmel network card questions. If you say Y, you will be
+         kernel: saying N will just cause the configurator to skip all the
+         remaining Cadence network card questions. If you say Y, you will be
          asked for your specific card in the following questions.

 if NET_VENDOR_CADENCE

> 
>> s/Atmel/Cadence/, but I did go and re-wrap the Kconfig help text as that
>> change caused it to go over 80 characters.
>> 
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>   drivers/net/ethernet/cadence/Kconfig | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
>> index 74ee2bfd2369..29b6132b418e 100644
>> --- a/drivers/net/ethernet/cadence/Kconfig
>> +++ b/drivers/net/ethernet/cadence/Kconfig
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   #
>> -# Atmel device configuration
>> +# Cadence device configuration
>>   #
>>   
>>   config NET_VENDOR_CADENCE
>> @@ -13,8 +13,8 @@ config NET_VENDOR_CADENCE
>>   	  If unsure, say Y.
>>   
>>   	  Note that the answer to this question doesn't directly affect the
>> -	  kernel: saying N will just cause the configurator to skip all
>> -	  the remaining Atmel network card questions. If you say Y, you will be
>> +	  kernel: saying N will just cause the configurator to skip all the
>> +	  remaining Cadence network card questions. If you say Y, you will be
>>   	  asked for your specific card in the following questions.
>>   
>>   if NET_VENDOR_CADENCE
>> 
> 
> 
> -- 
> Nicolas Ferre
