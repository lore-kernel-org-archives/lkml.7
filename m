Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3012C2D0CA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A40722B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576145077;
	bh=FHCC7Pw/J14J67n8yfbUDVoqNHfXMUekWASN4qH2CQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jHtlWDUepKQuDU50rJjxA748zDX7aVB9dnmTYIlwF4xBs5nTcaEez+mOKcVWcQFEp
	 A7PHwsfnI5Vuk1+wdR2CJx7Ccfb+mm1ZEZRRblc/AsGl4xdKyqPuDrbags+KS5Iixl
	 cfHpDbLhfIzAOAX3GJL7lmQZqHV6BN/vRQoyz79k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfLLKEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfLLKEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:04:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7235D20663;
        Thu, 12 Dec 2019 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576145075;
        bh=FHCC7Pw/J14J67n8yfbUDVoqNHfXMUekWASN4qH2CQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChS4th9ypslzRiwb7gfiEbEDt8yIpl6JEve4MfDzgPnjpslBTqbQi0SYWcDDNkac+
         HvRuErbF8s+e1E/0Jq6i9P7IXPZ6TJ1z3xyL8nNqFKk0UpYVjjYU1i1JtrX+kxqfRD
         a9yqia8qVmHPJ0jY+VoNK4AsVHUyICRwOq2SyRv8=
Date:   Thu, 12 Dec 2019 11:04:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 00/92] 5.4.3-stable review
Message-ID: <20191212100433.GA1470066@kroah.com>
References: <20191211150221.977775294@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 04:04:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.3 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.

I have pushed out -rc2 with a number of additional fixes:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.3-rc2.gz
