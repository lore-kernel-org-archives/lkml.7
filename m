Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2753C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E88208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QcYRalJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfG3SVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:21:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46980 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfG3SVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:21:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6UILCNF110349;
        Tue, 30 Jul 2019 13:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564510872;
        bh=N5qR8RPbpT0T8M0CdDyECCYS9yPhbYT3RcDEfqYF9eo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QcYRalJN4NTmIYrfoJ9aRR/ZgUWudO6DdFrzZjotKw0xB+v3qJ0jgEhUNsGf3DOD9
         1OSCPN0W5jOg/eAViUi3rjqsXNh9z69U/ECAIj72ZDUDs4bDCSln/uthYi318bWj6z
         gGuXn1hllEh8RFvpIY3UDbg/0OGflz5I8s5/6t/E=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6UILCbc022377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 13:21:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 13:21:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 13:21:12 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6UILBJw017559;
        Tue, 30 Jul 2019 13:21:11 -0500
Subject: Re: Backlight in motorola Droid 4
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-omap@vger.kernel.org>, <tony@atomide.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>,
        <jacek.anaszewski@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd> <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
 <20190724124530.GA30211@amd> <ca69f627-96e2-f982-3a29-18b0127ac6e5@ti.com>
 <edde330e-516b-ecaa-4139-0bfa766a9c08@ti.com> <20190729220030.GA20100@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ff91f577-98ad-d27b-02c2-6ed495cf4a38@ti.com>
Date:   Tue, 30 Jul 2019 13:21:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729220030.GA20100@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 7/29/19 5:00 PM, Pavel Machek wrote:
> Hi!
>
>>> Looking at the rest of the code.
>>>
>>> The DT doc indicated that this was a required child property so this is
>>> why it
>>>
>>> errors out.
>>>
>>> Dan
>>>
>>> <snip>
>>>
>> Did you want me to fix up the LM3532 and send the patch?
> If you could do that, that would be nice :-).

Ok I am working on this.

Is Droid4 supposed to boot off of mainline?  I see blogs stating it should

but the device locks up when it jumps to the kernel 5.3-rc1.

Unless I need to update my kexec or boot.cfg file but I cannot find any 
up to date info on that.

Dan


>
>> Or do you have a patch ready to go?
> No progress there, I'm busy with other stuff...
>
> Thanks,
> 									Pavel
>
