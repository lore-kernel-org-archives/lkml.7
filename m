Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D8A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfDXKsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:48:12 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfDXKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:48:12 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M58vU-1hKLNN3T6q-0016qj; Wed, 24 Apr 2019 12:48:09 +0200
Subject: Re: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree
 module device table
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-2-git-send-email-info@metux.net>
 <20190419074021.tigbyfezmt4erjms@penguin>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fc747fb3-e670-79a2-f4bc-b989dee469fa@metux.net>
Date:   Wed, 24 Apr 2019 12:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190419074021.tigbyfezmt4erjms@penguin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0bqlGMOoLygRgLPBmf8Gl6aWDmtxVM6IeWIXfwCmCGuUhQjOlqI
 LnCrtIj68wxxUupOC+rHA5VA/snVEcB1xA9theB1nsFk0SLu9XC2x4g06XqehCAxCpo7OWY
 tNC5vlKYBjrJSWgiEe221uP4ZSzvbaGobbEGyJzREC2sn7juHgk11UrdY0rI8DMkXH7yVuy
 QsG+uj4LTbWJr1hLoTFHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kl/g8kHN1os=:4e3FLanJiuBA6pt3fAXqbv
 KZYGyQGyrUvZqlP8eDUJOWfpIUPJcyFk58WT0nKP71Kybb1egPIwcFyQ5CeVfY97AnPPCpwh3
 ACj7umEqS1jv+RNxD0JJ5StlLgpq612Vyu/cYs7zFHL6dVrzBZRuWYbAwon69dClB9dKlwUHl
 GkdAGCEMP5dODA4fzwAl8yjY1fBqRIGJ1F+8aVZ8Z+17DqLfMd6uNWJ4O6UqcI53RlV5EUSFm
 JPXpWAtbPtkq/H2WeKll/3Y/Rvh9CaW5hTpJ6E0Z2nCQMUHia6F1iAb2RyjSarDRr1pl5e0Ij
 kx48HsmFvsMfsipifGLiNl5u1jf8yUVZuI8Cp73486IPZ+H6Ch+zmP4nYky71r131Hut28fad
 ENNJlIKAcDnQQ5/ggbhkIGR/fk9LGsUPHFMhIYzQLAhe4tU5WY0fjc7EuwBtL/mND9i85ePhG
 8C74Ew0JbqSe7Vm5dtRlmeoBrQn8rb/ePe/MWTWNA59abZ3eoAqImlkzZURtcjcOEh7X4wOtL
 CHAcPWeZqJwqdGSPy+IHr3aBU5Ea3B1LyEbImjaSEn3BwMmm03iln/mxZ0eMdKH9T4XXK+SBJ
 hP2slbmp3Wbdb4CAn6pil8YFkbQ1ye4OaouUZ4ktG4E+vUdry66QDyumXw+1AykiIwN57x7UB
 hJ8H0Dznvv3nFpBEnn8wYrBg7hL9vKQ8zfbkRikjIT2x02VCrjgc0BiW75Kz70dqvO9mTHsM4
 yoqZzuvheY0P4O4qxoY9uPV1f20aJ1wsZIxwmPHA11FSzNJ9WhovEDmDT4g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.19 09:40, Dmitry Torokhov wrote:
> Hi Enrico,
> 
> On Tue, Apr 16, 2019 at 09:57:22PM +0200, Enrico Weigelt, metux IT consult wrote:
>> Little helper macro that declares an oftree module device table,
>> if CONFIG_OF is enabled. Otherwise it's just noop.
>>
>> This is also helpful if some drivers can be built w/ or w/o
>> oftree support.
> 
> This should go to OF folks, please.

hmm, they should be CCed, if my script works right.
This one is only needed for the 4th patch (skip oftree...).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
