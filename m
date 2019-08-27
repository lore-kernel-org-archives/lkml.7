Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A0C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98CB21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfH0QrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:47:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43191 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfH0QrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:47:16 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2ecl-0008LT-6r
        for linux-kernel@vger.kernel.org; Tue, 27 Aug 2019 16:47:15 +0000
Received: by mail-pf1-f200.google.com with SMTP id a20so15052285pfn.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=83Jnn+lYvZhWilMjh//uRA36kKFCssBPDfUrkcLCEa4=;
        b=bITUpQcYHGv4dWQPSEL+GIqQYONgd8TUCsb2hVWmdFNd3fqsT3HXlqK6MzWSA4el0K
         MLDVJh4MgOVIf1dM/UXQ5t5z5KdcnRuepDaxOrveQ+qdVgP7eIurJe7fX1FIpFiq944S
         jmeaTjq/VkIpzNLY48ESRSxKwUDGqp1to4k5vdo6uUZGcXdSexC8C711DR0uNvZCLyR1
         VKSqQTZOAQ08JvcOLXdVsiZ4z68rN1AHnSyJjXdpD/mBGNyKzN6OkGImIvHQIz9vJjX4
         h64C0KddhOgK9OlOtfFxgDol1GyY8rqF3H6MYjut1wBDL1c3aky62Ou6jCvAsyDXf0Wa
         Z7mw==
X-Gm-Message-State: APjAAAVylgIBv1ITY3GbIWAe/YJ1Ph8riTwEyCenZc/g1wzaVC8I+i2S
        VEazeOUbaE6Hnfk5aEB14uU15Ex/OJrjHqk66jFK5WnW8dVrxKC6Kt3GlPq44unJiSL/5Qd/frm
        e5zF1ioehEOriSUKfJdidnO8bCb+J7wDXu3Qlx/1iLw==
X-Received: by 2002:a17:902:860b:: with SMTP id f11mr25071964plo.48.1566924433608;
        Tue, 27 Aug 2019 09:47:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylX5mWi+y3SfWC6UQfF9ZhnuAr/ERr0PCwjP4/Unoj7TiYrgmfw981tKbKrCV2V4McwBWARQ==
X-Received: by 2002:a17:902:860b:: with SMTP id f11mr25071938plo.48.1566924433252;
        Tue, 27 Aug 2019 09:47:13 -0700 (PDT)
Received: from 2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net (2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:843f:e5eb:ba09:2e70])
        by smtp.gmail.com with ESMTPSA id 131sm17042232pge.37.2019.08.27.09.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:47:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 2/2] USB: storage: ums-realtek: Make auto-delink
 support optionally
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1908261141110.1662-100000@iolanthe.rowland.org>
Date:   Wed, 28 Aug 2019 00:47:08 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <3708E7CE-1CE9-4542-8C6D-8019650DB419@canonical.com>
References: <Pine.LNX.4.44L0.1908261141110.1662-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 23:55, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, 26 Aug 2019, Kai-Heng Feng wrote:
>
>> Auto-delink requires writing special registers to ums-realtek device.
>> Unconditionally enable auto-delink may break newer devices.
>>
>> So only enable auto-delink by default for the original three IDs,
>> 0x0138, 0x0158 and 0x0159.
>>
>> Realtek is working on a patch to properly support auto-delink for other
>> IDs.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1838886
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Use auto_delink_support instead of auto_delink_enable.
>>
>> drivers/usb/storage/realtek_cr.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/storage/realtek_cr.c  
>> b/drivers/usb/storage/realtek_cr.c
>> index beaffac805af..b304cca7c4fa 100644
>> --- a/drivers/usb/storage/realtek_cr.c
>> +++ b/drivers/usb/storage/realtek_cr.c
>> @@ -40,6 +40,10 @@ static int auto_delink_en = 1;
>>  module_param(auto_delink_en, int, S_IRUGO | S_IWUSR);
>>  MODULE_PARM_DESC(auto_delink_en, "auto delink mode (0=firmware, 1=software [default])");
>>
>> +static int auto_delink_support = -1;
>> +module_param(auto_delink_support, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(auto_delink_support, "enable auto delink (-1=auto  
>> [default], 0=disable, 1=enable)");
>> +
>>  #ifdef CONFIG_REALTEK_AUTOPM
>>  static int ss_en = 1;
>>  module_param(ss_en, int, S_IRUGO | S_IWUSR);
>> @@ -996,12 +1000,22 @@ static int init_realtek_cr(struct us_data *us)
>>  			goto INIT_FAIL;
>>  	}
>>
>> -	if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
>> -	    CHECK_FW_VER(chip, 0x5901))
>> -		SET_AUTO_DELINK(chip);
>> -	if (STATUS_LEN(chip) == 16) {
>> -		if (SUPPORT_AUTO_DELINK(chip))
>> +	if (auto_delink_support == -1) {
>> +		if (CHECK_PID(chip, 0x0138) || CHECK_PID(chip, 0x0158) ||
>> +		    CHECK_PID(chip, 0x0159))
>> +			auto_delink_support = 1;
>> +		else
>> +			auto_delink_support = 0;
>> +	}
>
> What will happen if somebody has two Realtek devices plugged in, where
> one of them has an old product ID and the other has a new one?  You
> shouldn't change the value of the module parameter like this.

You are right, I didn’t think of that.

>
>> +
>> +	if (auto_delink_support) {
>> +		if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
>> +				CHECK_FW_VER(chip, 0x5901))
>>  			SET_AUTO_DELINK(chip);
>> +		if (STATUS_LEN(chip) == 16) {
>> +			if (SUPPORT_AUTO_DELINK(chip))
>> +				SET_AUTO_DELINK(chip);
>> +		}
>>  	}
>>  #ifdef CONFIG_REALTEK_AUTOPM
>>  	if (ss_en)
>
> Instead of adding a new module parameter, how about just changing the
> driver's behavior?  If a chip doesn't have the right product ID, don't
> enable auto_delink regardless of what the module parameter is set to.

Ok, I think whitelist is a better approach until Realtek comes up with a  
long term solution.

Kai-Heng

>
> Alan Stern


