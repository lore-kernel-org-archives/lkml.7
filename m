Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD8D214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565053014;
	bh=fi8n2CS1oBaWblZvKO/2+cHFuTlmqtkR0Ts9Ll4jeqg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rMB2JnM1EA3dcobCHdgUaQ5rLDptU7OQai0VkNS5/4aBml/RxdrU2YlCZHnPhjLgD
	 6NtyeMZpfYx+KfLWvqj5GAy5SwkI7mg3h4TwGOwUmDxBzVu6ErSO4mI8uAyZaNuAw9
	 mJBvwK9eczVMttxBq6zz8aMQM8cGeFZMfhfLyTrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfHFA4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbfHFA4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:56:52 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C83B206A2;
        Tue,  6 Aug 2019 00:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565053011;
        bh=fi8n2CS1oBaWblZvKO/2+cHFuTlmqtkR0Ts9Ll4jeqg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hYU+n7xIS2/i48J/mCpBse0Qv6E1VowjcZsESrmHgEOcyYfZKxZMwj6XEgtW8vg6v
         GNcQbfO5Ti3DI/uZFafCjsJZ6OL8FZ1onGb8sElF4gEZZIwYRF9WnNn64uT4dOWuE+
         7HqohoP5y4hXVXUJRkfBhLS1bFs8zW5dgx7SMgmY=
Subject: Re: [PATCH 4.19 00/74] 4.19.65-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190805124935.819068648@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <743d861b-be73-bf87-65e2-b57c229e72e2@kernel.org>
Date:   Mon, 5 Aug 2019 18:56:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 7:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.65 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 07 Aug 2019 12:47:58 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.65-rc1.gz
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

