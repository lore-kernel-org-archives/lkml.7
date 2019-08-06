Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFABC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688D020B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfHFK3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:29:44 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:57856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732262AbfHFK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:29:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 67B4B6121;
        Tue,  6 Aug 2019 10:29:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goat74_37ab30b107b50
X-Filterd-Recvd-Size: 1545
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Aug 2019 10:29:42 +0000 (UTC)
Message-ID: <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
Subject: Re: [PATCH] USB: Move wusbcore and UWB to staging as it is obsolete
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Tue, 06 Aug 2019 03:29:40 -0700
In-Reply-To: <20190806101509.GA11280@kroah.com>
References: <20190806101509.GA11280@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 12:15 +0200, Greg Kroah-Hartman wrote:
> The UWB and wusbcore code is long obsolete, so let us just move the code
> out of the real part of the kernel and into the drivers/staging/
> location with plans to remove it entirely in a few releases.
[]
>  MAINTAINERS                                   | 15 +++-------
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3800,14 +3800,9 @@ F:	scripts/sign-file.c
>  F:	scripts/extract-cert.c
>  
>  CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
> -L:	linux-usb@vger.kernel.org
> +L:	devel@driverdev.osuosl.org
>  S:	Orphan

Better to mark this as obsolete so checkpatch emits
a message saying "no unnecessary modifications"


