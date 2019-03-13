Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1610AC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF932077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552510785;
	bh=pVMnZBwdpt4HQc5DL8+d2k/IqxDjmoY47DtGcxlRq/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vBp0c1iL7sHv1IG80pree4rmmWAYvbgwgGRnDrn1/JAjRmzO+G4qjkNktf+IarKCn
	 h9pnYVYUlB/+lggbZ15znEcl9p5q4t68e53PTV3NwSSVJe1MZ/oS9F9xdQg8Rjy4ww
	 R2r2e7/8CeTa/PyBFll7sRpl0MKMpKKlZ/TqgzKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCMU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:59:44 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C2D206DF;
        Wed, 13 Mar 2019 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552510783;
        bh=pVMnZBwdpt4HQc5DL8+d2k/IqxDjmoY47DtGcxlRq/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeIb8rCDDYrrAKa5Q9jzaM40YnCvNX01zV5YYj9RTvpCd79CBqrAElUROMxN0PS1k
         LYd6bqzTaXoX8wq9M3gim46RPTepkwGydyyxAgZbCy8kVsmcAG1IHuyljFXXscs31o
         iR8fKDFi+YekxqRBQAzBrne1zw35/JamgczmwVb4=
Date:   Wed, 13 Mar 2019 13:59:43 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/25] 5.0.2-stable review
Message-ID: <20190313205943.GD5289@kroah.com>
References: <20190312170403.643852550@linuxfoundation.org>
 <20190313203625.GE26634@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313203625.GE26634@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:36:25PM -0700, Guenter Roeck wrote:
> On Tue, Mar 12, 2019 at 10:08:38AM -0700, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.2 release.
> > There are 25 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 14 17:03:43 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 345 pass: 345 fail: 0

Great!  Thanks for testing all of these and letting me know.

greg k-h
