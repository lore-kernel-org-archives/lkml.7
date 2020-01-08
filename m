Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139B8C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1896206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgAHMFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:05:08 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHMFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:05:07 -0500
Received: from [192.168.1.155] ([95.114.105.36]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF3Y8-1ivoyl0GfA-00FPKS; Wed, 08 Jan 2020 13:05:03 +0100
Subject: Re: Improving documentation for programming interfaces
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
 <20191220151945.GD59959@mit.edu>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <17931ddd-76ec-d342-912c-faed6084e863@metux.net>
Date:   Wed, 8 Jan 2020 13:04:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220151945.GD59959@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B81xQSAt90W7lKrrHbjV2P/OStxg7GmU8RRfjIZnD94fGPlyUN/
 ECLkuwC3UHDDAAYknhhOpl1QAl2Xy7sc9ZtfITFQVmbXQHsh3DwREx9a1hCttSmo7eqTmW1
 YqfL/rGoi/9eJGscTWr1GZ9Nf3OZQDn2ab6Z5wRutxW1oln/RAjdMZxxWBSJeyWREOz0a8j
 vhEBidMjdWEj2dZeh0V2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CRH5PUTDk9Q=:i9V6hMthikniIpFD7M0JuY
 8rbpaLYYW5YSM+oslMj8zDgENE9stI9O8t4TyNaqDDQH27rCX/kbm39kt2GuEyXiTm84bc1Uz
 5dPfhv5xYU+rShdyG7SodeqiZODv11UpnTI/O6gBJLZIdK4Eg4Enom0gmCYuRZduEsjVtLUpN
 fnbpTjouqi0wSRSpiJnLFnL1elvxQsE9X6Vzo0zQeDX1NrFCrPh9X5K52/Cysqp7y1tsbiUGA
 w9F0ZExYweZF2yS8e8lwdbwIyR8Fm4ZlyYj4qwwYimsdAxB0H3TAa2CCuacOlepJ2O79gpsBH
 seSXLOYR0TYqjCm/v210A0oz3PfvFQwwQeXe21GxQZ6vLsWaQE6Kvynjit3j0vyA6DbxCkXSP
 WYJThR3FpTSTBaFhvIyLk2TxmA9E75Mp+mv6y+f72QsZB4aEUb2EEqOuBa5w7AxEqAcZayVOP
 bCOlLDemlsa96wcOLvRHDqztiMbEyzH33RPY7Rw1nkd+VxSyOCV6fFNaNhNjfJvff6EPI5thr
 PvgkJxpNGBwnAyeIaA/hTq9p5Z27W4Ucy0oEiP+8mIyVFmBU3DcZCIpuZEry4xyM83BcNbyVH
 bAioHzLIYZSl4xE84r8K334nb2RQzanNLlL/uBsM7gs+Holjp6hff2Sp27HR/NPhtRl8YF0yB
 bEnUnbkya9B9zgIhmLEaCbzD3EYCFxyQiVMpJ/XtgbU2BOxMku104jgbke99PPgQ6SbJ/nCxd
 BWL70pRhPhvrgiIP8KbKqesNflqre5C8HPBLM/0dMtwgR0Wp5Xasdy2T1N82dwus8rSOZHFoU
 ktn5UQvxOixr84drSRBmdE7nvnbXtUCzrcd/NElFCQON7Uy8TFIPosVqrXX5k1PqMWB+DK21N
 MVhIqNhdsAH690qpOZDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.19 16:19, Theodore Y. Ts'o wrote:

Hi folks,

> On Fri, Dec 20, 2019 at 02:30:10PM +0100, Markus Elfring wrote:
>> Linux supports some programming interfaces. Several functions are provided
>> as usual. Their application documentation is an ongoing development challenge.
>>
>> Now I would like to clarify possibilities for the specification of desired
>> information together with data types besides properties which are handled by
>> the programming language “C” so far.

@Markus:

hmm, maybe we could add some kinda-OOP-style metadata into the type
documentation ? Or maybe extend doxygen to crossref types vs functions
operating on them.

>> It seems that no customised attributes are supported at the moment.
>> Thus I imagine to specify helpful annotations as macros.

Do you mean _attribute__(...) or comments ?

<snip>

> It's unclear to me what you are requesting/proposing?  Can you be a
> bit more concrete?

@Ted:

I guess he's thinking about some kind of meta-language for expressing
common things we know from oop-world, like ctors, dtors, getters, etc.


Maybe some doxygen experts here, who could tell what we already could
extract from existing sources ?


For start, I'd like to propose a few rules:

* consistent naming of 'release' functions (AFAIK, many of them are
  already named <foo>_put()).
* for each non-trivial (non-private) object/struct, there should be
  a corresponding release function (even if it's just an alias to
  kfree()
* consistent nameing of list-type structs, so generic macros can
  be used on the struct itself (instead just a container list header
  struct)



--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
