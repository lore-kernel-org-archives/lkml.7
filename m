Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2800D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfCNUux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:50:53 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:44323 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbfCNUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:50:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B485C6D81;
        Thu, 14 Mar 2019 20:50:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tooth72_5e8bff1b85a29
X-Filterd-Recvd-Size: 1703
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Mar 2019 20:50:49 +0000 (UTC)
Message-ID: <dc871c3e4eb911220e7b079a25ea449413749b09.camel@perches.com>
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in
 spi-mt7621.c
From:   Joe Perches <joe@perches.com>
To:     Jean Delvare <jdelvare@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Armando Miraglia <arma2ff0@gmail.com>, neil@brown.name,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        sankalpnegi2310@gmail.com, matthias.bgg@gmail.com, sr@denx.de,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 14 Mar 2019 13:50:48 -0700
In-Reply-To: <20190314150737.61eed622@endymion>
References: <20190313122403.248873-1-armax@google.com>
         <20190313123454.GB2202@kadam> <20190314111313.GB8034@google.com>
         <20190314112732.GJ2227@kadam> <20190314150737.61eed622@endymion>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-14 at 15:07 +0100, Jean Delvare wrote:
> My principle is that if a script
> is present in the kernel tree then it can and should be maintained. If
> it is deemed not worth the maintenance effort then it should be
> deleted.

I've suggested deleting Lindent in the past.
https://lkml.org/lkml/2013/2/11/390

Also there is now the clang-format tool that
does an OK job of reflowing source to something
approximating the typical kernel style.

See:  Documentation/process/clang-format.rst



