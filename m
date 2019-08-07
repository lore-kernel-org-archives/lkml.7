Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C234C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E063121E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbfHGOR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:17:28 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42029 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbfHGOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:17:26 -0400
Received: by mail-ed1-f52.google.com with SMTP id v15so86456826eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Be0Cb22cTMLMcceVieGRF6nmMJLyGmyUDm+x4KoV/LQ=;
        b=tnw8eiKwUjjxkBTwcVSDy/WDmWvSVLnVSDglAtoagZITW/6ybgRRw2XLmA9gGW2vTa
         E2Z4BPNcPzOwDQ0s8V4KkrWGF1kLYY9lmZb77gnw+ckAgfr2DWLoIXLiEMXuxy0thiTW
         TlmKbtTWb6jnJ9BXCpbAolTp3HiSlo9RZguhsFqvYo8VgZmiMAXCc0u+LBZ00wNWr7M4
         cqRtLPmPeBWKWNgH0+JRwE22sNeJwk4rFv0s7zp+dEUyPbl/K+7SP5rOnHxtYAT8w/1e
         y8JCkiMNJPnIiTznILnxZ2CiaYihUG4JzIX3uXaSadW7QkW6K5D8GsbKqAHdDUEZL0L/
         xsag==
X-Gm-Message-State: APjAAAXG3jOPROkaI2EHocrGYAVG/na4TFPabPsGT9OUZtkboN8jHDvl
        8DtsqJ1K7G2tPhtKcYH+UJKHp63x
X-Google-Smtp-Source: APXvYqztf95wiUacHdW6ByfiJkRtGVSqVoaFIvL7NDnkAHhSdmT9VMwVw8O9ZMxaHcliQJJBUoNgvQ==
X-Received: by 2002:a17:906:398:: with SMTP id b24mr8601800eja.78.1565187444057;
        Wed, 07 Aug 2019 07:17:24 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id 17sm21347730edu.21.2019.08.07.07.17.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 07:17:23 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: Merge branch 'floppy'
To:     Alex Henrie <alexhenrie24@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAMMLpeQMPJjSx-hqZ75LCV0wC-kQBmqEe7wjb2oU5iq-pc5bfw@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <f72844c7-c6a1-6bce-210d-481c68171245@linux.com>
Date:   Wed, 7 Aug 2019 17:17:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMMLpeQMPJjSx-hqZ75LCV0wC-kQBmqEe7wjb2oU5iq-pc5bfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 11:36 PM, Alex Henrie wrote:
>> Actual working physical floppy hardware is getting hard to find, and
>> while Willy was able to test this, I think the driver can be considered
>> pretty much dead from an actual hardware standpoint.
> 
> Just for the record: I have an Ubuntu machine, still in daily use,
> that has a floppy disk connector on the motherboard. The motherboard
> was made in 2006 if I remember correctly and has a quad-core Intel
> CPU. It has both a 3.5" and a 5.25" drive installed and they get used
> every time somebody finds another pile of floppy disks in Grandpa's
> garage.
> 
> I'd be happy to test floppy driver changes on this hardware if anyone
> needs me to.
> 

Hi, Alex!

It's good to know that you could help with testing.

Thank you!

Denis
