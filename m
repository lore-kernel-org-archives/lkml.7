Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92514C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6CF206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560440344;
	bh=X8l9b1+mtsP9NQv7VWDOxVrBKP4hI/3hilidRbcNgbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ovtg2IDDz3t+Zi5H4q/q2kyfXdrfmL5nW/cMD8h5I1spxPCUDbt5hSH6KS0t2rNcX
	 iQrpQOW1U+h9tC6JN1o8wYtbgGN6bSWmah8nm4dnagTSV+CukJAax/uWikukFXe8vX
	 NpIzw9nfCQNZ6HS9ea414z0RA6+ids60zizyjiR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfFMPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:39:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:33356 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbfFMJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zd7Y7/fVtcy9h7LRt+pgmFLEzRR3UYPAM2/1CQ/alFQ=; b=tYM5mJx45M6Wd3ewpvbLR86+W8
        SpwhFYvZ77/1fEg0vrN5CzDDdt/+vsfic0cGQ/f7J09o3yyYkGqCdjhrFm+iw9asBDO2NQD3mykRn
        RLnFMTe/yn9f4PfWcYypmgjkeYUmtErMwbvH5xgFK5+XI4zUyTvqNm0XZxK8Rrd2W4oo5iZYaR0t8
        j7jmbSh1GCelXwnZIBgQNJt+VxCQ/scIVaxnx5oEAPDKDIkDLscobgmZdbHfz8IqXzeim4KLK3Hsb
        UySdk+tcmbbpd2CAxqXL9uLfhZUZ/M8hGAES907CieN7qPt7GVKh06p2EQ+6flP4hkzojBIA/HMP8
        n7eMhpOw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMTh-0000dd-MK; Thu, 13 Jun 2019 09:57:08 +0000
Date:   Thu, 13 Jun 2019 06:57:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     linux@roeck-us.net, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] docs: watchdog: make htmldocs failed.
Message-ID: <20190613065554.1dd69b86@coco.lan>
In-Reply-To: <20190613000237.377-1-jerry.hoemann@hpe.com>
References: <20190613000237.377-1-jerry.hoemann@hpe.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Jun 2019 18:02:36 -0600
Jerry Hoemann <jerry.hoemann@hpe.com> escreveu:

> Guenter,
> 
> While making htmldocs from linux-staging.git watchdog-next, the
> build failed due what I think is a missing blank line after a header
> separator in:
> 
> 	Documentation/watchdog/watchdog-parameters.rst
> 
> I'm a newbie w.r.t. to the .rst file formats, but adding the blank
> lines got the "make htmldocs" to complete.

Yeah, Sphinx doesn't like to see things like:

------------
foo

as it will miss-interpret the <hr> tag. That usually cause a
severe error the parser, breaking the entire build.

> 
> 
> 
> 
> 
> 
> Jerry Hoemann (1):
>   docs: watchdog: Fix build error.
> 
>  Documentation/watchdog/watchdog-parameters.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 



Thanks,
Mauro
