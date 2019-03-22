Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAE821900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfCVQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:02:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfCVQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:02:05 -0400
Received: from [192.168.1.110] ([95.115.33.167]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6UqP-1h4ups0rgP-006uUk; Fri, 22 Mar 2019 17:02:01 +0100
Subject: Re: [PATCH 034/114] arch: arm: Kconfig: pedantic formatting
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1552310346-7629-1-git-send-email-info@metux.net>
 <1552310346-7629-35-git-send-email-info@metux.net>
 <CAK7LNAS225duNHmorxJzx9jsaN6HNiYj9di5sXwVyiE+RwPpug@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f63de3af-eea2-7d90-ae76-9330140f9679@metux.net>
Date:   Fri, 22 Mar 2019 17:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS225duNHmorxJzx9jsaN6HNiYj9di5sXwVyiE+RwPpug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DMiDDcccUnJ2kScbonfRkfV5pMIaekMf1kJMBEf7Kk7LmVDOAlX
 Ij0+q7GeSLeFqz/Lj1zT4sbfGHMdPgiVpKm9DRWiIvyu9K9DnvAxm6Ym8+9r/8tlEjQD2qy
 r5tGaCZ1iubZ1fpZ82cvfYG61a5yYDJc967Qv3FV7tnbJc7e6/KqtAueyU4bl0O4Sg7rAGe
 sPLy7d5Ug/Za8LFTu9p1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0nNxW4kjhsk=:MXS/eTGEIzxTz5N4aitWep
 3Fgw4R4ZR3jJpIg3cqSEGO3mSTfWORp3LIAdnmrhXLzjCrTXHFFwitvDowwTMTm4Guc+cL/j6
 XSqAoNA9T5Qnb1lD96jdzMgFwpuvSOVblQLXG/fdFJxE2IRRXIJxD4ZdRE3ISla++978Q8U3f
 TR3Wk+aQQuByDAWAsz+iUleCYOcWzHzF1ehBqTVsDYu/yZTbWnb5P8x7uOXdHL5lGxZ0HHIfP
 Xf0ckExtrgvplt0NxNKsB86QOx7iHk0JsgmroW9bISE3MaDZR58RMMtw1T4An339vkFa+m3aQ
 2ohHtWE11X4dViR/LVxf1lH8qsDxETKNx7rFADI45aJiZf/C8X56ZTvNW4g4Xetx/TPxhvK/A
 Kt7rCpUVpUjKcCgs+l3oc5HEjWj7SdcQ37e9TGLpFDv23mKU6YQFM1NvpUz0nS6jbXLhTJAI1
 wVOfTZwm0nEyhJEgjiVQIT1BKDTnXb2xHuVn0gIEK7Lu5nifvsKtskULaQ8lmMoX8qd9XF8SJ
 2jNiU5/kGDkfJAuMfYtHIRFe72wiNDHQtYekkVUstRkxKpmpXVv+/+CDzf824ZtzPijKN7icz
 el5b89/L3tTXsiRWh2H6/wpb54ItPTUN9a+eaP3ywCNB17UtNQt+b8v6KsEe3ff9QGjuLUg4D
 rMZXMTVCaphwPt/rri/Wp08szmf/sl/uvimJpijf6ltdnA73CQJUWcfXsBSZq7AgVCmznGY8S
 KKD39nOmaKJDMK9+MWMXXZN1ELVCk60Mczhe5YDVuKbrOTHkPW555QnUzDA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.19 02:55, Masahiro Yamada wrote:
> On Mon, Mar 11, 2019 at 10:29 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> Formatting of Kconfig files doesn't look so pretty, so let the
>> Great White Handkerchief come around and clean it up.
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>> ---
>>  arch/arm/Kconfig              | 24 +++++++++++-----------
> 
> 
> 
> While you are touching this file,
> why don't fix checkpatch.pl warning?

I actually was about changing that, too. But I was a bit confused
by the documentation implying this still has some semantics.
Personally, I'd prefer changing everything to "help".


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
