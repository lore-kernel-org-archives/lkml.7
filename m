Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9892089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564495569;
	bh=J/b9I4zIh2nQcgEEakEPwUMi7XWdBncrC8zNpR2DFB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kIgcBjnz+liqIcG92TDUqh7ye+n/vmPktsB2lN7x5/LTShPh2t43aLLgs7EIWpqfB
	 5Uc+Huo/6HnwU1OhWPISXQzwpSgR3Qpp4sWuzeWsB0+4BLDhR1WXfBl/1aniYSsNhI
	 VEleKpdes7k7qIRwxI6xkbzCXTMw0IlL39QWS8gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfG3OGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfG3OGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:06:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2B8206E0;
        Tue, 30 Jul 2019 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564495566;
        bh=J/b9I4zIh2nQcgEEakEPwUMi7XWdBncrC8zNpR2DFB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orTGWnHldZG2G5eYOwsbArf7bMpZaVrT+3MseSKR9qCYCsD73t+lhDg0JKzp+sewc
         RMfdDpn/bxEmawQ1qpuUlvZ735pADXcnKjN3DzIQVGjrJ8AruonwKZX8rdIlFFGuo6
         Gpwl+IEjQ8JNK6w7ROXZUHvoE+xFrqlffWBAWToY=
Date:   Tue, 30 Jul 2019 16:06:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/215] 5.2.5-stable review
Message-ID: <20190730140604.GA31513@kroah.com>
References: <20190729190739.971253303@linuxfoundation.org>
 <23f2bcb1-aa1a-e4f2-0d18-e0c16de511de@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f2bcb1-aa1a-e4f2-0d18-e0c16de511de@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:01:42AM -0600, shuah wrote:
> On 7/29/19 1:19 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.5 release.
> > There are 215 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 31 Jul 2019 07:05:01 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.5-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
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
