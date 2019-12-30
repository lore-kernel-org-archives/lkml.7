Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD97C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF272071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577727926;
	bh=t8fkOdENEQOZmf9fm6n1m4ev1VP0p0kxphOsW400gyI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=PXPPYzZpMS4jva+cCctuy3av+vV/W3P/1AoQMVA+S9K8AV1wf/vFNjoux8ZpgC5QN
	 Qd8HH0gI+sGTW2BNjlKfwSOvwQpDYjh/dX2MPK88S2hQd6rP4akyIb1o/tOspFW76C
	 R4D5WsT1U4YIUFSJQVA3t020G8lUM5yUPuh90zk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfL3RpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3RpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:45:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB762053B;
        Mon, 30 Dec 2019 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577727924;
        bh=t8fkOdENEQOZmf9fm6n1m4ev1VP0p0kxphOsW400gyI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=xNayDEsGxsLsiPW4htdUQt03EvGPDAWT/zEt9cyh+88kskWOG68H9JNX074PbaNU5
         gIWBaJzV/NpTRWvxAXTXid3DECe08fOsthY1TxqOY8l7WfmYyS0Cyb+YeY4MrXev+V
         FO6eQ1XMpdsr5LT6n+JXTIfi54mzopMraB6ymuxI=
Date:   Mon, 30 Dec 2019 18:45:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/434] 5.4.7-stable review
Message-ID: <20191230174522.GA1499079@kroah.com>
References: <20191229172702.393141737@linuxfoundation.org>
 <20191230163437.sz4mb5gh7ed2htfa@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230163437.sz4mb5gh7ed2htfa@xps.therub.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 10:34:37AM -0600, Dan Rue wrote:
> On Sun, Dec 29, 2019 at 06:20:53PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.7 release.
> > There are 434 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

But didn't you add perf build testing to your builds?  That should have
broken things, so I am guessing not :(

greg k-h
