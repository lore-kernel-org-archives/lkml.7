Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD2DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B97D2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554248059;
	bh=uJ7T6X2YfPexSgvmfKuUc4USeuhv9YIGZATmZaSQHe4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=y7oyjIN17y1BhEmG9Kv2kaeI2Gv5Sr1/w1XYgu72wRbfMXPKYzgvw4ecPB54R7My6
	 Eui4zT8AORXSgaytq7NkHSSp/Snpcb8uEhHutqqPAvsXgQcjUAOzTJMzsSImgQkx1f
	 NyVPmXpDbXiKFCoSXg09Hl2B5x0ZCLWdPZ+qA15g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDBXeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfDBXeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:34:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1BB7206B7;
        Tue,  2 Apr 2019 23:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554248057;
        bh=uJ7T6X2YfPexSgvmfKuUc4USeuhv9YIGZATmZaSQHe4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rk59K1xnCRsSSX+jGW3hEOKCupf2/yKIC4UhGMZfEbAXgyu2s6Vz9alO6F5t56q/z
         zRkEzXVhLIL/GMmBnus+5ywOPzSF5WFLEj5NfiI0lCf7uLt4iLGrZvP2D2Ih8A1STK
         i3+/gasxLztkm9Ya9pGmcvpjNMbQiAVUm4L1k79U=
Subject: Re: [PATCH 5.0 000/146] 5.0.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190401170048.449559024@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e28284ac-f72a-113f-dbf9-0eb48aabb26a@kernel.org>
Date:   Tue, 2 Apr 2019 17:34:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 11:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.6 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

