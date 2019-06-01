Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC6C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9F527683
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559413870;
	bh=HSgGLFq3fEc8YBB9xEgB/l5k4SXsHO42a0ii8gC4JXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ho5c8T1vXeji1X+N4oGPDGN6lHvcGef+du7SKYnyDQZlnzs7IciazSrhpVgTHx/IL
	 5BuPfujbqgFRS/Z8FVf1Zzkg+e1z+iefKOn/9mII6vHDfLoxrEj7K4FOUowjIdG7Hj
	 lVg13QxX+dJnl/2p00MaoYUWfPOXiDlwGDt88SXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFASa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFASa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:30:57 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057F12474D;
        Sat,  1 Jun 2019 18:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559413857;
        bh=HSgGLFq3fEc8YBB9xEgB/l5k4SXsHO42a0ii8gC4JXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVjO5psE/XIedhvkcjXSxQM4FsBsNDQhdOW9vJ6pD4fRGMS9agUyfWWVrhFnlZltt
         tAN4VH0SCY4lw4G5v2ZFfqm2xUx3/Lx9d9Wx3WpGrZoS6ezaXYgbNJx52BKWBWIFN+
         80pXpGVYE7SATH4QyT2PkaYpxHWXZQHIBmoiZnx0=
Date:   Sat, 1 Jun 2019 14:30:56 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Subject: Re: [PATCH] drivers: hid: Add a module description line to the
 hid_hyperv driver
Message-ID: <20190601183056.GO12898@sasha-vm>
References: <20190530173720.17994-1-sashal@kernel.org>
 <nycvar.YFH.7.76.1906010018310.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1906010018310.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 12:19:11AM +0200, Jiri Kosina wrote:
>On Thu, 30 May 2019, Sasha Levin wrote:
>
>> From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
>>
>> This patch only adds a MODULE_DESCRIPTION statement to the driver.
>> This change is only cosmetic, so there should be no runtime impact.
>>
>> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/hid/hid-hyperv.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
>> index 704049e62d58a..d3311d714d359 100644
>> --- a/drivers/hid/hid-hyperv.c
>> +++ b/drivers/hid/hid-hyperv.c
>> @@ -614,5 +614,7 @@ static void __exit mousevsc_exit(void)
>>  }
>>
>>  MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
>> +
>
>Is there a reason why you didn't CC Joseph on this submission?

Hm, no, I just went with my usual get_maintainers.pl + whomever git
adds. Sorry Joe!

--
Thanks,
Sasha
