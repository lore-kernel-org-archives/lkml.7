Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FCC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43412067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKUSe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:34:26 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57175 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:34:26 -0500
Received: from [192.168.1.155] ([95.115.120.75]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkYHO-1i7u7k0WPW-00m14R; Thu, 21 Nov 2019 19:33:42 +0100
Subject: Re: [RESEND RFC PATCH 0/1] CAP_SYS_NICE inside user namespace
To:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
 <CAG48ez3HfUx2aRvqR_bWnGoTshrHnUzxUNt7K6Sv7cqtPDWaWw@mail.gmail.com>
 <9a63f7ae-562e-67a6-8f40-050c58c08933@oracle.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <c7949242-385f-3256-b290-87640acd0577@metux.net>
Date:   Thu, 21 Nov 2019 19:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9a63f7ae-562e-67a6-8f40-050c58c08933@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f4V3p2RzdrPwVJnKu5LMb5jYm/ztyDQ1aQI1zNG7i6cs0PgvB2J
 blQvMHxD9q3exo5iHY4pJSv1MgcdOpQfhYHa8NAK7/kv9U2kPfTsakqxtVNp+nkO+LXLlK8
 UP3tP7HSpwzkFQ2luhsPMUk3tYF3ofYIXAbkGxUB0cMjHgnaXWeUoA+xr66yuCSYKUIFj3H
 yM3kDPRBZs4x+FMIWxhdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0FgFYkZ95Cg=:OVngFMmR2my6a8VSs7HgP1
 Ut33/G7o/ulNAUVsrK3DfCxuyoDaepkifM3CJxF+AwHD8tgAQVKyAt/WwhLwuAurd36Ocg8n6
 3mS53t/eESTlgbt7orNPYKuT3gNtkc9/c0rEjOtEwFmhrM5fxjRxkCpSQCId8Bt3QyTPfGPKO
 +TGlnAWOV9YKwjHoAwJqXXM3wqgvMztolr8W2jmir/taiTT5kzFU0H9ldLRVpeOBGBV9M5ga9
 BaQLBBmiCSLUpf6uH1f6DkcKcjb1hsKJRiyUZON+HATvtX1Kn4gWkAnUExR3joEfA7x+1G2kf
 oNWYTDln3lfduojWuCLltrQvl7GUdSlprZijBpxMbxpLZ1W8VBBeGDX9VGrmCnEsQRFc1QRfk
 +wEL7y0EZi72jzeMbIdeiEaJ6qPIU/XwAJOCrDKU0C3FWDxxOsmbb7yuUJCvVsVcelWvWjDWE
 mfNrMnV/hvwH3YE4FcWZ8A7fXFPj567vuN9inuACwVAITERbla2LfXx54ELCF0SkoZ4KMofXd
 AyFKAqRQ4MRZj4uJ0IuE2T2gA3aBNeYvHnWKzlKXMckeokEayHK+IoKakD4re9/GbM8Atb+cS
 Ha4r+id8d6d/dREvNlZqgGI92/7VrOTur9tOuKZjDqpMzmfuo9zdQ6U7A6KpVd/lWmaTr+bli
 4blMs4o7eS+qn0y3Vhg5nmtfRg8bBjfZzPGl7ufBdHkl5b2M5VxpBWgSSoLJ9mydk0XmSuMd5
 ZeWDYVNvKgywxfs5qdXHjZq7aX7uoDzuGqii3QVnoSzOXln+6IEPPoFPa4+GH5eMnI/UMNKWh
 LhnF6FvTNrABZCKS2eurJCMe2n1hrImiCDWv85XRkhRr15DgOoBn8torLbtaKs30QGQySg/Qo
 J7vl4VcBmKe09SLiRcCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.19 21:34, Prakash Sangappa wrote:

> It is more the latter. Admin should be able to explicitly decide that
> container A
> workload is to be given priority over other containers.

I guess, you're talking about the host's admin, correct ?

Shouldn't this already be possibly by tweaking the container's cgroups ?


--mtx

-- 
Dringender Hinweis: aufgrund existenzieller Bedrohung durch "Emotet"
sollten Sie *niemals* MS-Office-Dokumente via E-Mail annehmen/öffenen,
selbst wenn diese von vermeintlich vertrauenswürdigen Absendern zu
stammen scheinen. Andernfalls droht Totalschaden.
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
