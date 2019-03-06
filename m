Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A657920663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCFVs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:48:57 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:40887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCFVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:48:57 -0500
Received: from [192.168.1.110] ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxYT3-1gr1T62ZUP-00xqyO; Wed, 06 Mar 2019 22:48:33 +0100
Subject: Re: [PATCH] drivers: watchdog: Kconfig: pedantic cleanups
To:     Guenter Roeck <linux@roeck-us.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
References: <1551885336-22650-1-git-send-email-info@metux.net>
 <8a1297c7-f1f2-5742-0ef6-f83799510735@roeck-us.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <7413ac84-4d6b-5919-89c6-b91d2d489599@metux.net>
Date:   Wed, 6 Mar 2019 22:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8a1297c7-f1f2-5742-0ef6-f83799510735@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cRUH4aLTv2U2AVHIdzzQfgUt5Ro7UdMAuVLdigDjIB5j9ngpMhp
 cOIzsGzP5ndKg4sFLlqVptbON99PK2Yw7CbFeNtSQtf4HGd9E45DQl77lzfsff1Gqex8Y6i
 7bHAM+Qc8Tv0rcoV/P9/+XiW9Rh6JrmvJmn6KiIJAnXX39M3dCg5yPo9xPADTNe7s+dT4sx
 P1paQWgmCpgGvQ78NxSdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hplEBHiE4+E=:AZzVtTWAsYbyoxeJsfSPDM
 NyXb8KUwX5MoStLo24B6DThXZ1+Hu8dPLKkBkSXEc5IzLdJNN0/HyNz/IxWAUzXqWSEXbd0zn
 dU01X4uY7FBaLBMSoSYDnwNk4n1IlOEjFFcwry2aSLjzFikaZKe5g59eyazPdaaGp3f/ZJXrR
 XHJWmL+fRQQcFDs8VFqDw8DFFqKafpqvhKFjfXt+kUJzjubWlSC27IFpxVxcG7meTmXSLU4ex
 OqTHO4cissY9cSdDcP1O0KHVf90Rde4zhS+Jk89G8DshGmuiKaLPoVoVe+YT2k5QC9KAzWrTd
 UM273fzFjRdT3Trg7HtjFYngxqNliqfuhyof9KXNoivvMsRdGijqoyIKFomPzpAQSAmKiWtCA
 5/s7XFvyiPVxgkxAuAiBwHrf9QyE3Tut1ylyFj3B1OATCW57NMqNHAuEftMZA/YYfN/zywXYD
 fIFpnSOSO2tq1FZ1m9TtkvCvsrXhP/GgIWJLjdSfEDhBEYiM4ctpR34Wdx5xOWjbd0VjZ6xQz
 y8bh7m3yV6yEeXcugERUEzPgfw+hEjHwNoH8ZzwclRB2PcTvJc9RerT480PlOwEHJN0HAlUu5
 +HKQtPPR4WDDe5Eeh+Rz1/jt1WmmvuAg/At/2+T5bwWhimLBLibFS6Z4SflyPyxCSFa1dion3
 hVCP9ueSjw44JiLcVKtaYdY7GcSSOyDN7/XNCWB9e97zLdWIrOe9VE1Y9EbTPF2l/SkYs89Uz
 EcMHukjUZIE6MAPvsqJC1C10y82yfOD0xCxP21yJt6vmWYmOoqJ8W8r1+7U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.19 17:15, Guenter Roeck wrote:

> On top of that, while the affected Kconfig file generates 42 checkpatch
> warnings, this patch doesn't fix a single one of them. I don't really
> see the point of this patch.

Well, it's just about making the identions more consistent, nothing
else. I admin, I didn't run checkpatch.pl on that.

I'll rework it.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
