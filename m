Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA27C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08A12071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577734902;
	bh=zWR1U6YvH/AYtaL4nxSZak3KMvgYRHYXwu6AffvYHM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=va6WYcNgPHoGLLD8IMPHVAU6LEYi5PmvuMXeIEwU6UANy1Kex/TSCXMWflcNojxKG
	 BGkEPWh/8/tc16owICrFIpDMTpj821kS3zjzCpfZeVedpQKi9ejFNqos1yRf8NT2O4
	 uJRrD2EvkRPL3lrMoceflOyz6Sx2R+ffEZjc3Xv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfL3Tll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3Tll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:41:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7F1206DB;
        Mon, 30 Dec 2019 19:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577734900;
        bh=zWR1U6YvH/AYtaL4nxSZak3KMvgYRHYXwu6AffvYHM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7O+wIStlemH+l15igk5jp+JkHoh/Tmsx7CLnvMsAYfctj3MlWilVFn8ZnL1BY4st
         LFTmPiN460thbmFEJS9XfJh45RTZ9dd3xC6YCRxfbgWiqpo9n4yvLEfotW2zsc+Stc
         08BvOjozegYrH8bCovDOPTSVEWm3wBbwv95pipO4=
Date:   Mon, 30 Dec 2019 20:41:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/434] 5.4.7-stable review
Message-ID: <20191230194138.GA1880685@kroah.com>
References: <20191229172702.393141737@linuxfoundation.org>
 <20191230174336.GA1498696@kroah.com>
 <20191230181708.GB14939@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230181708.GB14939@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 07:17:08PM +0100, Willy Tarreau wrote:
> Hi Greg,
> 
> On Mon, Dec 30, 2019 at 06:43:36PM +0100, Greg Kroah-Hartman wrote:
> > I have pushed out -rc2:
> >  	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.7-rc2.gz
> > 
> > to resolve some reported issues.
> 
> OK, running right now on my netbook. So far, so good:
> 
> Linux eeepc 5.4.7-rc2-eeepc #1 SMP Mon Dec 30 18:55:14 CET 2019 i686 Intel(R) Atom(TM) CPU N2800   @ 1.86GHz GenuineIntel GNU/Linux
> 
> Also not sure what is supposed not to work with perf, but at least I've
> built it and it seems to work as expected at first glance.

If it builds, then the problem is fixed, as that is what was previously
failing :)

thanks for testing and letting me know.

greg k-h
