Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27478C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58E52082F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="UM13xKl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCOXA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:00:56 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:17056 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCOXAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:00:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 5E0957E1;
        Sat, 16 Mar 2019 00:00:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1552690853; x=1554505254; bh=pN6szm9zbdT1xUB5xTqpiOcwxa+BXp71K7I
        hA2s9/pw=; b=UM13xKl6rNuORpfkIWeACccSMR3xq/lSLIviGLQCiE+iDABQAPB
        GyoYsP5zrZIz+Y6zubIWiz9/pwUKxvLadx/v2nQFBPsfcbOFaHxMPbYcB4i+tj5e
        5xppJ1tTfHpid6cf/hdawvQ3z+7MiSAqLVgaVVLQfkWy0wVK+orzJSlGyjliTRYA
        QJZnBDbF7dxi0D7K+c17IonjG6kCQ7FJ8sCd5COJOY0cGT4uNbPvA8ZDP+OjFgtk
        QOZkW3FSL7b7vpITSmeSSL3Y4TsktroGlqzopSos7XiB+26mxpc1Yw4BKPx3aZL5
        5zmTfGSglryTT75gErF9Hstf2hIhetmNwP6R3abxAkwBCW0FaqRhepmsI/y0QOqt
        E7UCLyKOX7sWHfFO/6BSj8ICrXVOOdavRUdi0Jy9uJ516/pzlgru6HKToF7fOrJK
        5zFVXgsnShFHNXBorNczhR5oVK3uRrtls+f/ADrwSQa4i9t0RXsXwRN7h2rMj7Tj
        Pg/MRC5VA4TmuDvlyEWv/U+I36kQbbM8dVjCLFNFGsi1TDqG+6gDl0atl1nt6xRU
        4JGp05bbLNxyz6T0HwBCZ/Yr6iZzlJHrCI7xjXzA+WogeKlPhB7yZXmLVtmskXrc
        ZxrMZYVMu2Zp8ovX9dQCYXqROM562imGauTwyUPjnKbBHddg4s11Ei0M=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OEipDPCH2-vx; Sat, 16 Mar 2019 00:00:53 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 0228852B;
        Sat, 16 Mar 2019 00:00:52 +0100 (CET)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id C440C202E;
        Sat, 16 Mar 2019 00:00:52 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 16 Mar 2019 00:00:51 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add translation disclaimer
In-Reply-To: <15f416d6-79a5-604b-109b-b4f788933cda@linux.alibaba.com>
References: <20190314204516.10890-1-federico.vaga@vaga.pv.it>
 <15f416d6-79a5-604b-109b-b4f788933cda@linux.alibaba.com>
Message-ID: <3e07dc5eba1df83c8d9d8da7d8000b55@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-15 06:49, Alex Shi wrote:
> On 2019/3/15 4:45 上午, Federico Vaga wrote:
>> Add the translation disclaimer in English as reference
>> for other languages.  Translations must include this disclaimer
>> in their language so that readers are properly informed.
>> 
>> This very same patch updates the Italian translation accordingly.
>> 
>> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>> ---
>>  Documentation/translations/index.rst          | 42 ++++++++++++++
>>  .../translations/it_IT/disclaimer-ita.rst     | 13 +----
>>  Documentation/translations/it_IT/index.rst    | 57 
>> +++++++++++++------
>>  3 files changed, 85 insertions(+), 27 deletions(-)
>> 
>> diff --git a/Documentation/translations/index.rst 
>> b/Documentation/translations/index.rst
>> index 7f77c52d33aa..d7a38fd28b50 100644
>> --- a/Documentation/translations/index.rst
>> +++ b/Documentation/translations/index.rst
> This part looks good for me. I don't understand Italian. :)

I forgot to ask you if "looks good for me" means:

Acked-by: Alex Shi <alex.shi@linux.alibaba.com>

> Cheers
> Alex

-- 
Federico Vaga
http://www.federicovaga.it/
