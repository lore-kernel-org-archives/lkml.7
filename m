Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A658CC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FAC2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576615239;
	bh=W7Gx1YSBqt1c/dRzxqvrcZqCfmKdcTQWle02bnpMazs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fei5xCLzggdAGjMLYNj8t3o/2gguI3oOFFT4hVWdiB6nulU73iriDe4uvs6MrF6jK
	 MlNeXfeR2lzAMoF1Z6yzsoeEe+Rpo+pKXumx8BmGIcRMT3OtlKlfUst5pIRXJcZanu
	 x4NouTAk7iVAljGbL6YAeZHhZCGv5V2zd+YWTGFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfLQUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfLQUki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:40:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335DE2053B;
        Tue, 17 Dec 2019 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576615237;
        bh=W7Gx1YSBqt1c/dRzxqvrcZqCfmKdcTQWle02bnpMazs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Umn/e1iEpsgGlS3jcGKxYl8lw9UIUtc2wlhej4xKRlrua2cVas+hubBykgUzXbR+
         zxShiAhx2Wp3UVBS0Gl/jTj1/plch6FTeqTIz0W1WSZ4E9dMkpMLafs9UC/NbHdFmV
         W6H2G4BaXqsWbrcQsv1MslXBzR5+Ka7cDVuxAP94=
Date:   Tue, 17 Dec 2019 21:40:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.19.90
Message-ID: <20191217204035.GB4152841@kroah.com>
References: <20191217203954.GA4152841@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217203954.GA4152841@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:39:54PM +0100, Greg KH wrote:
> I'm announcing the release of the 4.19.90 kernel.
> 
> All users of the 4.19 kernel series must upgrade.
> 
> The updated 4.19.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------
> 
>  Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

That's not right, let me do this again...


