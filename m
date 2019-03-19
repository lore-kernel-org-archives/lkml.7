Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0634213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552997987;
	bh=Jnwo2X9hC2XHYRF0UYMba6Nz7BKaTJ6PUsz3b/h62OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q5kdTb0ct5BtaJAiQVOM1BV+LJBDG4LB/pA9Q7UzNk0IRbft3Pt8HahsuyVKphFER
	 TrPnKUy+xQY0t22b9bi1ZpwSQQjd2+mrVCxCeYcbpY8z7Ik/P7Vcdqbbnzx9vS2faY
	 iAWhJsaA4gMMxUDNlUze+w8snte8sunK3zOaejpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCSMTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfCSMTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:19:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269892133D;
        Tue, 19 Mar 2019 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552997985;
        bh=Jnwo2X9hC2XHYRF0UYMba6Nz7BKaTJ6PUsz3b/h62OA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/TnZyZZMmdLETPspuPV2kMlKl0mPYEvVKBROQoKPVp0U8NTUnpbl7b6LMkl17Xg2
         2YEIGPQ6rLiFpTHREfTWY2cTOXlOe03nWOmSfYJcms75r12bj3bQp4OdiAdBmN3zeY
         wH+8ilevU5K0xV9lk7dQg4h+MpFKRTRgMh9iPkQk=
Date:   Tue, 19 Mar 2019 13:19:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/43] 5.0.3-stable review
Message-ID: <20190319121943.GA29633@kroah.com>
References: <20190318083715.877441740@linuxfoundation.org>
 <e658f53a-a751-473f-e8c3-b60531f02470@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e658f53a-a751-473f-e8c3-b60531f02470@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:26:52PM -0700, Guenter Roeck wrote:
> On 3/18/19 2:23 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.3 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 20 08:36:53 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 345 pass: 345 fail: 0

Great!  Thanks for testing all of these and letting me know.

greg k-h
