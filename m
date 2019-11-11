Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF57C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9F7214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKLSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:18:06 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:20733 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKLSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:18:06 -0500
IronPort-SDR: 8ul6lPwye0br03r2TOSidBFiJv5F9OKrE3WNxHbsTJC/DYlC5Wv06kU1fW6OGSY25G8EHy53mN
 /I+KgXagucklYKluJjjX/6E6N0NnEO1DxPwEDpye0kFGlhYWbEl4F7GPPQLMqabqnMVM7V+S0a
 OV+PigHwHngHh7eme3vOSazqDugPbyiu/1sNUmttuEyR5UrqbKriBBxt1ONNAJyk8Mizl6wIJw
 jRSiCgCWkjRRmAStRV3K2yLJhyQTSe0UxwdqOGqJfK/GVQVU5vhECH4a8daMqGRx9gnSGG/7w3
 XAs=
X-IronPort-AV: E=Sophos;i="5.68,292,1569312000"; 
   d="scan'208";a="43051262"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 11 Nov 2019 03:18:05 -0800
IronPort-SDR: 6KRljqEPFy4kP0bWVsq1qphgjWHTuQ8NIN4S7farfvusPhHEuQyUWPOhLwjIFs03EOw/h1P0hz
 WFGidB+fDtPeMYLr7LGNVA8OpFGNtMQP8zwwgFBeBUKAvA6XQGOOBF9P0VLreiOf43Ai6r1rna
 J5TePq5zg0/INcedVPVbbvTWiCwAwAJdphsUUfEVF5jvL9wbmt5lVyjcr3J78tTVBUjPtw1TZ1
 V2cw/m0xddSEVoyT4NhiCv62dPNm0mT5uywNzZV5Pslcmm2lolHklqjUaGo6uGL4mRnWWWgWZm
 M54=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        'Jaroslav Kysela' <perex@perex.cz>,
        'Takashi Iwai' <tiwai@suse.com>,
        'Timo Wischer' <twischer@de.adit-jv.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>  <20191105143218.5948-2-andrew_gabbasov@mentor.com>      <20191105143218.5948-3-andrew_gabbasov@mentor.com>      <20191105143218.5948-4-andrew_gabbasov@mentor.com>      <20191105143218.5948-5-andrew_gabbasov@mentor.com>      <20191105143218.5948-6-andrew_gabbasov@mentor.com>      <20191105143218.5948-7-andrew_gabbasov@mentor.com>      <20191105143218.5948-8-andrew_gabbasov@mentor.com> <s5hlfss862t.wl-tiwai@suse.de> 
In-Reply-To: 
Subject: RE: [PATCH v2 7/8] ALSA: aloop: Support selection of snd_timer instead of jiffies
Date:   Mon, 11 Nov 2019 14:17:03 +0300
Organization: Mentor Graphics Corporation
Message-ID: <000001d59881$96979fa0$c3c6dee0$@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHVk+YmK3KlOO6PeUGxcY472O0ao6d/XF4AgAB4QPCABgZDwA==
Content-Language: en-us
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update (v3) of this patch set is sent to the mailing list:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/158312.h
tml

Thanks.

Best regards,
Andrew

> -----Original Message-----
> From: Andrew Gabbasov [mailto:andrew_gabbasov@mentor.com]
> Sent: Friday, November 08, 2019 9:09 PM
> To: 'Takashi Iwai'
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Jaroslav
> Kysela; Takashi Iwai; Timo Wischer
> Subject: RE: [PATCH v2 7/8] ALSA: aloop: Support selection of snd_timer
> instead of jiffies
> 
> Hello Takashi,
> 
> Thank you very much for your feedback.
> 

[ skipped ]

> I'm preparing the next version of this patch set with the changes,
> described above, and some more code cleanup. It will be submitted soon.
> 
> Thanks!
> 
> Best regards,
> Andrew

