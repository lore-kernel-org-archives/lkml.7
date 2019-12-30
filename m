Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E3AC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D78F2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iguana.be header.i=@iguana.be header.b="maaN5zSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfL3P7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:59:45 -0500
Received: from infomag.iguana.be ([185.87.124.46]:39066 "EHLO
        infomag.iguana.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfL3P7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 10:59:45 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2019 10:59:44 EST
Received: by infomag.iguana.be (Postfix, from userid 1001)
        id 8BFEC603CACD; Mon, 30 Dec 2019 16:53:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 infomag.iguana.be 8BFEC603CACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iguana.be;
        s=infomag-20180602; t=1577721218;
        bh=QWQ3dI0bHOs9NF/+MOj7mZ3u9IcPGxtzzLpiEk++eiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maaN5zSWP4jbllr+f2uYJRCgDUm9SL+J/UO3vU4Wig1xdwS0WARrFkptkOEBcNtSi
         eD2xSoV8kGe/YlehjQCdZmz6qRQyv4wNU/lW1L+fJiUx1sq7R0Zjdvf0OEnnsSmgj4
         fPf1uXYfBWrIis7ieAJLqIHXPct4vlmFxqQX8ekE=
Date:   Mon, 30 Dec 2019 16:53:38 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: linux-next: Signed-off-by missing for commit in the watchdog tree
Message-ID: <20191230155338.GA19493@infomag.iguana.be>
References: <20191221142859.59b88b2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221142859.59b88b2c@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> Hi all,
> 
> Commit
> 
>   ad5acedd16f8 ("watchdog: w83627hf_wdt: Fix support NCT6116D")
> 
> is missing a Signed-off-by from its author.
> 
> -- 
> Cheers,
> Stephen Rothwell

Fixed.

Kind regards,
Wim.

