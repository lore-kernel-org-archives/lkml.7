Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97636C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644FD214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568554488;
	bh=f2DsawLySIZJ54OEBtq1a789tdzXp5AdnKcoWckJccM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uEJL7du5L5Ewp7Bf8PMNF0nR91D6aZPhwPBxLD4lvKyVi3JVNu/C9tBJPad3aZjdW
	 1pUGPuUWxKr1Njyv4RSXE3SJrr/E9J5PQReNvuXxujgiYnxWGgo+2LknX/iJus2FLj
	 w4YEKxci3l9T8xu/6LN5BZmTxRB/CbAevRd31QKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfIONer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfIONer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:34:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D97214AF;
        Sun, 15 Sep 2019 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554486;
        bh=f2DsawLySIZJ54OEBtq1a789tdzXp5AdnKcoWckJccM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkwjdQfSbjc8ZhQm2SxJRZ0Jv44KVlsdLPg/LIvwDzXD3mmVvVPNxynV2/yO9e/CJ
         iOsZGYrR6n3uitQq4a3Rs/PEB7ZjxyIekVloezfvqYYnu7jcgw/AR3EZlWzQxADBfG
         vmbmmTC8rJYvsC5b0MEI+W+D+qn/K7gzgkconK24=
Date:   Sun, 15 Sep 2019 15:34:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.2 00/37] 5.2.15-stable review
Message-ID: <20190915133443.GA552182@kroah.com>
References: <20190913130510.727515099@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 02:07:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.15 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 15 Sep 2019 01:03:32 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> and the diffstat can be found below.

I have released -rc2 to resolve a build issue:
 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.15-rc2.gz
