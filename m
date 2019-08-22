Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F98AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F12064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494879;
	bh=8YIskV3g2ELvJm5gvUcuHviZMwFQuwWB+NE2xhRFItM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lmxgfo+DtUh+mX1PY8Zp5qLdCVqP5Qj3YmdXTIJZ0psVusHAiFA8A7Y7/pMdvk2N5
	 zqmEGcrMLRqTqjkMsU4VRoWiLdWPLl5lo3Dzzd0I7LahivZHlfcU7BYZId4UZbrI1c
	 FSRIRKfhCEoeZ1YjuhNVEqUoX/ZsCG5LC0Q09QbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404922AbfHVR16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391796AbfHVR01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:27 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348902064A;
        Thu, 22 Aug 2019 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494787;
        bh=8YIskV3g2ELvJm5gvUcuHviZMwFQuwWB+NE2xhRFItM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhPZq2dTYhc+jLJicdbKMjyHJEP9MIDz70rf7o96k7+RoFQD8FWtLcN9zuL9WQfzT
         kVAmBunNJ6HDH34jxSbPEm+KSRGmEj4E+kSON1y9hiP5UtmVNIltJlZoFFsfUe4lLV
         YoR0XuiUlP9oZu1QXrPPjAr1kwVzztAhjQ0Yx1QQ=
Date:   Thu, 22 Aug 2019 10:26:19 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org
Subject: Re: [PATCH 5.2 000/135] 5.2.10-stable review
Message-ID: <20190822172619.GA22458@kroah.com>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:05:56PM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.2.10 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:07:10 PM UTC.
> Anything received after that time might be too late.

Just to confirm to everyone, yes, this is real :)

Sasha has been helping me out with the stable patch work for a while now
and we finally sat down together today and worked out how to do the
releases as well.  This is the first attempt at this, hopefully it all
works as it was all based on some horrible scripts that have evolved
over the past 15+ years, which he sanely rewrote into something
simple[1].

If anyone notices anything that we messed up, please let us know.

thanks,

greg k-h

[1] Turns out that 'git format-patch' does a lot more things now than it
    used to, so most of my 'formail' scripts are no longer needed.
