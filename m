Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA24FC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A460D2244A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574229630;
	bh=2d2oFiuKLFEOGBdFCBRI/uZU667a1Rtk1tIk3n6mnA0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=gZz8LHtbsCukm6Q/jW7qaGC0gJEtDJLp/6QrRe0X6OS8JD234pYP0TXfHzbQ/FqLK
	 MPkmtfTS9X+GgHPpm9360EVtytfBEeJSKKf6YmXmUOiMkzOIIg/EaJsuYamhO2cMXX
	 HNS1aBxrko+QJZbyCkQGG78rO0Yspv3xmQkcbqps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKTGA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKTGA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:00:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DC1205C9;
        Wed, 20 Nov 2019 06:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574229628;
        bh=2d2oFiuKLFEOGBdFCBRI/uZU667a1Rtk1tIk3n6mnA0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Ww+AOqAIAnCQ6uE+LJNysbs2r/nNtvVcy4t2Ljs03cQE19q+ieNpM7zefeNyIxmsS
         5VnuMk8fnQuH7FeXLAy7Jus8i8NteXUQmixBteOhVOGHBv/FzCid5meebpaJHTKTJ1
         MLjvp5oyLSGl1ZHq1+z0VQmYWEAHs0pYFFdozfzo=
Date:   Wed, 20 Nov 2019 07:00:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.3 00/48] 5.3.12-stable review
Message-ID: <20191120060025.GC2853442@kroah.com>
References: <20191119050946.745015350@linuxfoundation.org>
 <20191119184524.v7b5mkopvv2zunpc@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119184524.v7b5mkopvv2zunpc@xps.therub.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:45:24PM -0600, Dan Rue wrote:
> On Tue, Nov 19, 2019 at 06:19:20AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.3.12 release.
> > There are 48 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great, thanks for testing all 3 of these and letting me know.

greg k-h
