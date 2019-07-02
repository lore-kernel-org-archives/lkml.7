Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B98EC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC342064A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562116693;
	bh=bmwTr6w+tSBHtyExLxtodZWSrKNRJOhqqXsgDdGnMng=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=T+CBhW8ceExlHwStraSgfYqWoY1KC3dymmFnhYeUeLJBn7DejFOlC1WDtxVBnNb5L
	 KIcWFKuRl7LqK60f1mJPJ4YaBMybqDrm2D12j4ZaSbd6q+apw55vRoqT19+7+tTxyu
	 TuLOmk0Ck3rmim3CoixWqYrvjdURy3MY6T39x9+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfGCBSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfGCBSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:18:05 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81880218FF;
        Tue,  2 Jul 2019 22:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562107949;
        bh=bmwTr6w+tSBHtyExLxtodZWSrKNRJOhqqXsgDdGnMng=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2AOFJ96slX38t7odRn1NULtpPfpf8VYIxPDx6UQtLlSaOfi5FTMw2RzvAxjsao7XY
         QfTlEUNjSPUYmWLcCWgJASnvRnLpnJZVpP0HNcqvL6Kv71lOtQe43dVlXK2FPuzwgZ
         IzhEQWhMA06WPQUbyp3qMoDzO+/YTw1hN82Ij+aU=
Subject: Re: [PATCH 4.19 00/72] 4.19.57-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190702080124.564652899@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f5a31f03-25e7-867d-96a9-18a0d2266b8d@kernel.org>
Date:   Tue, 2 Jul 2019 16:52:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 2:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.57 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 04 Jul 2019 07:59:45 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
