Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3694C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926A72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfFGVvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:51:14 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfFGVvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:51:14 -0400
Received: from [192.168.1.110] ([77.4.3.118]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXoxG-1h3P5h2siC-00Y9qf; Fri, 07 Jun 2019 23:50:57 +0200
Subject: Re: [PATCH v2] drivers: scsi: remove unnecessary #ifdef MODULE
To:     James Bottomley <jejb@linux.ibm.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     khalid@gonehiking.org, martin.petersen@oracle.com,
        aacraid@microsemi.com, linux-scsi@vger.kernel.org
References: <1559833471-30534-1-git-send-email-info@metux.net>
 <1559868089.3233.1.camel@linux.ibm.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <da4cea67-7651-7284-51e6-5313b1241a8a@metux.net>
Date:   Fri, 7 Jun 2019 23:50:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1559868089.3233.1.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/bCMse1WqZ7oNEY4vFZvKN9LFM1f/TRTC3pQ7DcAleqpq7Xo8ai
 zwnPKyQyBXrJLyQV61/TX4O1dsgwz1U2SIMIzt+Y6AfKcZJNqczaN/zdpovIZlJa81u8sg3
 kUObtDK4rfzkv6kqXrDbagbt3q+Pmr+XfNZtAS2t3JnuXHoCJtQw6V5xCTE5pznqT6OsL/o
 AsfppQd8TmDEj26Hk45Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8zu0GrELbRA=:HVFy5tvIU4G51zzd+cWHIp
 7hcYMkW9nWPaYJNMctjHusm5bOAFnMxSzpCRH++x5VfzjyNw7yHQgMIDLQtKWFnd3fg6CAMKk
 //Vjzb9oU4E/2ECPs6jsQtUQCrIH+kQvQHnjfCW6Wu/TT6CZ3xjA005ykTGsu+zKaW3Kjxf/x
 CHBpWvoAGMruvpIBNtfObaPQu2A6KbbRN6gR6PBo7NwncStrGP0pGMNKYyw1TObkaQFUfSIAP
 9D9g0ctggb5dnlCapoLUjif3gVJzfO4RM7xpimAWA/aP1txmXyjGMJ7jLRqXRVMaOZmb95FTb
 3Uipcl4dDEyGCibOVqsjhnu/nv+PTvqtmaDUyz5konmFvWux3B/Q8nPMtriWxhtHZp0ZREB1R
 CQED9B6cmcW4mEuseBKUHJCMUZvCj3zrxHT83qyWmiOaVLg67OQ+EowQJ0q0sZfivYXBardYb
 kBLO7rqVv1av9kgX3SbwtWFRAn76ceWt9Vsopy3aPNHbDeQGUHOiL0GkgTUENd50etvYVdO77
 ZYYw0iaSQhahup86ZGgKk6B7HUqPV6Qlw/LOmBrCDkokD4q+XgovCxZvL4u4kzx8cKysDZqwi
 U4yU0N5J8vshhfN+jJnSt2r/RaUhaGMH0NYV+prKt0a7cPSp/z+L+jKnbauAUFA92SxconfO3
 aKnJRzys9q9N3jjraqMkBoLKLLZr8ywzzw+4lDu5IcsUHtGTskXhGLjkdF8+jnyolvDj+kGcc
 aKSnxdiEBO/6GfObCF6dtSy632O3zJqhKtg4Bn9XRTHKNkMJ7JxA4rhLtng=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.19 02:41, James Bottomley wrote:
> On Thu, 2019-06-06 at 17:04 +0200, Enrico Weigelt, metux IT consult
> wrote:
>> From: Enrico Weigelt <info@metux.net>
>>
>> The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
>> so the extra check here is not necessary.
>>
>> Changes v2:
>>     * make dptids const to fix warning on unused variable
> 
> I don't think this works; in my version of gcc, const does not defeat
> the unused variable warning if I try with a test programme:
> 
> jejb@jarvis:~> gcc -Wunused-variable -c test1.c
> test1.c:3:18: warning: ‘i’ defined but not used [-Wunused-cons
> t-variable=]
>  static const int i[] = { 1, 2, 3};

Which gcc version are you using ?
Could you please have a try w/ the kernel (plus my patch) ?

Tested w/ 6.3.0-18+deb9u1 (stretch-amd64), got no warnings.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
