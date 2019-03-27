Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C204BC10F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D72087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553648144;
	bh=xsu+7kyLnsfIt3ITLEGlN44Gl1OxJ2irPSKwEbDO2jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YW/94w26GsdJE3mIXuGoLjQ304badrEl0jo1n8njqSX1E5V+zNEQkZoAudjKamybn
	 qSxPRkuhE18RS5NTrol3yPd+zLDzQMbZ9SNtsMV+mL0VvGPQFUnZA2ZfvUK1Z7G+DS
	 8Ya0fM8vDsF+fnCifosdQT7aq/7TIWFE3IvQA5tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfC0Azn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfC0Azn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:55:43 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F282082F;
        Wed, 27 Mar 2019 00:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553648142;
        bh=xsu+7kyLnsfIt3ITLEGlN44Gl1OxJ2irPSKwEbDO2jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0PFuvPxU5PaD79+tcT54ZvZVwKEOcBCybg3nN3riz4tprssv0jQ2ZaCvDFYRcBAZ
         mlYQ9JYWNopu+AhxXEJDGtUMlZQnGRjDb/MBJAqCA9X/Tgl7uYuA7topDmSKCYuixF
         ldWkGNiJWzJPIHafoEwuCtsOlAw4Ps9X+6okM6c0=
Date:   Wed, 27 Mar 2019 09:55:37 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/52] 5.0.5-stable review
Message-ID: <20190327005537.GA29485@kroah.com>
References: <20190326042700.963224437@linuxfoundation.org>
 <846b9bed-9db0-2e9b-1f26-71ee418492b1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846b9bed-9db0-2e9b-1f26-71ee418492b1@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:18:04PM -0600, shuah wrote:
> On 3/26/19 12:29 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.5 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 28 04:26:38 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.5-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
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
