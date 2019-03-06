Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD57C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608C920663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfCFQ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:56:34 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:45595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfCFQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:56:34 -0500
Received: from [192.168.1.110] ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mm9NA-1hRnph1DtY-00iDdm; Wed, 06 Mar 2019 17:56:01 +0100
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic>
 <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e0502efe-39b3-b488-793d-6536687b24d7@metux.net>
Date:   Wed, 6 Mar 2019 17:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qQdC/PAavTFEs+teiYJ34POjsxSGVEk4PzSRMxDKmleqc/vyPD0
 JcbTQE4f297owrSuql777TRojpQrpm2XMVkGXocEXenfFigyzReo2cwt6V+vbLp1foaquH3
 TsVeGNbIIy1vnAI+GZ8nz2IYVnJGZFHO66o9AsE87TaN/zLQr2sAhS99zqkedRkSPzWtxYW
 wXuUAyIrvaovhKN/hF8Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8tQgXNG17cY=:xdVHxHvmwi8Au1RxeU4b76
 /cg8izsCQZ+SU5oKGhGeUfJuyaAV1YQlOFs4zs4H2gm2SzLMWmwsaYFZYfthyGHhETh8v4gFO
 SfTemsg94lFxBmsZtQ3t/qX28ulwkqzKG5G+PEJI0kuOROtZL57c0HOfciwiBxdFFrNcFeoal
 pUEiJ+110U90POgucn4utsYDuDG7Xf4C5YoGVNqX3tqnGwLA4cbqjdFUkUesnuriv2ttoviFJ
 OR74sc1QvoxsD3c6S/jXbqQXs91GFQiQXRVGJkyOzQDWcIll0H3ZAGBWrnLmWpdkMidtF0Oun
 l2h1ybxhltAlasIBLB52h2lfiA5QCC+xE/voQuAlR/OnXWQMR1Irp8mj3p7Eo5f8NQuCVXt4D
 k2MlpOXrUrz8xt/KdBTnqdiE7hkdNaZLCkboeIig14de1djhNGAsdJwAWDjkWAnPAope+BVPU
 W7e5BH0KLoRksGARqtKkic3ZOG8HDQP1lOOTa5zbw/7fWuIqfZLMfEa/u+Al1SoMpN7L+2fYx
 SAx5OrIvPhKlE8VK6Od7Vclhy7Eg/gslGk9hR9W+O62JfcyUpVD6V7haaj1MveiWscggqyZ+G
 hXBf6KDPebGJJLiWiw/Efs0pTzQPiTuHpsnl5F3XD6gKoAroiAb/2YfXwKFF5cJNWhA998xik
 JwP2dafoMD2Q0j/opMQFnK/RYP+KiLnC9om9nY+iXKoBShY/5t6kcs50yHKvyyAv0Th/XMXLx
 KeckniS7AMJ1lLtet72497Q7N4miNUcBUMCqdhU049vE60Uj6Ag8M++BDUg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.03.19 17:22, Linus Torvalds wrote:
> On Tue, Mar 5, 2019 at 6:59 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> We can at least deprecate it on x86...
> 
> I'd prefer to try to deprecate a.out core dumping first.. That's the
> part that is actually broken, no?
> 
> In fact, I'd be happy to deprecate a.out entirely, but if somebody
> _does_ complain, I'd like to be able to bring it back without the core
> dumping.

Maybe make it depend on BROKEN ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
