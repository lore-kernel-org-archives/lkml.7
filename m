Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F079C18E7C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FC1217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558474515;
	bh=myWzO+qZtEpvhPkdewNtwyLnhZl7ECjFXlAQIm2xU6w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=F9hNVSMxZvwfHYJq4mLuOVQWSuZ2S3yxEuTPRdbvFUMJUby2Qkbfp+lCiZ9t0LZkd
	 pp6jsnsGcEwWuixiVMK3l4x0zNk2jTpXvxupNRMjRhvNt0mbSiCw3HZ3KTASz3r2gg
	 QNxW2XSMObBHWiaF9+Z0bhXh8tQIrv8kAymJgiF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfEUVfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfEUVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:35:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1255B2173E;
        Tue, 21 May 2019 21:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558474513;
        bh=myWzO+qZtEpvhPkdewNtwyLnhZl7ECjFXlAQIm2xU6w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1CyKiiG2vw5rxo0HK00udUlZOppUkLRvrq6r8mZGHkqRDrmmpVTI4L9LZ9OOK02Cy
         nom9LtzQU55aLmFqjMLNBziXbGuLOz590/XouKHcVCNDXxnSPr7XXa4gaRBh7W1D9X
         MvqmGADuIOt1KF6Mm1QwsFS3NCzR9wUHZ1jaknBY=
Subject: Re: [PATCH 4.14 00/63] 4.14.121-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190520115231.137981521@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <fe5975c9-9736-116a-1bbd-d0f2c8faef37@kernel.org>
Date:   Tue, 21 May 2019 15:35:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 6:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.121 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 22 May 2019 11:50:54 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

