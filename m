Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A80C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3631217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562969193;
	bh=eBk7dQSQWa06zkKl4XKERXEsTm34meKha8Khlxo8T/Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hLhpGoKS+Dus1tMs2Y+k8xf8Bw9ChNOPgTgsBkKF1EVgW0FaJjTi6ROfK8nGG6eZN
	 jtIWyS7HpoiopOtfMwVtgX1vLIFOXvw/L41oWzGcoSsNizbbhqXxST1f7qUYp6txU4
	 nSP/wYSO3n70ubdgSOT86HL/MtDBMjRrSg7tcfb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfGLWGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbfGLWGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:06:32 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB63820989;
        Fri, 12 Jul 2019 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562969191;
        bh=eBk7dQSQWa06zkKl4XKERXEsTm34meKha8Khlxo8T/Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=es7jKlBXy44XM1QgZaQXY3crBT9+c27brLF8SNUyKTB5JkWtQ//CrRLqtgP4EGfAV
         IV6EgY3I6CvOpDj8LXsQiNteHL7BzKURRA9+gzO9yams4zXxtjIuY61apEehUtNbmy
         SFvpsJRx/T/pKaK8W8eFG8TCVQwKGVBxrazdWU78=
Subject: Re: [PATCH 4.19 00/91] 4.19.59-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190712121621.422224300@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7b816e39-ccaf-ea79-cc84-bee9ecd9cb04@kernel.org>
Date:   Fri, 12 Jul 2019 16:06:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 6:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.59 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.59-rc1.gz
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

