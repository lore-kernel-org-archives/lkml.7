Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6289BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AC0218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553323975;
	bh=faUx5I9kjdHbdymTTgHydeM5vUWa9b7ClHHVZodd9Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xOjB7oZ7OsK0JgjQbUZjaKp4k0UELiys0SpPGUJzmYNTtpjgPm0oFqWy7wYzFKeKY
	 vPI8SHuG7VCGNvw9Oz4c+NQGKAXRfxgnnxxMbvOz3/alEf8R2s4A+q1Vb6NsEQaGZ5
	 G3dhcepcD8oSLGvhShjyvDd8uM7jUHeRkTHwD7IE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfCWGwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfCWGwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:52:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A2C21902;
        Sat, 23 Mar 2019 06:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553323962;
        bh=faUx5I9kjdHbdymTTgHydeM5vUWa9b7ClHHVZodd9Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJ7ITMBrkq96Ov2N7im2EElBS/haG7crHDt8Y4tZ/+3aUrdXQmE+HY2ZddLiIMgbf
         5n4z7QBibSi20s8b/zpuXTqUHhliI5RifoROj5CnzOKpijMvkKaEM9+fqwW4xNqXjS
         qwpYuuYGGMs5S8dLMZZHI3QWTpvRNLQ6rtaJJPK4=
Date:   Sat, 23 Mar 2019 07:52:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/238] 5.0.4-stable review
Message-ID: <20190323065237.GB13517@kroah.com>
References: <20190322111258.383569278@linuxfoundation.org>
 <fba31581-44a9-661c-5f65-9474c376e567@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba31581-44a9-661c-5f65-9474c376e567@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:47:45PM -0700, Guenter Roeck wrote:
> On 3/22/19 4:13 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.4 release.
> > There are 238 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 24 11:11:13 UTC 2019.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 345 pass: 345 fail: 0

Wonderful, thanks for testing all 6 of these and letting me know.

greg k-h
