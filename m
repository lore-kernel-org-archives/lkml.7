Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9430C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F0E2171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562635803;
	bh=ad3uQLD2dB/YrTL4QBuQgs1ohLJES1Q7t/kkDshS8Ik=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bMZ+olX985jIuXIP5DFoiQfRkLMA3vwYuwKvuroxz08Kq+YlpVBZyfLpMnuhxx8Gu
	 fnYuwSpOZvHWOOQPm2mVNrEIdtSqK4ypxld4UuQnAfPq3sDwpFtQ/W2pWNhBmcfNNY
	 oAjEYvqF7Of0u3Bv2WSrcMBJjFN8Dg3/DA1CkSrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfGIBaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIBaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:30:01 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667E421537;
        Tue,  9 Jul 2019 01:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562635800;
        bh=ad3uQLD2dB/YrTL4QBuQgs1ohLJES1Q7t/kkDshS8Ik=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QY3av3dE07+y2dMsQhCjQ2wnckkX3zos3ofRPt1+pfrxDb/Ih2RV8BtHojXqg28fl
         WwSrYW/1HiElZ3Udnv7UlaMEMBBw6uZBSkoTWX8RXOlNFiu/kWM0k7m+gUP/tH+QFt
         Bp3lwzMjM5V8ry8quhfzaqWGKxMnwofCAmPyuqr8=
Subject: Re: [PATCH 4.14 00/56] 4.14.133-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190708150514.376317156@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <8ec266e2-ea45-2235-4c56-45ec2aac9a6e@kernel.org>
Date:   Mon, 8 Jul 2019 19:29:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/19 9:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.133 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.133-rc1.gz
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
