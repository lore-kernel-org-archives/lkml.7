Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC8C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD2820840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="FEkwa0EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCHBOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:14:20 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:46485 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbfCHBOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:14:20 -0500
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 9DDEE42001D4;
        Fri,  8 Mar 2019 04:14:15 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id XQBHU9XJPq-EEvSTdhV;
        Fri, 08 Mar 2019 04:14:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1552007655;
        bh=zQgmOuPHauIYP/cFipOGOKTAWItYVO0Kjour8IbZyR8=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=FEkwa0EWXyCZQZ62eTFXiXquteDRj7NpS2/rKUv2CxrzJz0aaPAlPS92NgcLVRoQz
         aIrUc+WEb5NMSlg8eLJlYytP9GIzlq3tGnhvoDml6NWkgQdzJu7Mavg/Ba+Bm/hxPd
         ddFRTPgKv7uURlDTFnTRcGBV5iVDXpua6nirLFKM=
Authentication-Results: mxback1g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id cMqbauXwXp-E5ra6tFk;
        Fri, 08 Mar 2019 04:14:11 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
 machines
To:     Mario.Limonciello@dell.com, ibm-acpi@hmh.eng.br
Cc:     dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
 <28af3c22ad144cf69284aa6f91ee6565@ausx13mpc124.AMER.DELL.COM>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <a3ad032f-6b03-2e0e-ba3d-89de4cc35ed8@flygoat.com>
Date:   Fri, 8 Mar 2019 09:14:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <28af3c22ad144cf69284aa6f91ee6565@ausx13mpc124.AMER.DELL.COM>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/3/8 ÉÏÎç7:14, Mario.Limonciello@dell.com Ð´µÀ:
>   -----Original Message-----
>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>> owner@vger.kernel.org> On Behalf Of Jiaxun Yang
>> Sent: Thursday, March 7, 2019 2:08 AM
>> To: ibm-acpi@hmh.eng.br
>> Cc: dvhart@infradead.org; andy@infradead.org; ibm-acpi-
>> devel@lists.sourceforge.net; platform-driver-x86@vger.kernel.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Jiaxun Yang
>> Subject: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
>> machines
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Some AMD based ThinkPads have a firmware bug that calling
>> "GBDC" will cause bluetooth on Intel wireless cards blocked.

Hi,

Thanks for your suggestions.

> Since this is considered a firmware bug; has the OEM (and IBV) been notified?  Is it
> fixed in a newer version of the firmware?
No. I've noticed them about the bug but they said these models have no 
official Linux support so no plan to fix.
> If so, then this should probably only match particular broken firmware versions.
Disable bluetooth subdriver on these models should be safe since Intel 
cards have built-in RFKill and there is no bluetooth hotkey on these 
machines.
>> Probe these models by DMI match and disable bluetooth subdriver
>> if specified Intel wireless card exist.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---

--

Jiaxun Yang

