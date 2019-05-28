Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E6C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CF220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BzRo3jzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfE1T5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:57:21 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:37297 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbfE1T5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559073438; bh=e/v51RnL9xf5ubCXEIKeys53WKHwDxTPFQTT7gRApYg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BzRo3jztIFiFuKAwl9fRhPg3jAycn0bTKv5FWHWOtb9hV75QiKqwVOMeq1kFMNR5vDMoADKpN+TtVXNEIi+YA1iB1bZ8775nAkWShw4kBXMGR5Vb3qVCJeYFl4d2dEnAgNq7ZTaLt2wB7XFz/9kaGR/ZH7FtyE8MkYxK2zhR2XsbIQVaa/dXxM6cauaNWg5tgnEpz/v4bSTs35pQHLBsJm7E4lyM0yuEkBfOpdZau7q3h2UP+G60haqlK/NPD9wul0OyRdlcvm2XaUbxnmtTQl6ZJfAPgtnC8CfI4Gcl//ngS9W2TRovgrj2n1jPrc8hTCYkI5fJq/WJpStRaolBtg==
X-YMail-OSG: S1fP1h4VM1mSGEkDlbxKAEe_FGEMKAtMqkbUYF8.HjO5mxKYbmZphG.xKGOOeLf
 1Sz596GcvYe1.VqJ0sI6f5Bg.F5UUj87y5cqpCOYhvEfUM8vge75KsHHP4yK2TP3S_7j8KAFkjo.
 YUukUnMMeOrA39onJCjLTAbyojW3ZNHmWC0fZb2yibSwbIMfMlmrULY1eINTXCLQkRDAYOlneBrH
 lQugVzZFpEzdnClLyeZUYwBks1oM_xRwQQfcG82GrYRTEjfgeb.SxtgKWskbLjQ0ZsluCZTyt_yU
 ef1RWw0aObdJdJ385sj_rRuY2ydtZB6oLug5wvBNnS.tUHgqO3K1G3Hr2seu_GoI0epOK4.0OEG3
 xwnM2.y3wTfRb6YFXryEKfllq8SXxvDJXZ2O5kdYNrfIqj_bIkioVfe1OPpOeDuxvMF5xIstwnnf
 lJgAR6JIRreOJZ6rjB2KswEXCxXD7uaG5qZ5.mud3xcw8NyLWJXJLZW6mQ9CWpdIoR3yEV21VMck
 dSXsI4mnY8w2wfj1ngQhICjI0lqFFgLgTXqpYRD13NzX0iEqCh9XaBlhS59mv3lS7ozhukUoNyMx
 2UJRCyzPyRHSPFbrs6guwf6lvQTQCzUK6mOttAz639TAZDrrR.wEF41krcm5VpgZptwfWQVgJeeR
 AvF6xVAxfQEt4oMGLKAVdvBOW.h7JQZp4wA9uluOB7eTjhgdmDR8Y9cXmc9O1lSX4EVJv31WwP9e
 tJ7_iWnwy4DvEZV9BLmuA1AqrtX1C6TE.Ub.aphzxoPzDWr72nQz38WHB1mhrMuBfrRvbnGMS0If
 J9JQ9zDKDTtTws9s1kZeZjA.hZamjV8MtIDIqFLVHzlwS4P4BZoODn6sKi8_sgfMnewm7qcldzYv
 6y.DpfDzt6av8JDZs01IP2VZ_VkQfTMOFjL6fmzj1XhrG6EN.O2j.x9Mkhjre0UlMT.fPCJPZF6i
 _A6S6IDCPOmnhle35hB97hn9zajtFWUpgF48rPbEd70RcLOL18yVE8iMeN6eqMAb9GVtD4z7y8K3
 REnIwqWsl3IBgh20oCXZCjkslWO.F1Zmk.X32UxvmlBHqdUeDA1eGEWYkoPpm3M9iiZxFNhJcYRD
 kEsZzMXDep1wgOnTFW2c4G8l0fQYIxm9ccWCk5GR5QJgb_hw0d3EWtuIQW1adqkSSSH4oTWYbetk
 htvITi_YRH5QvOZmrLIFOhm7zPbeh6qVQpc7K2KIOY6x27xUEASKU8br7pe8VzJbTbvUOZB56P5J
 V3BXenh56F_UGW_SP05vyieUiRGKRn5d1lSCnOmyrQ32lQTmbipFAEyF4JwSSo_JeXXSgciDazWw
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 19:57:18 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 561ee678e4732a1eca71b27bfdaf5a23;
          Tue, 28 May 2019 19:57:17 +0000 (UTC)
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option
To:     David Howells <dhowells@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jose.bollo@iot.bzh,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <43e3de52-13d7-8089-11cf-a384662401aa@schaufler-ca.com>
 <9191ef31-a022-cdc4-9bed-ff225e4179bb@schaufler-ca.com>
 <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
 <11440.1559046181@warthog.procyon.org.uk>
 <9330.1559060541@warthog.procyon.org.uk>
 <9986.1559069658@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <26777166-5e0d-adfd-e59f-bcee7f18841a@schaufler-ca.com>
Date:   Tue, 28 May 2019 12:57:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9986.1559069658@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2019 11:54 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>>>> Also, should all of these be prefixed with "smack"?  So:
>>>>>
>>>>>   	fsparam_string("smackfsdef",	Opt_fsdefault),
>>>>>   	fsparam_string("smackfsfloor",	Opt_fsfloor),
>>>>>   	fsparam_string("smackfshat",	Opt_fshat),	
>>>> No. smack_fs_parameters takes care of that.
>>> It does?  *Blink*.
>> Well, something does. I can't say that I 100% understand all
>> of how the new mount code handles the mount options. Y'all made
>> sweeping changes, and the code works the way it used to except
>> for the awkward change from smackfsdef to smackfsdefault. It
>> took no small amount of head scratching and experimentation to
>> convince myself that the fix I proposed was correct.
> Ah...  I suspect the issue is that smack_sb_eat_lsm_opts() strips the prefix
> for an unconverted filesystem, but smack_fs_context_parse_param() doesn't
> (which it shouldn't).
>
> Can you try grabbing my mount-api-viro branch from:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
>
> and testing setting smack options on a tmpfs filesystem?

My fedora system won't boot because smackfsdef isn't recognized. :(
I will put in my fix and retry.

>
> You might need to try modifying samples/vfs/test-fsmount.c to make it mount a
> trmpfs filesystem through the new mount UAPI.
>
> David
