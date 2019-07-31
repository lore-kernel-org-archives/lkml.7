Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98A6206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGaURJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:17:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:56102 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaURI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:17:08 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 11F1F7DA;
        Wed, 31 Jul 2019 20:17:08 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:17:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] docs: fs: convert porting to ReST
Message-ID: <20190731141707.6f3d21d7@lwn.net>
In-Reply-To: <a2303fe9fa2103e7d1f8589e1f91a7d65497e8b7.1564603513.git.mchehab+samsung@kernel.org>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
        <a2303fe9fa2103e7d1f8589e1f91a7d65497e8b7.1564603513.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 17:08:52 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> This file has its own proper style, except that, after a while,
> the coding style gets violated and whitespaces are placed on
> different ways.
> 
> As Sphinx and ReST are very sentitive to whitespace differences,
> I had to opt if each entry after required/mandatory/... fields
> should start with zero spaces or with a tab. I opted to start them
> all from the zero position, in order to avoid needing to break lines
> with more than 80 columns, with would make harder for review.
> 
> Most of the other changes at porting.rst were made to use an unified
> notation with works nice as a text file while also produce a good html
> output after being parsed.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/filesystems/porting.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 66aa521e6376..f18506083ced 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -158,7 +158,7 @@ Callers of notify_change() need ->i_mutex now.
>  New super_block field ``struct export_operations *s_export_op`` for
>  explicit support for exporting, e.g. via NFS.  The structure is fully
>  documented at its declaration in include/linux/fs.h, and in
> -Documentation/filesystems/nfs/Exporting.
> +Documentation/filesystems/nfs/exporting.rst.
>  
>  Briefly it allows for the definition of decode_fh and encode_fh operations
>  to encode and decode filehandles, and allows the filesystem to use

This patch doesn't match the changelog at all.  I think it's one leftover
fix after the previous version of the patch was applied...?

jon
