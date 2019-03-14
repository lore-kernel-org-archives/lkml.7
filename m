Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62598C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE692070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCNOHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:07:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfCNOHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:07:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E75EAB6D;
        Thu, 14 Mar 2019 14:07:40 +0000 (UTC)
Date:   Thu, 14 Mar 2019 15:07:37 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Armando Miraglia <arma2ff0@gmail.com>, neil@brown.name,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        sankalpnegi2310@gmail.com, matthias.bgg@gmail.com, sr@denx.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in
 spi-mt7621.c
Message-ID: <20190314150737.61eed622@endymion>
In-Reply-To: <20190314112732.GJ2227@kadam>
References: <20190313122403.248873-1-armax@google.com>
        <20190313123454.GB2202@kadam>
        <20190314111313.GB8034@google.com>
        <20190314112732.GJ2227@kadam>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, 14 Mar 2019 14:27:32 +0300, Dan Carpenter wrote:
> On Thu, Mar 14, 2019 at 12:13:15PM +0100, Armando Miraglia wrote:
> > Is there an explicit intent to deprecate Lindent in favor of checkpatch.pl
> > --fix? If one would like to contribute to fixing the tooling for linting which
> > of the two would be the right target for such an effort?
> 
> I've added Jean to the CC list because he worked on Lindent a few
> years ago.  I really think we should just delete Lindent.  I haven't
> used the checkpatch.pl --fix option but Joe Perches has good style.

I merely fixed obvious but minor issues in Lindent as I stumbled upon
them the one time in my life I used that script. That was years ago.
I'm not using it on a regular basis. My principle is that if a script
is present in the kernel tree then it can and should be maintained. If
it is deemed not worth the maintenance effort then it should be
deleted. I don't care either way.

-- 
Jean Delvare
SUSE L3 Support
