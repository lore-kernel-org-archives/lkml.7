Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27959C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23B920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfCHVKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:10:41 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfCHVKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:10:41 -0500
Received: from [192.168.1.110] ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MUGmJ-1hSSDN38p1-00RKt3; Fri, 08 Mar 2019 22:10:22 +0100
Subject: Re: Debian build polishing
To:     Theodore Ts'o <tytso@mit.edu>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
References: <1552049064-32044-1-git-send-email-info@metux.net>
 <20190308175703.GA7178@lambda>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fe53cd84-5953-786a-3a4f-6eac652a1cdd@metux.net>
Date:   Fri, 8 Mar 2019 22:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190308175703.GA7178@lambda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3PmkOyG6x/QQ8jBy7+rUN/zFUMrd1+8/SGCKfaNgpnEqF0QY1Yq
 kdT4zLl7Hajp/VMYG9pj+GyQCMPhKKjSa5x1s4MTzL/QmMMe+4QaeRXILdHuRGY9+et6+qp
 HxWhZN5UQHkHpVdvUsIwURT1Vwwqr9kVOEb3wKq+7+80QsECpQMs1kPcYkXK1ddjjl4AlEi
 LeFGbyyRzNRvViX8g47+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k1/nOnkA0zQ=:EOzz3SvJKSI/o9mRfWIb/8
 BD5jiEtAKecdN9Vv4vDPSDCvQC32lj1IBnsi81diCLmWthfMTRzZwlbt/Fdak0NL32wgfnZEA
 6Qackka/zPsoyQgh6DO3I3pEYbAVb+F08/PnHBEsgu/VL3Iy3be8ggFv+IniY76qcNCkltfu1
 QBEDS+YlzeZZcDzRe8+nMxWulFA03MKs8BrN9CCEBssm/kmHruL1ZWo2hd1g602bxY8x08CBa
 5yKYKrw5okkp5ePICTTH/OiQnscXBgxn//09qs0a4uKtiixv9GiPFYB/cPYI9mGLS8dxNYu7b
 BrhT4hlauTslRVq6lef4KPUny/3J13CVA/pyvRNSSxzQGiWy98S7TLdTCjl4fSk2Iz0LTV4h9
 hde1CteuahXeBMIHNf6MEkqjo6E0e7bkaA16Nwbzq+CaY2wHBwQBDnwKUKch78s+UcArBq208
 acIKm4lc7x1WKaq2EG1lh8SmcBNocg7ArIVlHTKo1lnYsFI2Mz1O/nFo9isJvMjWsHMtzjqWD
 qoWoDEwKCHuZEsIGzYrUJspDQGqTLI/P9p/sveQmd0grcLaB869pv6NBUalNxtGrqj/MBkHfZ
 1tcSZg1SnkY/Vr2zuUNFGBrRm2VJls22ZYs7cqWt8tOM1tTsEO4y4gqXrlGsLUF5v4Rv9f3a4
 WGM+4wGkdhzghZ+RUngSkey6Ux2lsZo1pTuuTW4dQ9EDFDpZrviOk6J/ae+VQicN1/4AT/Ev9
 Gy7p8qNrqkz96TVBfmRiO960TUoPs9q3ul3GEHTSb5u3/XtiRiNQo11oNcU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.19 18:57, Theodore Ts'o wrote:
> On Fri, Mar 08, 2019 at 01:44:19PM +0100, Enrico Weigelt, metux IT consult wrote:
>> One point still puzzling me: once the debian/rules is applied and
>> somebody calls `make deb-pkg`, he'll end up w/ unclean tree, as
>> now a git-tracked file is changed.
> 
> This is not something I've noticed, but I build my Debian packages
> like this:
> 
> make O=/build/linux-build bindeb-pkg

This doesn't work for my environment:

The requirement is that every debian source tree has a ./debian/rules
file (w/ the standard rules like binary, clean, ...). This is called by
upper level build machinery (git-buildpackage, dpkg-buildpackage, ...)

The idea behind is building all packages exactly the same way - one
standard workflow, that just takes a source tree (from git) and spits
out some .deb files.

> So I really hope your patches don't break this.  

It shouldn't (at least I dont intend to). Haven't tried where exactly
the generated debian/rules file lands in your case.

> Also, are there any changes the performance of building the Debian
> packages before and after your changes?  And are there any differences 
> in the packages in terms of any pre-or-post install/removal scripts?

I don't think so. In essence I just replace the generated rules file by
a fixed one. Okay, it will take *a little* bit longer, as the rules file
now calls `make kernelarch`, `make kernelrelease` and `make
kernellocalversion`, before starting actual build. But that shouldn't be
the big deal, IMHO.

> There are a lot of things I really dislike about the "official" Debian
> kernel build processes (they're optimzied for distribution release
> engineers, not kernel developers), 

I try to bring these two world a bit closer together.

> so I'm really hoping that making
> things more like the "official Debian way" doesn't break some of the
> things I really like about the existing "make bindeb-pkg" build
> system.

I intend not to.

Actually, the official Debian way for Kernel build is entirely
different, and that's really complicated and hard to really understand
(that's why I'm  doing this here).

But here I'm just coping w/ the first entry point into the build
process, which now becomes `./debian/rules binary` instead of
`make bindeb-pkg`. The final result (in the .deb files) should be
the time (unless I did something wrong).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
