Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AFCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76E3206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfHMVo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:44:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38302 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfHMVo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:44:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so109139144wrr.5;
        Tue, 13 Aug 2019 14:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GHzSLD8380XO5cvMJ3boVjrnEElPkNe5Hv186h7Ab/g=;
        b=G/X6BEZPF1P/ObINDdtQfHHnqvj2I6+e2szLLAh5NqiYJ8o4cJYLHEVpNP8q8db1h7
         ZTpfgrkT7tFL1n+r9MzA6JfSAMvGZf6TE+trSCwjzdmv0Qf+GnxkO4izV4HGyROTbXpB
         sotgsRWFTrYepFAWsGS0AkSWfcGXC/Eg4qUmfAlv3Vl6mNXxgMiYMd1Vr23TZbKkfqFi
         5CIuVjxqiA+dFiOm9/z5hmNKPBfiVsMXIkLV5rqJA/v1TO3Ts+rj7gTaCLldA7cdPN+5
         BMJYK0HrY9vetU65Cr5buUjTOcA6MZ5EASPyUayd7DjoZBsjNLjFlnQrEyrHt3XTZDU+
         M2iQ==
X-Gm-Message-State: APjAAAUkNuW2vj7xhogCEaa4nm2ZAZWhpSRoehW0jIaoT6Mu7tLxCwpP
        ej4ynFT+XPb1bz9b1TTWDf0=
X-Google-Smtp-Source: APXvYqz6c4gFO3wb0bC1PSubSlMD0NZJFOM2QauOX0Mff41FyyTyiF7KorOO0PDEPQkLvl+kXwPzIg==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr41032995wrs.82.1565732697294;
        Tue, 13 Aug 2019 14:44:57 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id u186sm5034219wmu.26.2019.08.13.14.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2019 14:44:56 -0700 (PDT)
Subject: Re: [PATCH] ahci: Remove the exporting of ahci_em_messages
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190710152923.25562-1-efremov@linux.com>
 <27240C0AC20F114CBF8149A2696CBE4A60BCAAEE@SHSMSX106.ccr.corp.intel.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <340001e6-1750-b6b5-9482-3843679acb63@linux.com>
Date:   Wed, 14 Aug 2019 00:44:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A60BCAAEE@SHSMSX106.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 11.07.2019 04:03, Liu, Chuansheng wrote:
>> -----Original Message-----
>> From: Denis Efremov [mailto:efremov@linux.com]
>> Sent: Wednesday, July 10, 2019 11:29 PM
>> To: Liu, Chuansheng <chuansheng.liu@intel.com>
>> Cc: Denis Efremov <efremov@linux.com>; Jens Axboe <axboe@kernel.dk>;
>> linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] ahci: Remove the exporting of ahci_em_messages
>>
>> The variable ahci_em_messages is declared static and marked
>> EXPORT_SYMBOL_GPL, which is at best an odd combination. Because the
>> variable is not used outside of the drivers/ata/libahci.c file it is
>> defined in, this commit removes the EXPORT_SYMBOL_GPL() marking.
> 
> Sounds good to me, thanks.
> Reviewed-by: Chuansheng Liu <chuansheng.liu@linux.intel.com>
> 

Could you please look at this patch once again and accept it if it's ok?
static ahci_em_messages will trigger a warning after this check
will be in tree https://lkml.org/lkml/2019/7/14/118

Thanks,
Denis
