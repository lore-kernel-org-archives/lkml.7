Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538A7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28618218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfCUWCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:02:02 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:50358 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfCUWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:02:02 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-115-194-nat.elisa-mobile.fi [85.76.115.194])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id CCB792006B;
        Fri, 22 Mar 2019 00:01:59 +0200 (EET)
Date:   Fri, 22 Mar 2019 00:01:59 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mips: ralink: allow zboot
Message-ID: <20190321220159.GC7872@darkstar.musicnaut.iki.fi>
References: <20190321170334.15122-1-thirtythreeforty@gmail.com>
 <20190321170334.15122-2-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321170334.15122-2-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 21, 2019 at 11:03:34AM -0600, George Hilliard wrote:
> Architecturally, there's nothing preventing compressed images from
> working.  Bootloaders built with support for the various compression
> methods can decompress and run the kernel.  In practice, many
> bootloaders do not support compressed images, but kernels for those
> boards should just not be compressed.

With zboot the decompressor is included in the image so no bootloader
support is needed.

A.
