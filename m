Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA81120643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ZsvVh06m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCGMaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:30:21 -0500
Received: from forward102o.mail.yandex.net ([37.140.190.182]:57687 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfCGMaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:30:21 -0500
Received: from mxback11j.mail.yandex.net (mxback11j.mail.yandex.net [IPv6:2a02:6b8:0:1619::84])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 5D4CC668054B;
        Thu,  7 Mar 2019 15:30:18 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback11j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 4RDH2LLGUP-UH5aVuE8;
        Thu, 07 Mar 2019 15:30:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1551961818;
        bh=dxD2XnRhQ95OzlYljk8PyJoOf/sgnXy+/iI0/yoKbys=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=ZsvVh06mga6EBN6IUIngl7XsVpp2/BCtPAA5Al3mOBcZE22vrQXlYDkuZlnKhXlF6
         mC/jZH8xdIW0bQQwtB7XEyV9c0J3q5pTT1+CiXH4IaQmEkDWdaJ59lnMxvRUIQhx0w
         dkmq0rNJcKMRx984d6IVqRyLzP7xuHmsaRrZ2SZI=
Authentication-Results: mxback11j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id BzDenTRyYn-Tvr0R7XV;
        Thu, 07 Mar 2019 15:30:15 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
 machines
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
 <20190307112041.GC13633@kroah.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <c84c9553-e31b-a175-59a3-aeb35afd0854@flygoat.com>
Date:   Thu, 7 Mar 2019 20:30:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190307112041.GC13633@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/3/7 ÏÂÎç7:20, Greg KH Ð´µÀ:
> On Thu, Mar 07, 2019 at 04:08:20PM +0800, Jiaxun Yang wrote:
>> Some AMD based ThinkPads have a firmware bug that calling
>> "GBDC" will cause bluetooth on Intel wireless cards blocked.
>>
>> Probe these models by DMI match and disable bluetooth subdriver
>> if specified Intel wireless card exist.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   drivers/platform/x86/thinkpad_acpi.c | 70 ++++++++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

Thanks for remind.

Should I resend this patch in correct way?

> </formletter>

--

Jiaxun Yang

