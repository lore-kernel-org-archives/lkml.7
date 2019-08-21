Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E96222D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHUMKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:10:21 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHUMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:10:21 -0400
Received: from [192.168.1.110] ([77.2.122.154]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MhToz-1iVbb30aX5-00eeYg; Wed, 21 Aug 2019 14:10:14 +0200
Subject: Re: Status of Subsystems
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Duda <sebastian.duda@fau.de>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
 <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
 <20190820171550.GE10232@mit.edu>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <57a7ae11-282f-8b93-355c-4bc839f76b23@metux.net>
Date:   Wed, 21 Aug 2019 14:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820171550.GE10232@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TC3Ok5ZKV1kdcB6z/l30Nr6PZl/zacyPMh9CBmQC8HoUGej80en
 vtkvXaMegYa23e220OZnf8ar/37AWWkuJJE7s7MijZjWlHD6XpKr0IBhGaX9UF7pscu4gju
 K8jbSYa0EwI4BQOfFSkoafhv8PfxdE+rS9ZTnbaLL71p2OUBwt6JZj1O7s4sAn1lso/QW+1
 rey7rYTz+yEVivxz0dDTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCFpNU5h/1w=:E0k6zX1BQOXIiPmFoU0PTF
 7LzX6V5XdPgT39XpRdMOIbHRsc35/aTz6vv6zwPrbbUZOuU9ABiHBxHuwm8NqaECGvZ1y6MDA
 Juq2zQfkKQczhV+rr9hNEx/Lpf4MpdlptyFfWiXNkCkFrftLE2yIF3Lj3RzrDEdFgFTq17ZsI
 JdKhnXAWkETQ/wZfTZGOeciZZYB7n1d4EZDTEbuZtDKsNzvXSLQvo0AWqyT53fp2HD7H3prTG
 VVNGAmNpcb57FPcMA1FN1Z9VGPUBkCWhMASschWVPfuvZQRj8YYJs+gvpvDtD8vdK3YromtvE
 8nT2f9cioTbN+jzDgcKTvfLZZ9lFXa3c7EeXLDhUjrPTgckdMPOgS/nKnSVV7dmsAQyMuMmzK
 qZ2S5lTpO2rBmwnnGKB2KVHS/hc3RdTnbCOABqNQzsgtkK6HafBRbpJdVryXYsVdv63a5Ot4c
 FlMvLyNb3UhBxf+MP8OOTfH5lzVpD5LHk3kgHBhdO5b+i7Zm5/CpECTNb7DDBIyFMMUUEuDo1
 e4rG71dQNp304f+FhlZEoV8n8ceoUSqJuo1sh8Opn2GDZeMY5idwTY57A64zkvUSWaiCuBQPT
 1aGLgCqR89MDWXl99VVVhwpowVTepw08I3N5vXzd4CSlMG4XnU/5nPuAu5zfE+ATUw8+NM8cE
 eQPI+1CvWLBSxrso9HzQ54QLDM5dR2BNWEmJPCqI6gy6WE02eY2PYofR/1BCoKs4muoZHMrzJ
 IRJEs/gpHf1e9cZqTbV+R7IxVVpHwaRCb46YQktgF5gUpxeNaNj11eqE5mk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.19 19:15, Theodore Y. Ts'o wrote:

Hi,

> There are some files which have no official
> owner, and there are also some files which may be modified by more
> than one subsystem.

hmm, wouldn't it be better to alway have explicit maintainers ?

I recall some discussion few weeks ago on some of my patches, where it
turned out that amm acts as fallback for a lot of code that doesn't have
a maintainer.

@Sebastian: maybe you could also create reports for quickly identifying
those cases.

> We certainly don't talk about "inheritance" when we talk about
> maintainers and sub-maintainers. 

What's the exact definition of the term "sub-maintainer" ?

Somebody who's maintaining some defined part of something bigger
(eg. a driver within some subsystem, some platform within some
arch, etc) or kinda deputee maintainer ?

> Furthermore, the relationships,
> processes, and workflows between a particular maintainer and their
> submaintainers can be unique to a particular maintainer.

Can we somehow find some (semi-formal) description for those
relationships and workflows, so it's easier to learn about them
when some is new to some particular area ?

(I'd volounteer maintaining such documentation, if the individual
maintainers feed me the necessary information ;-)).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
