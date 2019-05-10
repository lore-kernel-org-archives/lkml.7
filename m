Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648F8C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299E2217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557523621;
	bh=YYeMMuuB/h3UDJiNHy4mVmh1VKTfYSb2Oum3z+dSZpo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OCRu4CLk9WCV/d2dblI4tYoOpWQe+6ZxeIcl7mZRvIATk/ft0UuNIQrNB8Y/EU2Dv
	 yXXQKzWuNnget8aYsxsE+J8Xvt2knqytlvmLdeyCAxur0pInVhVciBiDbCTU7b4sxi
	 AYIeGaFBlI4mIcv2ohSLZ8H5Vb/O8txwWrX8NEzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfEJV1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbfEJV1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:27:00 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A618217F5;
        Fri, 10 May 2019 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557523619;
        bh=YYeMMuuB/h3UDJiNHy4mVmh1VKTfYSb2Oum3z+dSZpo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SfvTDwOpCxoWtW+fsfMDxanU229BsFuIfAmp1OeqYflnbaDUwcvMK1C5qkIbt0MBZ
         h6JqmpCs/ftCeS8WGqe8pozrLeDxhd6HotUGD4poUpqSvZi2SXOU8aQ6mT+6Yb9rSn
         DoUV8Q3RL3rJSIc2PFum0Y7P2wQQyvEGdLloVsU8=
Subject: Re: [PATCH 4.14 00/42] 4.14.118-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190509181252.616018683@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <513b9a60-e329-4d2f-2411-89761800f0e8@kernel.org>
Date:   Fri, 10 May 2019 15:26:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/19 12:41 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.118 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 11 May 2019 06:11:15 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

