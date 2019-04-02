Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F15C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904C62133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pg2wJokV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfDBLzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:55:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDBLzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:55:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32Btb6X112771;
        Tue, 2 Apr 2019 06:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554206137;
        bh=FRIfSGyN0UnQM7XGzfcPOMRFX/MC9gFO3in0raXcEjw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Pg2wJokVf0i6T0xw42JZGWNRUTXIbNK+qyGWoNAGBbBq9EefwAWtDdvGAfspyedB7
         PPLR0PS0biCtczh6/LOFshQHHsElbdO7wqu37Tah2TWZ5IajirnV4THMKh2cOhWY6n
         3dnHG79yS1B+uOOdmUodNGhTe1XzvrAYiIrOvZKk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32Btbd1097703
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 06:55:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 06:55:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 06:55:37 -0500
Received: from [172.22.72.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32Btb0o052466;
        Tue, 2 Apr 2019 06:55:37 -0500
Subject: Re: [RFC PATCH 5/5] leds: multicolor: Introduce a multicolor class
 definition
To:     Marek Behun <marek.behun@nic.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-6-dmurphy@ti.com> <20190402074406.0860994a@nic.cz>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <262bf73c-3fef-a5cb-3dd7-3312dae059d9@ti.com>
Date:   Tue, 2 Apr 2019 06:55:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402074406.0860994a@nic.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek

On 4/2/19 12:44 AM, Marek Behun wrote:
> Hi Dan,
> 
> On Mon, 1 Apr 2019 12:34:00 -0500
> Dan Murphy <dmurphy@ti.com> wrote:
> 
>> +static ssize_t sync_store(struct device *dev,
>> +			  struct device_attribute *sync_attr,
>> +			  const char *buf, size_t size)
>> +{
>> +	struct led_classdev_mc_data *data = container_of(sync_attr,
>> +						      struct led_classdev_mc_data,
>> +						      sync_attr);
>> +	struct led_classdev_mc *mcled_cdev = data->mcled_cdev;
>> +	struct led_classdev *led_cdev = &mcled_cdev->led_cdev;
>> +	const struct led_multicolor_ops *ops = mcled_cdev->ops;
>> +	struct led_classdev_mc_priv *priv;
>> +	unsigned long sync_value;
>> +	ssize_t ret = -EINVAL;
>> +
>> +	mutex_lock(&led_cdev->led_access);
>> +
>> +	if (!mcled_cdev->sync_enabled)
>> +		goto unlock;
> 
> This lock is redundant, you could just put
>   if (mcled_cdev->sync_enabled)
>     return ret;
> before the lock.
> 

Ack

Thanks the code is just proof of concept code.  But I will make this change as well.

Dan

-- 
------------------
Dan Murphy
