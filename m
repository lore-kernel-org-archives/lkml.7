Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9CAC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4A32070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TnJBtRbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfFFLZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:25:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37292 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfFFLZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:25:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x56BPQGG023628;
        Thu, 6 Jun 2019 06:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559820326;
        bh=jth0Y8focOTvvve+jPGBmPLrC+TFpOp4XIT+37W1kd8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TnJBtRbZMsU+589djA5aX68nT/E4Cv1mJ0bz+9vu9R1brovEZn7rVLYRV3tJEz0Qf
         G0LhXIi1YQdVcmexX8Y5DYzuUY93HKulQO0Ty9afMCKy9ySAMEWeu6ABL4YDgrn9xO
         y8f2v3w0YuqlJxrghNp1OVMvbfbrqeLHg6bqp2yE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x56BPQqP100055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 06:25:26 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 06:25:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 06:25:25 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x56BPPtp128993;
        Thu, 6 Jun 2019 06:25:25 -0500
Subject: Re: [PATCH v6 5/5] leds: lm36274: Introduce the TI LM36274 LED driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <lee.jones@linaro.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190605125634.7042-1-dmurphy@ti.com>
 <20190605125634.7042-6-dmurphy@ti.com> <20190606100759.GB1825@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f10b8877-9e1a-0011-1a25-e8c0bc8fcd22@ti.com>
Date:   Thu, 6 Jun 2019 06:25:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606100759.GB1825@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 6/6/19 5:07 AM, Pavel Machek wrote:
> On Wed 2019-06-05 07:56:34, Dan Murphy wrote:
>> Introduce the LM36274 LED driver.  This driver uses the ti-lmu
>> MFD driver to probe this LED driver.  The driver configures only the
>> LED registers and enables the outputs according to the config file.
>>
>> The driver utilizes the TI LMU (Lighting Management Unit) LED common
>> framework to set the brightness bits.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Actually, one more thing. Not too important, but.. how did Jacek's
> signoff get there? He should add his signoff when he applies it to the
> git...
>
This signoff came from the ti-lmu-led-drivers branch that Jacek created 
in his linux-leds repo.

Unfortunately that branch does not seem to exist now so Jacek would need 
to confirm this.

Dan

