Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0441C04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E5B208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557060086;
	bh=oTLoU8O/Iq3RghvEuonBsUORgGoSFe14q+ZWeNUPvpw=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=YELTwEzKxyAIGhY0CjxXkpEQ9qhjH5mhNP87AgMtL06L/ODlhCkftLnX2OWB62Fqv
	 FQfIq7gkhs2rlgauXt/pvZDmKVXIdLQmphdTieKRT6SjJq8Ay7L7N4v4MVldg2wlys
	 q3IuvJPnnrkec4vXAsrSep212uKrqVOfDj89yZR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfEEMlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 08:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfEEMlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 08:41:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6DC20675;
        Sun,  5 May 2019 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557060084;
        bh=oTLoU8O/Iq3RghvEuonBsUORgGoSFe14q+ZWeNUPvpw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=sJ1DEylQVS3JVhj8MyUcQA/b5dIX08EJqxtor/x7bz5ZhIDpZowfauod0kWPodF+Q
         ngd/aoREJgAUDb7lJnAUDF32YirC9Guo32O3CdQ+k+vH+4V2Z/pYX5Lg6QcHefCoYr
         IThCm5sN7xkh67QPo1uHGndNM4KvVMBzBNZkyjCg=
Date:   Sun, 5 May 2019 14:41:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/32] 5.0.13-stable review
Message-ID: <20190505124121.GA17233@kroah.com>
References: <20190504102452.523724210@linuxfoundation.org>
 <20190505030515.txopqluki6mc2px2@xps.therub.org>
 <4913833a-5b46-20d0-4dce-3e6d46a7a498@roeck-us.net>
 <20190505121748.p7yeymdissakg4q5@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505121748.p7yeymdissakg4q5@xps.therub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2019 at 07:17:48AM -0500, Dan Rue wrote:
> On Sat, May 04, 2019 at 08:31:36PM -0700, Guenter Roeck wrote:
> > On 5/4/19 8:05 PM, Dan Rue wrote:
> > > On Sat, May 04, 2019 at 12:24:45PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.0.13 release.
> > > > There are 32 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Mon 06 May 2019 10:24:23 AM UTC.
> > > > Anything received after that time might be too late.
> > > 
> > > Results from Linaro’s test farm.
> > > Regressions detected.
> > > 
> > 
> > Confusing. What are the regressions ? Below it says that there are none.
> 
> My mistake for dashing it off too quickly. No regressions on arm64, arm,
> x86_64, and i386.

Thanks for confirming this.

greg k-h
