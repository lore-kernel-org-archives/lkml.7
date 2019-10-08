Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05EECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CF621479
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570499398;
	bh=cFjDcRdNYug32NXchWp9aEpXNbMiQH0Y5DH9uQ/EtSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PqXx5WJwjC+GyAV9GI6f2Z9ry+s/RjZzsD8R/QOC8TD2/KF12goz7n/7q3O1pbbAy
	 vqHlca1PdRPEwcQwB9/VyCen/7zRRvJ1+CHDYpApJPPjH6kGYnTiITenAGG3a/1XcX
	 aZvQS1c1L7tneZSE4Cq21Ll3JfVcRmIzpkbh2CpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfJHBt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfJHBt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:49:57 -0400
Received: from localhost (unknown [216.9.110.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9EF20835;
        Tue,  8 Oct 2019 01:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570499396;
        bh=cFjDcRdNYug32NXchWp9aEpXNbMiQH0Y5DH9uQ/EtSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=07+iTFYw5GUk75foY3KUq7udBBXdj/iWmY4zMeY2JlqzDTTHOMAWg/nhyKkR/SPTT
         zPmlzDe6qiBcPHfeYWK9j1ZZZB4apgERFmvGGxhvmTAuur1r5zofzc8wWgUEAj90Je
         KYXG9zCAsf9mVUyAEdF2IGVog6VIFgjo5rIQLLy0=
Date:   Mon, 7 Oct 2019 21:49:54 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/36] 4.4.196-stable review
Message-ID: <20191008014954.GB1396@sasha-vm>
References: <20191006171038.266461022@linuxfoundation.org>
 <d3e1e6ae-8ca4-a43b-d30d-9a9a9a7e5752@roeck-us.net>
 <20191007144951.GB966828@kroah.com>
 <20191007230708.GA1396@sasha-vm>
 <35f5fb99-6c35-9afd-1a4e-3fa7d4ba213a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35f5fb99-6c35-9afd-1a4e-3fa7d4ba213a@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:16:51PM -0700, Guenter Roeck wrote:
>On 10/7/19 4:07 PM, Sasha Levin wrote:
>>On Mon, Oct 07, 2019 at 04:49:51PM +0200, Greg Kroah-Hartman wrote:
>>>On Mon, Oct 07, 2019 at 05:53:55AM -0700, Guenter Roeck wrote:
>>>>On 10/6/19 10:18 AM, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 4.4.196 release.
>>>>> There are 36 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Tue 08 Oct 2019 05:07:10 PM UTC.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>
>>>>powerpc:defconfig fails to build.
>>>>
>>>>arch/powerpc/kernel/eeh_driver.c: In function ‘eeh_handle_normal_event’:
>>>>arch/powerpc/kernel/eeh_driver.c:678:2: error: implicit declaration of function ‘eeh_for_each_pe’; did you mean ‘bus_for_each_dev’?
>>>>
>>>>It has a point:
>>>>
>>>>... HEAD is now at 13cac61d31df Linux 4.4.196-rc1
>>>>$ git grep eeh_for_each_pe
>>>>arch/powerpc/kernel/eeh_driver.c:       eeh_for_each_pe(pe, tmp_pe)
>>>>arch/powerpc/kernel/eeh_driver.c:                               eeh_for_each_pe(pe, tmp_pe)
>>>>
>>>>Caused by commit 3fb431be8de3a ("powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag").
>>>>Full report will follow later.
>>>
>>>Thanks for letting me know, I've dropped this from the queue now and
>>>pushed out a -rc2 with that removed.
>>>
>>>Sasha, I thought your builder would have caught stuff like this?
>>
>>Interesting, the 4.4 build fails for me with vanilla 4.4 LTS kernel
>>(which is why this was missed):
>>
>>  AS      arch/powerpc/kernel/systbl.o
>>arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
>>arch/powerpc/kernel/exceptions-64s.S:1599: Warning: invalid register expression
>>arch/powerpc/kernel/exceptions-64s.S:1640: Warning: invalid register expression
>>arch/powerpc/kernel/exceptions-64s.S:839: Error: attempt to move .org backwards
>>arch/powerpc/kernel/exceptions-64s.S:840: Error: attempt to move .org backwards
>>arch/powerpc/kernel/exceptions-64s.S:864: Error: attempt to move .org backwards
>>arch/powerpc/kernel/exceptions-64s.S:865: Error: attempt to move .org backwards
>>scripts/Makefile.build:375: recipe for target 'arch/powerpc/kernel/head_64.o' failed
>>
>
>Is this allmodconfig ? That is correct - it won't build in 4.4.y, and it would not be
>easy to fix.

Oh, interesting, so no allmodconfig? I've disabled everything but
allmodconfig on a few architectures in an attempt to save to build time.

--
Thanks,
Sasha
