Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91045C88CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFD7207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbfIWUt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:49:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54927 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389052AbfIWUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:49:27 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iCVGv-0006eK-0y
        for linux-kernel@vger.kernel.org; Mon, 23 Sep 2019 20:49:25 +0000
Received: by mail-pl1-f197.google.com with SMTP id a6so9285698pls.20
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxNzTOgLv3xy8mspZc8sJjMKJWb5QYhOaWEZbCssyrY=;
        b=d3lryXOYQeeaO115jZpkPUL48X0xotYee3hjEDarQS4DRUz4x9C+/kYfxov1XHE+CE
         7A/CFEzLqpKf1V89OwQVQ8uvj5lVgnxeWvewgptyUA5VYHUUrLFN0Ql9oCqRiFEav8SI
         4tSMgNUddMt8jMGntJHEZV1rI6efu+gNnDlCoJ9RghInTwhS6GhRZQe+9vFXjWzJzl8N
         jtgd7/IIUC82P54XKLiCbDg4aEHNrV4QewANaP5gJbGSMEuDZ1ncXhIn0f8pZ3lsOo16
         LQTl+auz9yxTGBBq5hqNknYVeCjTkmedBNCnzt5Yq0JynaMTND2m7mInlIJhDUMEfRD0
         C6rw==
X-Gm-Message-State: APjAAAXIJB7qDKC6YVt41Sh/6H6HvaIJactTlVA13zxM//RrCHGcP04p
        X3TgpVpzOSXpLaJt50YQnTKUISpLTMn3DWZ8c/xPz7KQ2jM8+JzXxYdIt5rS9TyaxOJbiRUKs3/
        d2tYJ3GiO0PQPGgZqAGWwBuyvwpGIVY6pph3f5oUcWQ==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr1732974plk.83.1569271763803;
        Mon, 23 Sep 2019 13:49:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwli3eb22E3YEdIGn5DbGXJLCk8NNBHFV4LNYMsOLq2A+mEoRbs+jBfvKS9LRTbrNZ3vP0cuA==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr1732961plk.83.1569271763608;
        Mon, 23 Sep 2019 13:49:23 -0700 (PDT)
Received: from [192.168.0.179] (c-71-63-131-226.hsd1.or.comcast.net. [71.63.131.226])
        by smtp.gmail.com with ESMTPSA id w69sm15338576pgd.91.2019.09.23.13.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:49:22 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: remove dead code in do-while
 conditional step
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190923194806.25347-1-connor.kuehl@canonical.com>
 <c2ce3fb0-6407-982a-a3f2-172cef17f2a6@lwfinger.net>
From:   Connor Kuehl <connor.kuehl@canonical.com>
Message-ID: <25c92ca9-0025-503e-3468-0df5de8ec2c9@canonical.com>
Date:   Mon, 23 Sep 2019 13:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c2ce3fb0-6407-982a-a3f2-172cef17f2a6@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 1:38 PM, Larry Finger wrote:
> On 9/23/19 2:48 PM, Connor Kuehl wrote:
>> The local variable 'bcmd_down' is always set to true almost immediately
>> before the do-while's condition is checked. As a result, !bcmd_down
>> evaluates to false which short circuits the logical AND operator meaning
>> that the second operand is never reached and is therefore dead code.
>>
>> Addresses-Coverity: ("Logically dead code")
>>
>> Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
>> ---
>>   drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c 
>> b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
>> index 47352f210c0b..a4b317937b23 100644
>> --- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
>> +++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
>> @@ -48,7 +48,6 @@ static u8 _is_fw_read_cmd_down(struct adapter 
>> *adapt, u8 msgbox_num)
>>   static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 
>> CmdLen, u8 *pCmdBuffer)
>>   {
>>       u8 bcmd_down = false;
>> -    s32 retry_cnts = 100;
>>       u8 h2c_box_num;
>>       u32 msgbox_addr;
>>       u32 msgbox_ex_addr;
>> @@ -103,7 +102,7 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, 
>> u8 ElementID, u32 CmdLen, u8 *p
>>           adapt->HalData->LastHMEBoxNum =
>>               (h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
>> -    } while ((!bcmd_down) && (retry_cnts--));
>> +    } while (!bcmd_down);
>>       ret = _SUCCESS;
> 
> This patch is correct; however, the do..while loop will always be 
> executed once, thus you could remove the loop and the loop variable 
> bcmd_down.

Ah, yes! That makes sense, good catch.

> 
> @greg: If you would prefer a two-step process, then this one is OK.

I'll do whichever is preferred. I'm happy to NACK this and send a v2 
with the dead code and loop removed or I can send a separate patch based 
on this one to remove the loop.

Thank you,

Connor

> 
> Larry
> 

