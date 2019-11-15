Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E19C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46623206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKOPqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:46:42 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:35763 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfKOPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:46:41 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 42AC73C009C;
        Fri, 15 Nov 2019 16:46:40 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JOQJ0e7iD_R2; Fri, 15 Nov 2019 16:46:31 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id CEBDB3C04C0;
        Fri, 15 Nov 2019 16:46:31 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 15 Nov
 2019 16:46:31 +0100
Date:   Fri, 15 Nov 2019 16:46:27 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
Message-ID: <20191115154627.GA2187@lxhi-065.adit-jv.com>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
 <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
X-Originating-IP: [10.72.93.66]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, Nov 15, 2019 at 07:09:17AM -0800, Joe Perches wrote:
> On Fri, 2019-11-15 at 16:02 +0100, Eugeniu Rosca wrote:
> > Oftentimes [1], the contributor would like to honor or give credits [2]
> > to somebody's original ideas in the submission/reviewing process. While
> > "Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
> > employed for this purpose, they are not ideal.
> 
> You need to get the use of this accepted into Documentation/process
> before adding it to checkpatch

If the change [*] makes sense to you, I can submit an update to
Documentation/process/submitting-patches.rst

[*] https://marc.info/?l=linux-kernel&m=157383014408527&w=2

-- 
Best Regards,
Eugeniu
