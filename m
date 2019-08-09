Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20BC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F2E20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565388487;
	bh=GGhyMt2kTj77MEpiCm9ZzJPNEg8urfCXZuAvbCWXpbg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1sTKxCYJ2aLIiMxboeucxd2v6/jgWb7Xu9qBB2962KQKmdd3KC6agkHsi2XcIoFv+
	 pRXcltrSWZB1TqUDCbzy1gIP5GQ2Y109lmix2DVcoi+m10DH23jaoODc2VsDjVHrEx
	 /IFOfuk+OJM+IhN1Ji9sP2OWNnufB7mALVxqmWWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfHIWIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfHIWIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:08:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A9A208C3;
        Fri,  9 Aug 2019 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565388485;
        bh=GGhyMt2kTj77MEpiCm9ZzJPNEg8urfCXZuAvbCWXpbg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tQrkxqAwWTRIviD5XpNVV5l6pBSFMcsW0Bvj+HN49XPzqnvWVJIKWwils5LRAZ3VJ
         SyORfRwx4eH5rlsHrYAyoiqedPJxbQYBGChOljgMRllEbBPWz8c6M3RpCXxVWQ7YEp
         Q5L9CJrdbgmhK8osHjeeUE2ytMjrafolrTITIuUA=
Subject: Re: [PATCH 4.4 00/21] 4.4.189-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190809134241.565496442@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <128a1f32-bff5-cf19-cf7a-1aeafcc354a5@kernel.org>
Date:   Fri, 9 Aug 2019 16:08:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809134241.565496442@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/19 7:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.189 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 11 Aug 2019 01:42:28 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
