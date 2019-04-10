Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92EFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9282C20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LkWOhOCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfDJNYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:24:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40128 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbfDJNYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:24:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3ADOAIa107592;
        Wed, 10 Apr 2019 08:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554902650;
        bh=larqf0mDqVH+GSj3LbAF3qebUH8ZD3C5S8B1KqJQI3g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LkWOhOCvahgL+/F1U15pFd28ogfbwyb+Vr4OBsGblZPdiEu8lLHTHPG4VfoD5+p9t
         c4dcl88/KLeuqqBdzsJIs6jO40xWIy/OXgpssqVczkAlBRXYuw5QLLLFrZYp6hHM9K
         Km4RGutdaPq+E+QpkDJP9xHF/Lbf/RE3K9kkTn/w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3ADOA94066066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Apr 2019 08:24:10 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 10
 Apr 2019 08:24:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 10 Apr 2019 08:24:10 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3ADO9F3084655;
        Wed, 10 Apr 2019 08:24:10 -0500
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190319172651.10012-1-dmurphy@ti.com>
 <3ce79402-00f1-d7e6-955e-1ad7eb00d0de@ti.com>
 <c05a6a22-c162-518d-683a-18731bd67e38@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <9f33353d-c82f-a117-17de-9b57693bef27@ti.com>
Date:   Wed, 10 Apr 2019 08:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c05a6a22-c162-518d-683a-18731bd67e38@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc

On 4/2/19 7:17 AM, Wolfgang Grandegger wrote:
> Hello Dan,
>
> Am 02.04.19 um 14:03 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 3/19/19 12:26 PM, Dan Murphy wrote:
>>> Create a m_can platform framework that peripheral
>>> devices can register to and use common code and register sets.
>>> The peripheral devices may provide read/write and configuration
>>> support of the IP.
>>>
>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>> Wondering if this will be going into 5.1 PR?
> it's Marc who is doing the upstreaming ... and maybe a final review as well.

Don't know if the original message went through.

But wondering if this will make it into v5.2

Dan

> Wolfgang.

