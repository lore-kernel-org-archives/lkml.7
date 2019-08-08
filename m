Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3524C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0332184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565275077;
	bh=otbC7ZHjlg0OuA+dibKxeYqdWppYhikbhtR5Iw6Pydw=;
	h=Subject:From:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=meBVldSurVvCbFVh6osnvUHy+1lUd9WQaGtPzxj4qxsPjBE0JpGCHKBtP8DzRBw/3
	 NG8Y8CoOK0OjhutWPLJAPIrcnHawjiD11/kU5wRderYQW/uqORZasKOp0tWl2rb4lZ
	 ZX1ZlSCQKPC1MEfsMXRcvAn3WTcVTKzilkR745Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbfHHOh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfHHOh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:37:56 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10EB2173E;
        Thu,  8 Aug 2019 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565275075;
        bh=otbC7ZHjlg0OuA+dibKxeYqdWppYhikbhtR5Iw6Pydw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=iJlaLQ/3qqvhCh/FTvrsprgcpxGbowGXnMel3p1mqee5soCS9adbMxPkP90E94sRD
         mW4coBP/RGc0xJiLelW+UE6bCgPP5WZWPlqvJf0fTgfdjwgNwqLkLX6lr0x3uhOBhz
         Tzag9l7EJkUBqFo8GJIqcmlQW8ZnO35PWmb6M3OA=
Subject: Re: [PATCH] mailmap: add entry for Jaegeuk Kim
From:   Chao Yu <chao@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaegeuk@kernel.org
References: <20190802012135.31419-1-yuchao0@huawei.com>
 <20190802072626.405246e3@lwn.net>
 <fe9cd2bc-76ed-5371-e0c3-b538e7a805e7@kernel.org>
Message-ID: <fd14e8d4-7468-ed3a-a679-6167eac72626@kernel.org>
Date:   Thu, 8 Aug 2019 22:37:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fe9cd2bc-76ed-5371-e0c3-b538e7a805e7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-2 22:23, Chao Yu wrote:
> On 2019-8-2 21:26, Jonathan Corbet wrote:
>> On Fri, 2 Aug 2019 09:21:35 +0800
>> Chao Yu <yuchao0@huawei.com> wrote:
>>
>>> Add entry to connect all Jaegeuk's email addresses.
>>>
>>> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  .mailmap | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/.mailmap b/.mailmap
>>> index 477debe3d960..70d41c86e644 100644
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -89,6 +89,9 @@ Henrik Kretzschmar <henne@nachtwindheim.de>
>>>  Henrik Rydberg <rydberg@bitmath.org>
>>>  Herbert Xu <herbert@gondor.apana.org.au>
>>>  Jacob Shin <Jacob.Shin@amd.com>
>>> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
>>> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
>>> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
>>
>> So as I understand it, the mailmap file is there mostly to ensure that a
>> person's changesets are properly collected in 'git shortlog' and such.  As
>> documented on the man page, it is used when a person's name is spelled
>> differently at different times.
>>
>> That doesn't appear to be the case here, and shortlog output is correct
>> already.  Given that, do we *really* need to maintain a collection of old
>> email addresses in the mailmap file?  What is the benefit of that?
> 
> IMO, when we use git-blame to find out who is response for specified code, w/o
> mailmap we may just found old obsolete email address in the related commit; even
> we can search full name for his/her new email address, how can we make sure they
> are the same person... so anyway, it can help to find last valid/canonical email
> address of someone.

Any thoughts?

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>> jon
>>
