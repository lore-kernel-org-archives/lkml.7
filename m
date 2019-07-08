Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D5FC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5205217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404700AbfGHTpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:45:50 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfGHTpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:45:50 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPooN-1i5nb70MGR-00Mtsx; Mon, 08 Jul 2019 21:45:46 +0200
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <4b43316c-3e05-0ce9-3ada-db22996205b9@metux.net>
Date:   Mon, 8 Jul 2019 21:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SX0Kvt3nfm4cb+ofxX5Erb1XGfX3CX714EhQ9i3q8ACyJqZYvxe
 F96ZI6Y3dqRsTuXFfw4cpQb7UVyox4c8c+/XszL3fkE5wMLtazOXyLlY86+FF9nGKZiAPDK
 mvN2DioWM3Yr9pdQVyDuj/L3Mn9/SJ1d9kQ/vPnuUtJg7wCJzJ4ziX1/CZJV3sp8zHboA+9
 h6JLFbdT1qkP5mMB/CNTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VIqJ3hSv9bM=:SGGvPSlbO/qebn98kaD65f
 vBJnq6tmbicJDehzT29nuYXGa/E/Vp//6KQ7gt+LYZVrsw/iohsZ1D1ka3ALU61iJcQ7ndlCl
 wNCuCA+7L/t1sZcMvig5zBOU7mZu6FK0OtlmUleNbCEdJSmbn67M36/MqkR95a9jgmEmHOtE/
 pfog87N8/m+quJGkugM/0L5owaTCDf+BQUeKxQO9yurwuu1aDz5EFmrne1jkEBn5fFlzwCtIi
 t2PEEB6MyEIlEZmgJnCjvqvxheyl49dXdFAbDh7kWs2RwgoMW9B+j1cAwdU/hbPSyRKmMXcS/
 /S53Jz9UzqVjow2H2fIXgMb8JDfVID+pb7KH6R9XtyUwzp/f6O5Rd/KJdZ9F70f6TnUcW173B
 jGPOF7rv8BE+bRGn26TPIucKZ+SBgVSRuq1vFVHP0QOW+Xr473NZBKMguQhB6nOKIJ3Rt6m1b
 GM2dyUbzFCYJcux3DxKn72Vj8y8cMTkt4eLgaLrJ8+ed+286AbofVcYC+SK6ogyVApCGauwK2
 t9TNW+jS4DTpqqM39aI1J5wz2gyfKUCgAYth8j+eVddXJcWlHqHAsvYXotasb9EkI7LgD+tVD
 uJa1YSLqLiJGSAwchFoOCTtIEzWZCJfwOsrp3RPoi09TMeuNNky1PGwX64mUrJZOCVsR1SLXZ
 4M1VG/53D6MGNO5/qyM32zlUWdVmNo2b8afED+b5MbWu172LlXbfbVDd5i/GLXOYvnDOcP2fK
 WHAWdqh13F/1j5V+gamIxW18tDre3z7izWWmoFbJ8U+Ef2FLp8058xpzfU1sBrIq6V+aVFq3O
 Xa6W3yx1Sqds/F/hQeRPNO7KiQwg3LFsJ4dZ+SAujTFrjPTmzqbv5RZEK6YkLkYKm5eDYMt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.19 15:39, Andy Shevchenko wrote:
> On Thu, Jul 4, 2019 at 12:02 PM Florian Eckert <fe@dev.tdt.de> wrote:
>>
>> This patchset adds the following changes to this pcengines-apuv2
>> platform device.
>>
> 
> Before doing anything to this driver, what is the plan for previously
> upstreamed:
> 
> drivers/leds/leds-apu.c

Only supports the three front LEDs, nothing else. (we've got more gpios
that are not LEDs, eg. the front button, simsw, ...)

> arch/x86/platform/geode/alix.c

completely unrelated - very different chipset.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
