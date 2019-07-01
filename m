Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD73C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD592064B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WHmxUept"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfGAOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:43:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49882 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfGAOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:43:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x61Egdo5075891;
        Mon, 1 Jul 2019 09:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561992159;
        bh=iKP2cTrvR9F598GvjFKv22KHtphyP4LBMvglTZrh3Es=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WHmxUeptNNo7/HwGsjNCRicJQrjMxGahYS0tABecy+MuQGQCGGvYZkAe79Ykjc/S1
         eaop8zvd35FRbk/tML0OyDTTQBtJBU1XMUrxvmlgtz9BFF4SFWRcZnpz7qSJGAZel2
         pqyBSoXIa93iJQcNfxxkvZIE3HGh3y/bluAUg/5E=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x61Egdb6093187
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jul 2019 09:42:39 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Jul
 2019 09:42:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Jul 2019 09:42:39 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x61Ega7c017651;
        Mon, 1 Jul 2019 09:42:37 -0500
Subject: Re: [PATCH] mfd: davinci_voicecodec: remove pointless #include
To:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
CC:     Richard Fontana <rfontana@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190628104132.2791616-1-arnd@arndb.de>
 <CAK8P3a1CV-JUpBJ0pjixwXxxOzjQOX=+E3s-mKGAz_bMBc_Vuw@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <07dae8b9-dfec-a58f-48b8-702f9d1d9f9a@ti.com>
Date:   Mon, 1 Jul 2019 20:12:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1CV-JUpBJ0pjixwXxxOzjQOX=+E3s-mKGAz_bMBc_Vuw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/19 4:17 PM, Arnd Bergmann wrote:
> [I missed the davinci maintainers on cc here, sorry]
> 
> On Fri, Jun 28, 2019 at 12:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> When building davinci as multiplatform, we get a build error
>> in this file:
>>
>> drivers/mfd/davinci_voicecodec.c:22:10: fatal error: 'mach/hardware.h' file not found
>>
>> The header is only used to access the io_v2p() macro, but the
>> result is already known because that comes from the resource
>> a little bit earlier.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
