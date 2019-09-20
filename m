Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C329EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95A208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569014342;
	bh=Yi+tscBIRNLrX3tNU/F82kXr5stwJs7YH+MFYW0lFpM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qyN/KVlFUtuRpdm9iptKL5TzfDljQzYzb3tvonRPitArVis1Ij12QMhpeRhLPBXCI
	 +maXAI0/uizmHVJc1IRaRdwyPNREyxDA8JgDYxySWLi7hRmm7rFnUq5JCR6UvNrx3l
	 8p5JIWWMbrqbKLGCrvaCj2RwJ6HQI/FnRWkF5d4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfITVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfITVTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:19:01 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86EB520820;
        Fri, 20 Sep 2019 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569014341;
        bh=Yi+tscBIRNLrX3tNU/F82kXr5stwJs7YH+MFYW0lFpM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CFhEB4JkuRLRqQiyxM1ZiLRh+u+CECaYisImQ0SlUabuiHoic6fCt/DriH93hajb2
         QpE3CAEegF1L9sGrKNOHtD4YWGQzHW+K52h8UnJeu4PUGgjXAFVzBkPAiljHSGMUmH
         RJE7fNu+P10aysOUGIH1f5JDt6RCz8e54KTOk5tc=
Subject: Re: [PATCH 5.2 000/124] 5.2.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190919214819.198419517@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <770c7719-20af-f7f8-f692-5f3aa12309ec@kernel.org>
Date:   Fri, 20 Sep 2019 15:18:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 4:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
