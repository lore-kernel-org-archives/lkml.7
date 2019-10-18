Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AABCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7521897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409104AbfJRPtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:49:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:36726 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394157AbfJRPtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:49:33 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E3A256D9;
        Fri, 18 Oct 2019 15:49:32 +0000 (UTC)
Date:   Fri, 18 Oct 2019 09:49:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updated iostats docs
Message-ID: <20191018094931.60df486f@lwn.net>
In-Reply-To: <20191016201337.88554-1-albertvaka@gmail.com>
References: <20191016201337.88554-1-albertvaka@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 22:13:37 +0200
Albert Vaca Cintora <albertvaka@gmail.com> wrote:

> revious docs mentioned 11 unsigned long fields, when the reality is that
> we have 15 fields with a mix of unsigned long and unsigned int.
> 
> Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
> ---
>  Documentation/admin-guide/iostats.rst | 47 ++++++++++++++-------------
>  1 file changed, 24 insertions(+), 23 deletions(-)

I've applied this as an improvement over what's there now, but...

> diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
> index 5d63b18bd6d1..321aae8d7e10 100644
> --- a/Documentation/admin-guide/iostats.rst
> +++ b/Documentation/admin-guide/iostats.rst
> @@ -46,78 +46,79 @@ each snapshot of your disk statistics.
>  In 2.4, the statistics fields are those after the device name. In
>  the above example, the first field of statistics would be 446216.
>  By contrast, in 2.6+ if you look at ``/sys/block/hda/stat``, you'll
> -find just the eleven fields, beginning with 446216.  If you look at
> -``/proc/diskstats``, the eleven fields will be preceded by the major and
> +find just the 15 fields, beginning with 446216.  If you look at
> +``/proc/diskstats``, the 15 fields will be preceded by the major and

This document is full of information about the behavior of the 2.4 kernel,
which seems less than fully interesting in 2019.  It would be Really Nice
if somebody could go through and simply update this document to current
reality and discard all of the cruft.

Thanks,

jon
