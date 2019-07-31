Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7021FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D523206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfGaNne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:43:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGaNne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:43:34 -0400
Received: from [192.168.1.110] ([95.117.90.94]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5g68-1hzwQB3xcI-007BDG; Wed, 31 Jul 2019 15:43:26 +0200
Subject: Re: [PATCH] platform/x86/pcengines-apuv2: add mpcie reset gpio export
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <1564557670-10849-1-git-send-email-info@metux.net>
 <CAHp75VfoVr8wjeNj5KBUsexgREaCJYcr=1dPLDcQNN=VUAtdTw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <b0a41728-7f7b-f91a-2eb8-9a1d713729ad@metux.net>
Date:   Wed, 31 Jul 2019 15:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfoVr8wjeNj5KBUsexgREaCJYcr=1dPLDcQNN=VUAtdTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B/sT9pbw0l3Ry7twfUp/Uzs/E/pjZZNyG7tvZncjoCajuS3Q30d
 kiV3siwc9D0XxrbhGBdPsq+5dKUAzaJKWErBGwPikjS/RpQ6uZdN8y08XkFsKssEdWVUTqF
 GjBQ1144oggBK83fGvdWJA9kiQlFww6YqDwOolbLeCMF5p6mlSEsjY8ZL/3g/MA523eI9Ag
 Y48lynAMy/+BCY7vonZpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AD6YSxco7PQ=:hd6bSyIPdH2tyrVPwYWmEB
 dZr2Qg0zHGI/3/hlxa9rKgW1TlU+xSUKb+T3UedOd7qOfus2HgclUXrcWmxGGAqHkwS0Q9g1y
 BA2uFoi5nOBiLmswgld/T+dKbU9//3kkSpMAppfaNfAQM8dlJyGltSCiu+IIhJlSF7Jdwtrs5
 oARSDUiZGmkF3YCQw6pR6L/UpRI6K4feM8eBsNRj5VhXIVzyYoW4pI1TpyaphKNPJdn56TCZ5
 Z0xfTXF7MCrXGJKD1221ySug/yAl0OpZzLgnrxkwxVi5SLCD376mO2GzERWmp+uLSHuVsQtOC
 F+M1wOWBOVBHrORSe+jCcVkicExdeTfYt/EEpZ8uHAx9Czf3EWEcaEDiK9koFk88ljwfW6Kdt
 mJKhlzzJTbuH+//s81eCianU7Yxad7hhoCtpCj/GnkECQfkH3bVwKWwbfvYsX0Tjr+K9ZU2iN
 P4lI3wztMxKNtVntmJTtTpfQ50g6etR8qsi8LSuRyMdt6/7qlASPOur+KjLnWmzcYJPWb9iIH
 SE8l+Y+MLolQ50FUt5wN2GbXVnWaJkFeI9Ny5v5HM9VhUJ7D+PQCV53PRbDzo91jHZFJf02Mg
 lqpi17l3Tol8GwApGa/kspzmqOb6OfHahX/iaecgSEuVoqanzQvaakSzsKbpzxlUBT+MoYDgy
 6H0jUqkVxyrZgJR5m8lUXreDc63EGpSPcgso8jAHc7AG3fRH3kS7vondcWQF/6MmyqKnvle1h
 tLjtmvbajN6D/UjYaHA9XlW44+yW+dMaipYSw3djxzUNO2h1cpf1xHG5TrQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.19 11:42, Andy Shevchenko wrote:

> I'm not sure why you resend this, where is the changelog, where is the
> version bump?..

I've just resent Florian's patch from my queue, as he didn't respond for
several days and I've already acked it.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
