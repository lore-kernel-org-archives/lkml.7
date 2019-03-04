Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE226C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36DE20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfCDTwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:52:11 -0500
Received: from ms.lwn.net ([45.79.88.28]:34424 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDTwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:52:10 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0757E2B4;
        Mon,  4 Mar 2019 19:52:09 +0000 (UTC)
Date:   Mon, 4 Mar 2019 12:52:09 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: iio: fix errors in documentation
Message-ID: <20190304125209.4833553f@lwn.net>
In-Reply-To: <20190303131112.0d072a01@archlinux>
References: <20190225202326.17178-1-tduszyns@gmail.com>
        <20190303131112.0d072a01@archlinux>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Mar 2019 13:11:12 +0000
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On Mon, 25 Feb 2019 21:23:26 +0100
> Tomasz Duszynski <tduszyns@gmail.com> wrote:
> 
> > Improve IIO documentation by fixing a few mistakes.
> > 
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>  
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied, thanks.

jon
