Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C1C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE2221929
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ko3ZUoKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfJBL4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:56:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34002 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:56:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x92BuFWE078912;
        Wed, 2 Oct 2019 06:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570017375;
        bh=EtJMrbtufpIrfDV4euQaW70sWTGMkCb/y5EXKsUYjdY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ko3ZUoKvyR3NdLUZHgrlBP6nt70tku8CtKPmTBPNIeAHZGJcIzeLq1f8Or63SWYJ9
         VKvU3w/27JTLypJRtaoGYuvNFCgRTpkzBUnBmg/+imyI0wfwY2zLlb/i7FbazKSXS7
         fImGlzjfZxt1904xXPIbOygwwvJim9vcmC4GZwTk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x92BuFck084734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Oct 2019 06:56:15 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 2 Oct
 2019 06:56:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 2 Oct 2019 06:56:04 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x92BuEYc030884;
        Wed, 2 Oct 2019 06:56:14 -0500
Subject: Re: [PATCH 3/5] leds: flash: Remove extern from the header file
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191001180439.8312-1-dmurphy@ti.com>
 <20191001180439.8312-3-dmurphy@ti.com>
 <a6601fe9-0723-baec-d610-aafe7731c80d@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <01576f87-9113-1148-438a-5b73c5424535@ti.com>
Date:   Wed, 2 Oct 2019 06:56:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a6601fe9-0723-baec-d610-aafe7731c80d@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 10/1/19 3:57 PM, Jacek Anaszewski wrote:
> Dan,
>
> Thank you for the patch.
>
> Could we have similar patch for leds.h when we are at it,
> if you wouldn't mind?
>
Sure do you want it in this patch or a separate patch?

Dan

