Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A1C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24B621726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564761025;
	bh=Ry/UcDKNhIML1ZAxlaV7qJFXLBLwFltgqT3P/2ELyJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s83dT7wLdF3EtBD9Cc6nYCwxYN9kgBNVBvfH8M3bUawfzVSmeSkFhJFvU8bkqZLkj
	 FIlkC/ghJHY3NNhghY34nDWeVIxMx5Y2azIYWjtvmvvQk5B4WQdDpSKHM2FAkiTXb5
	 ylEAVsD9C/1hasNdb1rbl6XF3MN0fgsxJ8zBrw2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfHBPuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfHBPuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:50:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ECFA20679;
        Fri,  2 Aug 2019 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761023;
        bh=Ry/UcDKNhIML1ZAxlaV7qJFXLBLwFltgqT3P/2ELyJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ypmSFv5ARpA1McrmiPdNupW4T+chnAWpZI/0RRtjkPRRp+9Pa5jmCMJW2hoWk0nbP
         +rtdlIE2l/gpKpDvWnIg9GwHWXbZ3clBwM/vMmUfrnChZbHHb9J6ePnEBHrJorL12G
         dawnOaEA2TuMl4T1de+jVR6HEOHyuvtowJ1Z0Z+w=
Date:   Fri, 2 Aug 2019 17:50:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/25] 4.14.136-stable review
Message-ID: <20190802155020.GA28265@kroah.com>
References: <20190802092058.428079740@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802092058.428079740@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:39:32AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.136 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.

-rc2 is out to match up with the failure of one patch to apply, and the
ip tunnel patch added.

 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.136-rc2.gz

thanks,

greg k-h
