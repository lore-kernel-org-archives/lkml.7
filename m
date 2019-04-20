Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F486C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3030B21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555743944;
	bh=yAR1Tnl1hvpA5uyVX8YQoSetPN3rIIfQwwAGjhO9sHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ovLyjkXYqbNpa8g+3+Ui1byPy+nOSdT6j98Q4qUnUKpV/gmABIgL8vYjJXKgZGmCN
	 PrZTrA1i7hgGdzDMOX18/ViegOEtg3W/J10Vare10d1RoZCZnlEZv7H6XdR7Iq8x5v
	 pczFA0ospNArQw4zfwPs9YNCw7yJZWGbhblG9KNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfDTHFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTHFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:05:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E3721479;
        Sat, 20 Apr 2019 07:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555743942;
        bh=yAR1Tnl1hvpA5uyVX8YQoSetPN3rIIfQwwAGjhO9sHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VliHBvoYOLGZS6xrcFHU0Ut4mtcR0hS815ZzjbP9g8RW0K9Je2oBayLFNBUrCyzMG
         huQNm32J5hgvpAxS99JY57+AIO5CWA6Q7TQ1I0U/BnvbYZEZUCY9/sqgnj8L1oYHDX
         Alye6szhcJue8BqZKiD3DZaaCHj3+xKkJdOw9uYE=
Date:   Sat, 20 Apr 2019 09:05:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
Message-ID: <20190420070540.GC24855@kroah.com>
References: <20190418160436.781762249@linuxfoundation.org>
 <b9d55173-72d0-ad9f-5b28-7fa6c81b961f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d55173-72d0-ad9f-5b28-7fa6c81b961f@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 08:24:03AM -0600, shuah wrote:
> On 4/18/19 11:56 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.9 release.
> > There are 93 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.9-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
