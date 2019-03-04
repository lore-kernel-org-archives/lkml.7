Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02C12070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l98T0rxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfCDSOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:14:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52196 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfCDSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:14:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x24IEViO016041;
        Mon, 4 Mar 2019 12:14:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551723271;
        bh=4cKfhvIjucjeGcQqckVjBRHPZUS7ElJUKfj1d9nZ71E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l98T0rxB+SRY4x1Ui8Fq/YxY6wo5THhbLB2a/53Dvs0bwo7Kzi+RO8dbG6lj++Qow
         NIV3jxYTTAUYZIeLTiRdzI+EWKYfcuLp0zAC+D6xfM1muNBGXfQ2E6BbaVererSNia
         opJciiYdUcGwm4+DKxcCkC1WlBaHDMuo5iTOFGoY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x24IEUmK101437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 12:14:30 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Mar 2019 12:14:30 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Mar 2019 12:14:30 -0600
Received: from [172.22.70.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x24IEUvm030129;
        Mon, 4 Mar 2019 12:14:30 -0600
Subject: Re: [PATCH v6 2/4] can: m_can: Rename m_can_priv to m_can_classdev
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190301185043.9037-1-dmurphy@ti.com>
 <20190301185043.9037-2-dmurphy@ti.com>
 <093eb838-ab28-0bc0-8855-a8b22f3392b4@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <85e03abc-82ce-6fa9-f1bd-1a068fabba53@ti.com>
Date:   Mon, 4 Mar 2019 12:14:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <093eb838-ab28-0bc0-8855-a8b22f3392b4@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 3/4/19 11:31 AM, Wolfgang Grandegger wrote:
> Hello,
> 
> there are still "LTL" after renaming m_can_priv to m_can_classdev.
> 

Yes I know but some of those become unreadable if I break them apart.

But if you want me to break them I can do it.

For instance
	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;

will become

	struct m_can_plat_priv *priv =
				(struct m_can_plat_priv *)m_can_class->device_data;

> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>> Rename the common m_can_priv class structure to
>> m_can_classdev as this is more descriptive.
> 
> If you change the struct name, I think you should also change the
> variable name to something more meaning full e.g.:
> 
>   struct m_can_classdev *cdev
> 
> instead of
> 
>   struct m_can_classdev *priv
> 
> 

Ack.  This change will grow this patch as s/priv/cdev is used 250x

Dan

> ... snip ...
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
