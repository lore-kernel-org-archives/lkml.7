Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D72C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18731214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568554511;
	bh=mkPIE0K1ZafZba4Rua9o7jNg6oncJgPXS7FWkcmosWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jEXCj+vr1Ifw7u/iX5dxztwHHOUFChLt5yoa59jI+lXRdHi4tJbUVWFtcrU9xYqtm
	 Re1kdZXl4HI8uokeHZkBK2uG4zhqV4UeE9hYNQ004yCyDM1d7WXkah/HFboqq8Atdg
	 HJvJDYq525iNGuOhIeaskNwEfGyOmFGM65nPjCyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfIONfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfIONfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:35:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD0E214AF;
        Sun, 15 Sep 2019 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554508;
        bh=mkPIE0K1ZafZba4Rua9o7jNg6oncJgPXS7FWkcmosWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhBWb2hrbi8a7t4B1Zzep3K0M6tDK00XTfM3x5xgHm2rzydB87Uj5LwG3v+Iv/ui+
         XJwgl+2ZY+sis6f3ZrrH7sSWrQHgRQ4HCjcI+kabEDRienJJ5kX1CbVUK3bquLz21/
         4j8YS0iAfM7ChJUG8Km0qc1RuI8SMopylSGxw90Y=
Date:   Sun, 15 Sep 2019 15:35:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/190] 4.19.73-stable review
Message-ID: <20190915133504.GB552182@kroah.com>
References: <20190913130559.669563815@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 02:04:15PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.73 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 15 Sep 2019 01:03:32 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.73-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.

I have released -rc2 to resolve a build issue:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.73-rc2.gz
