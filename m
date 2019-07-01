Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE51C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C28A21721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562003982;
	bh=DsHI/m07YpEcZgC7xPGFegDzLNU9Ym90S4GPPlMOnb8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qGgkGxBkUca1ppIta60ySnqhnpynDbd5pRrNNCicTIRO6C0IHUuAS4LpAUxM3eCyv
	 1gewPwBrxTa1uw6ld2tkMUPBQ9KF6Saw01u9jOJ9vbtd8X2UUqsEjRcEZA7X+IW6Mt
	 Z+rRbbJzFeIjBa2QAut1nZibq3fQN+4S4uQesi6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfGAR7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfGAR7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:59:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B4D2146F;
        Mon,  1 Jul 2019 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562003979;
        bh=DsHI/m07YpEcZgC7xPGFegDzLNU9Ym90S4GPPlMOnb8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qb3iEy8kisEnhRNPGd0KZQkzLJvogMXuN1kDhXtpXfoW6JkY4P3pm4imBDKJHe6CP
         AyeMyrm/Ynf+BjHqVAbS25avVg4oM3ijomOX8WXQq5FCLymN3pIwXHQFSSci/tM8mZ
         cWNa7dcMFKiO50xKFd4154ZQ7YwsS0T8iD6Vu3oU=
Subject: Re: [PATCH][next] selftests/x86: fix spelling mistake "FAILT" ->
 "FAIL"
To:     wharms@bfs.de, Colin King <colin.king@canonical.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190701130431.13391-1-colin.king@canonical.com>
 <5D1A06CE.6000405@bfs.de>
From:   shuah <shuah@kernel.org>
Message-ID: <63f05151-bc25-b19b-61de-7f907fd1c282@kernel.org>
Date:   Mon, 1 Jul 2019 11:59:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5D1A06CE.6000405@bfs.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/19 7:12 AM, walter harms wrote:
> 
> 
> Am 01.07.2019 15:04, schrieb Colin King:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is an spelling mistake in an a test error message. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   tools/testing/selftests/x86/test_vsyscall.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
>> index 4602326b8f5b..a4f4d4cf22c3 100644
>> --- a/tools/testing/selftests/x86/test_vsyscall.c
>> +++ b/tools/testing/selftests/x86/test_vsyscall.c
>> @@ -451,7 +451,7 @@ static int test_vsys_x(void)
>>   		printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
>>   		       segv_err);
>>   	} else {
>> -		printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
>> +		printf("[FAIL]\tExecution failed with the wrong error: #PF(0x%lx)\n",
>>   		       segv_err);
>>   		return 1;
>>   	}
> 
> 
> "wrong error" sounds like scratching table, perhaps "error" is here sufficient ?
> Bomus points when user is expected to report this.
> 

Just "error" would not accurate her. I think the intent is to say
that syscall returned an invalid error code. "Invalid error code"
would be accurate.


It would be helpful to report the expected error code.

thanks,
-- Shuah
