Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F224BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D200C2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfEWUAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:00:55 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:43075 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387455AbfEWUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:00:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 297F1100E86C8;
        Thu, 23 May 2019 20:00:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hole85_5ee488a53b31a
X-Filterd-Recvd-Size: 1650
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 May 2019 20:00:51 +0000 (UTC)
Message-ID: <1b741b25b973e049948b3e490c13aad48716d5b0.camel@perches.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for fieldbus subsystem
From:   Joe Perches <joe@perches.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 May 2019 13:00:50 -0700
In-Reply-To: <20190523195313.31008-1-TheSven73@gmail.com>
References: <20190523195313.31008-1-TheSven73@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 15:53 -0400, Sven Van Asbroeck wrote:
> Add myself as the maintainer of the fieldbus subsystem.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -14905,6 +14905,11 @@ L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  F:	drivers/staging/erofs/
>  
> +STAGING - FIELDBUS SUBSYSTEM
> +M:	Sven Van Asbroeck <TheSven73@gmail.com>
> +S:	Maintained
> +F:	drivers/staging/fieldbus/*

The F: pattern above excludes subdirectories.

What about the drivers/staging/fieldbus/Documentation directory?

patch 2/2 specifically covers the anybuss directory,
but the Documentation directory has no matching pattern.

trivia: anybuss looks like a misspelling.
It might be better as anybus-s.




