Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA39C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC9E20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfEFPkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:40:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33610 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEFPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:40:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so15805915edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAt1+pUkHfiJ3Hg4XJTNXo+R9FukguOnVl+FlWHruWQ=;
        b=sBo/aIJu79vrWcDrV9eF+0Q/Qneb4ucP0DV1+0DDcT0cOqFXcIDe2uiwSzeIrlifvi
         nggkMa+5xW8mqC1K+ExwxwuHcTqwmG8LQoG3VGkCXuoKVNCoIQ9Qb3dyKdWsNSXSU8Z+
         c1qfdQfe+252YWt7VOYUk3HOI8sHPlhWHAJqzLI2o4un7x6dF7SATdJXRT0lyrFbqHJ3
         moDCp6Ige9qwI4OFDN8GxY5H1VMQIxf6ZIXoLvekOcI+brfloN+Zpf+aTqE3sYxdcOdt
         GsMnrPRiT1WX7MRJYI0OPpZvwnW2vBSWeJ4KB/DsXAlH/4oWfj3V+WGbGV1ZcTELqfy9
         UDEg==
X-Gm-Message-State: APjAAAWXafecCyJw/WRF1/CpsjSN/AqWlOcCmhNcSTEzQ/LUsDVMNN8e
        TJdyUGo222s6itrmmd0qTg+OYw==
X-Google-Smtp-Source: APXvYqwkOVwYLQgYelDo9ZzuV43ZZ0RTtcphw9n4FCkU4LkSY4qTAmycWdlu02lc4BAATUf6N2RTrg==
X-Received: by 2002:a17:906:5c0f:: with SMTP id e15mr19687933ejq.151.1557157222769;
        Mon, 06 May 2019 08:40:22 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f40sm3239068edb.55.2019.05.06.08.40.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:40:21 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5651.c: remove string buffers
 'byt_rt5651_cpu_dai_name' and 'byt_rt5651_cpu_dai_name'
To:     Takashi Iwai <tiwai@suse.de>, Nariman <narimantos@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jordy Ubink <jordyubink@hotmail.nl>, broonie@kernel.org,
        liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz
References: <20190504151652.5213-1-user@elitebook-localhost>
 <20190504151652.5213-4-user@elitebook-localhost>
 <s5ha7g1l4oq.wl-tiwai@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b9ea51f6-29fb-5ae8-607b-a047eba4bac0@redhat.com>
Date:   Mon, 6 May 2019 17:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5ha7g1l4oq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-05-19 09:51, Takashi Iwai wrote:
> On Sat, 04 May 2019 17:16:52 +0200,
> Nariman wrote:
>>
>> From: Jordy Ubink <jordyubink@hotmail.nl>
>>
>> The snprintf calls filling byt_rt5651_cpu_dai_name / byt_rt5651_cpu_dai_name always fill them with the same string (ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers around and making the cpu_dai_name / codec_dai_name point to this, simply update the foo_dai_name pointers to directly point to a string constant containing the desired string.
>>
>> Signed-off-by: Jordy Ubink <jordyubink@hotmail.nl>
> 
> If you submit a patch, please give your own sign-off as well as the
> author's one, even if the patch is not written by you.  This is a
> legal requirement.

Sorry, that is my bad, Nariman and the author authors of the patches
are a group of students doing some kernel work for me and this is
a warm-up assignment for them to get used to the kernel development
process.

I forgot to point out to Nariman that since he is sending
out the entire series for all 4 of them, he needs to add his
S-o-b.

Regards,

Hans
