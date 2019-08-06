Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE4C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27632216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565107322;
	bh=HOrSVJmekUuoCcV/AI4yIkSlnbHhBNxOYMrMq6QoUfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2qcHTxnyxr3XT4+gQdPAxUpkzTbjA/5gzXsG9hBHHtyEyuPrlf2SF746yzOb5fqG1
	 m9l229rR+1gJ2KquVQkQ1juxLf4T+moxgciJJVABr2gqmBGJIax/osPgasTa1YxSeN
	 M72KS8o4dUTb1wISQ7lqPbaUmOHHxBv3rQDfshoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbfHFQCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfHFQCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:02:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724DA20818;
        Tue,  6 Aug 2019 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565107319;
        bh=HOrSVJmekUuoCcV/AI4yIkSlnbHhBNxOYMrMq6QoUfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1wdzBKALR62tUMD+QaTFEmzmEaW/8ZtLkwmt1k0SZpOfKlq8F7+00YtT0PDB671O
         6MCbL6mxtDPl/Pm1xnT3zD9QAOfdVoyNYCokwpqFYdpH7cNXhUex7HHgh++7A4cFhk
         kRXe/2bFa4GIKUztyTDJD0mY2eJ5H4q9xqTXxgWQ=
Date:   Tue, 6 Aug 2019 18:01:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/131] 5.2.7-stable review
Message-ID: <20190806160157.GA1988@kroah.com>
References: <20190805124951.453337465@linuxfoundation.org>
 <20190806155020.GE12156@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806155020.GE12156@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:50:20AM -0700, Guenter Roeck wrote:
> On Mon, Aug 05, 2019 at 03:01:27PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.7 release.
> > There are 131 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 07 Aug 2019 12:47:58 PM UTC.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 364 pass: 364 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
