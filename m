Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B2AC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF7B22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfGYSuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:50:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfGYSuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:50:37 -0400
Received: from [192.168.1.110] ([77.9.64.13]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MplHR-1iB9OC3j4f-00qED3; Thu, 25 Jul 2019 20:50:29 +0200
Subject: Re: [PATCH] platform/x86/pcengines-apuv2: use KEY_RESTART for front
 button
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <1563795379-7521-1-git-send-email-info@metux.net>
 <CAHp75Vch3KNCkwp69a_fBtMy3B3k=NEbAmPZE2cn5HSn577HOw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <332c666b-1bb3-d4bb-ad1b-98b36992de71@metux.net>
Date:   Thu, 25 Jul 2019 20:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vch3KNCkwp69a_fBtMy3B3k=NEbAmPZE2cn5HSn577HOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XiqGTu9NKDQaqBPl/cRzx6B2L6hJdXsvX7UKvJuvyThRln5/2wc
 4JKAh6aiHwbN1jfIYJ+iC/3yt8F1zl+G/MNO1rGfz/W+LqIVb+Po0NWaLCrcAtnDGiqCYl3
 3m8MvI+c5iHLG663eaKC3EnGHGJQZe79EyL3tYk/FnnnMPehMJuO2TXxcrh01I96uf9JBeG
 yqVi9yF128SD8YGYnR8GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rJTikcvc5w0=:VyljYWNl/5dnjxhggb6KKy
 wYqZ+FrerODuxHwBPJ95Ta4FJoGGby1LEg1zhNnVhtkeBFZ0eLckSgp7sSlmc6W+zQVbwQzf5
 Lz5xtlszHJgqKjD/p9jiOxUtoGdgRT7w4Qwih1daI5csXasBU1sn/gmPY1XNvHGAVWucMXQrp
 J1JvvGgxKlny+cVxUWztpZSJo5SMLS8WauWX5/btQb+QTJz7HPwEdUW02ULujxjBir1qLr0qj
 RaOaYsMFJ5D76NXaay4EcJkWror+ZbkPh8xqNlmRCXjwPsSFvlWZPYm/97yp/AZM5L7I7hXye
 G2WrQr5fWaCPMmQ8ce0MDyj/DKuSNM4jN0ioPum0O20t/eecSPdaJFJ7A9n8YTCYrPhop1Z7q
 qtUzPU0eHzvy1AFXE/Ijk33kXy0fztQHxA1Czsii6i5z9/t83hKwNyl8ZzVR3RHdUxdEZxbW5
 VPdx4/WYIENacFsWZV5gWOg7oIBgrb6lCV1zKcg2McaQVOpm/PlyJMk9p60n31f5oVa8z02iv
 eWMI+NImUkZailXjJYUuFr7fN85Q5oaax6HUfX+4dSgZBwhG6SaONMAH6bP4PyqZn0sG8ICEt
 yg81lp0jNgRwRSmDgeGHPDbZN/otxHt/ofZtal+Ozu/Qi56S/HD4i5mFcLDpuRWBGc9lIfHfB
 I6IdiyAyczzcp86gKwVro8hHnxARfrKJ/30XX491mmKZXCbrCZJXwmEmpfsH/TF7s11Re1DZP
 lIDYIlyUQ8O+5L+owqyU66QU31RZ+97TeMMpOI8ZH9waay0837ESjW1N4a4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.19 19:17, Andy Shevchenko wrote:
> On Mon, Jul 22, 2019 at 2:36 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> From: Enrico Weigelt <info@metux.net>
>>
>> The keycode KEY_RESTART is more appropriate for the front button,
>> as most people use it for things like restart or factory reset.
>>
> 
> Should it go as Fixes?

I think so. Technically, the feature already worked, but the keycode
wasn't semantically fine.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
