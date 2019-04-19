Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BCC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1B20449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698626;
	bh=zkeHzfaBVgH51+2rLKVPG4T40ylx+KZ3jS4dKb8Q6P0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Z+ysDXG58/gg6u8/6k6PO47zBUUeju8xrXafeja0IxVJKjVir0zWe8LQn8g+6pRpE
	 vgq1XpSwwCYRMmrbJvnb9p4qxkLEJA7+iOPYXbkuhnLx9lXq+wbgnU60L9IJBLyDp8
	 uVRNe7FipuVzsB09F+qnoBgp5u7cR92XJuoV7P7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfDSS3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfDSS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF86222B3;
        Fri, 19 Apr 2019 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555681205;
        bh=zkeHzfaBVgH51+2rLKVPG4T40ylx+KZ3jS4dKb8Q6P0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SI6UrF0xU4xpg+ipoDDolupWiLsE7BPYs55ze5wnMQTsPZ0ZIW7mVI0++JhKWyQRq
         53cQyZfdC4W8MOWEyRMrbBbWm0WfPato+VBqjHrdzeKib3k4SUjpLkC4JK8MVZfZ0a
         PLFWnZbIWILPuEBaOfejNUs0sRs7V0FBSmR2Vuok=
Subject: Re: [PATCHv2] selftests/efivarfs: clean up test files from
 test_create*()
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190419131221.28297-1-po-hsu.lin@canonical.com>
 <03bdc88d-07cd-08ca-7d2f-ba93069eb41b@kernel.org>
 <CAMy_GT83h6DtYYm6GMz=wXfpLpyqt3GqdEmw7Aj40kKq1NkQoA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <388c89a4-5f45-7eaa-9240-83336c9de663@kernel.org>
Date:   Fri, 19 Apr 2019 07:40:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMy_GT83h6DtYYm6GMz=wXfpLpyqt3GqdEmw7Aj40kKq1NkQoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 7:30 AM, Po-Hsu Lin wrote:
> Hello,
> 
> Commit f8a0590f fix some part of this issue.
> I will send out V3 base on this commit in linux-kselftest next branch.
> 
> Thank you.
> 
> 

Yes. That sounds right based on my quick look at both patches.
Please send v3. I will get that into next.

thanks,
-- Shuah
