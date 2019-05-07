Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A56C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFDC20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557260388;
	bh=eQR4Xs9xal9H7agdPQRLanbC29GivysvMasSAqVShxI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VrXE4V7onbEkAactdZ7N2em0CnWTqKNeRjePs8i0zSIIc3zEkyCzWC3tpCtD9YE2X
	 PpDDlarg/hFVrRE40fc0oz0YE9+MyWEhlAT6M6oLwtdV/+Ieo3cz+IYqaJklI6pOZm
	 /rz40HXobDPYdjb1Vs4X6RvH2sl47eRfuw0981CE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfEGUTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfEGUTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:19:47 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4105B206A3;
        Tue,  7 May 2019 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557260386;
        bh=eQR4Xs9xal9H7agdPQRLanbC29GivysvMasSAqVShxI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FI+BWfFfFdDsv+vA5VlnsjIuexG3l7Dg+4m+eDi0sEiXCCSoOa6wzA6hG4YynuGeJ
         OuV4pPrz5Ua/6SX6iDBMozcV0X6TpgvpM0nM2txSxQ6keutLGRkWExuH8ZRfGFYpjF
         LMxeMCPtAnTHgkY1dzmGDD4e+3ir5fXpm0mYNS2Y=
Subject: Re: [PATCH 5.0 000/122] 5.0.14-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190506143054.670334917@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5f6a5628-9613-99f2-a4f4-619f6f7d6018@kernel.org>
Date:   Tue, 7 May 2019 14:19:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 8:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.14 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 08 May 2019 02:29:09 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.14-rc1.gz
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

