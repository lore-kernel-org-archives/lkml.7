Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8215EC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D921926
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392530AbfGWXAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:00:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbfGWXAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:00:31 -0400
Received: from [192.168.1.110] ([95.118.72.89]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSqbe-1hzWmY3zlm-00UIYa; Wed, 24 Jul 2019 01:00:21 +0200
Subject: Re: [PATCH 3/3] platform//x86/pcengines-apuv2: update gpio button
 definition
To:     Florian Eckert <eckert.florian@googlemail.com>
Cc:     Florian Eckert <fe@dev.tdt.de>, info@metux.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-4-fe@dev.tdt.de>
 <cca95ba1-6ac0-a2eb-9ae6-914a8783c1ad@metux.net>
 <CALPCC5wH_uAGYaHeM_d_yxxUZEd3f-MfhT7jdZSt9ythd08S9w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ab15f31b-e585-15c2-877a-5fcc13e85e14@metux.net>
Date:   Wed, 24 Jul 2019 01:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALPCC5wH_uAGYaHeM_d_yxxUZEd3f-MfhT7jdZSt9ythd08S9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EX1j4GM+pOLE65MKiwTA8Ks36S6bIA+Y7Mhd6g2mbt9wg4ebVug
 kqRDbgWT46bwxsFukXFSexKcJJPbVpE8uzNERTO/GR732zedwK0C2q9OrQSWHtDb51VJODw
 gtujqmGVbXaj/VRY8I84d/wwX0SlAuzYicXDP8fWf8w9Uc+LDFZTVdfNgi2/vDG/qS3rxwe
 cQn88ii5fnxPtp3PWojFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IsyNBD5FIIg=:9ZSiUeXe9Qr2cxzGf5qCAo
 v0GR4pblsBOU5yggDB/SNoh6X3cxXhWdWfsxSAW5FAvW8bVMnylmytJvYrdO/XBTJs/+br4Ic
 FUQmpu/vpO1sWCouvjagy7iLZMZK8HKizzJm1r9fbNIp7q9e9i6nE2KmfJHWAztLw+pdTrZRb
 +fHVDCW+uuO3VuQwK0YlqhImw5e901p3bflAF+Se+wdWgXVk6ufwjhQQkKR5PpnfWhKFjjE7g
 LozO5mk+AzdRbgh0lV9iNwZn0IODGyVKUUOptVvfu/k2oGxicK2d6Dfd22LlZmQ+Nfr/IssSf
 dVVro7ZoWM/noCe77DF/bXW/a+QRDqSzYxXw0OSuqh8brkHaop3sa7xPsNsz4vGbrVqRi40aD
 bl6xQYxyeohOFI2YPd2TtlYdNgnWo5W8Arp0uRS1SGjUz3JNc46HbwcUNjAttgroWg/1G3IO2
 MJIKr/fk8l8KejpxA5eToFCkXeH0dCltFOr65IzxyazgvmEvEnT4yi56tNV3WyaBhkNBMcCK3
 xyGdGIc8OIWsmN9qxfk8wAtw9asyZVjhUvPqgIm7r2IlaNKjJzcoyt4BMXpXKkDe9lEkrCdFR
 LtrIvy8L95gMg0yHohri1YryubtO2j2M78Zn0UfVpXx9mhmfi3PIfD6bsSy+V5K6O6kVqU6Zz
 g1fa20sHXrQpItedcXfb5PcV0yVKRse9WgPUWMYqcGTg+gHSU2rCThoWg6YflTxbKEkRt2SYz
 e2BWerFkaqkrfTclIu0NEPa6DpfqdIzPwelR1SCcQwuhyYM9LAHuSOrSoS0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.19 09:06, Florian Eckert wrote:
>> I'd like to ack only the keycode change, but not the deprecated .gpio
>> field. I'll post a separate patch for the keycode change only.
> 
> I am fine if we only change the keycode.
> Do I have to send a v2 patch set?
> 

already sent one.

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
