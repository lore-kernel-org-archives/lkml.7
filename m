Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF43C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1EB21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553264313;
	bh=htCb1HKwDkbNJJeEZqg6+aCqnbOHf1gUGGp5OxQqMho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nU1chRV8fpJm8G8iqt3Jy8Z7VintA13xsXNM9Oz9PmlabZfjBd4fDp3m5SqksmXY5
	 DQmeSFgrpJ8HnMl4qWzOQM5FtJ5WV3rkk4Er/wM8Ba/JPn+CFVhLNSJT9eNgkrKl2F
	 bhlovcUWqFc271HVvNnf53k6ygVSetpGVBpAHwGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfCVOSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfCVOSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:18:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713CA218FC;
        Fri, 22 Mar 2019 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553264311;
        bh=htCb1HKwDkbNJJeEZqg6+aCqnbOHf1gUGGp5OxQqMho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSJ6LxcBIP4tssO23qTkMhd5ofICnv1vwZ/5YN1A26X+BDXDUEnr1qYgA7d3RSMcH
         iLbrnDiPFHTOd70YexI4Hbfzw6v5fBQGYXbmNS0uWZg0PIVHVAMzmygQJ8Ff//aiA2
         yHky3EIg6b3D38oE7OSnSI1MHhcsYGqqd0IkEXMQ=
Date:   Fri, 22 Mar 2019 15:18:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     christian@lkamp.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: ralink-gdma: Change uint32_t to u32
Message-ID: <20190322141828.GB12018@kroah.com>
References: <20190322130507.GA4205@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322130507.GA4205@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 06:35:07PM +0530, Bharath Vedartham wrote:
> Change occurences of uint32_t to u32 to fix checkpatch.pl warnings.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> Changes since v1:
> 	- Improved changelog.

I have 3 "v2" patches from you :(

I have no idea which one is the "correct" one, so I am dropping them
all.

Please fix up, and resend a "v3" patch, and only one copy of it.

thanks,

greg k-h
