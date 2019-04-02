Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40EEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AE920830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554249261;
	bh=jjwQz3LJBMJPvajdCt9RjxoDFGIGbsVo6fGZUNG0W9Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=iQKIFFYnDSqTlLprs1+puuzTHixuk4Dq+MMBVuFnr2w81QM4eZ0g6bXPAVAlKG4ou
	 9Lfl8siBbiC7XLd4t51F6c1TAIdizYh2Vni7XVg26hz0T16RbUwmA5fGXIKosBK4Zu
	 sqON5EjFJMKUiE/igOo0UUuNJY0PYSuoOOFlCwqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDBXyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfDBXyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:54:12 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6909E2075E;
        Tue,  2 Apr 2019 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554249251;
        bh=jjwQz3LJBMJPvajdCt9RjxoDFGIGbsVo6fGZUNG0W9Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1R3BdgbWGof1gd8UnI7n/uPaNIscgVyuQGKUYU6xBXVY9ssFa0FxLPDxf/Wc+SdOC
         MRJT2uTZIkJy5pNLf+RWFVjdaCQEm3BWmNIINArCIFWTcf8plsevejJByGXWVIjWYm
         dRvQyed3oPpBe4b+Gvqnb6r2/YtZweK4FW7BzytM=
Subject: Re: [PATCH 4.9 00/56] 4.9.167-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190401170103.398401360@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <42a98045-0159-8d8b-72ee-208f6dc015da@kernel.org>
Date:   Tue, 2 Apr 2019 17:54:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 11:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.167 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 17:00:20 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.167-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

