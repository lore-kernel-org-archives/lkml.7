Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D6ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F995205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504012AbfJXSLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:11:54 -0400
Received: from ms.lwn.net ([45.79.88.28]:42620 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbfJXSLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:11:54 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 89787536;
        Thu, 24 Oct 2019 18:11:53 +0000 (UTC)
Date:   Thu, 24 Oct 2019 12:11:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] docs: ioctl: fix typo
Message-ID: <20191024121152.2004af92@lwn.net>
In-Reply-To: <20191021014336.14030-1-chris.packham@alliedtelesis.co.nz>
References: <20191021014336.14030-1-chris.packham@alliedtelesis.co.nz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 14:43:36 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> "pointres" should be "pointers".
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/ioctl/botching-up-ioctls.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ioctl/botching-up-ioctls.rst b/Documentation/ioctl/botching-up-ioctls.rst
> index ac697fef3545..2d4829b2fb09 100644
> --- a/Documentation/ioctl/botching-up-ioctls.rst
> +++ b/Documentation/ioctl/botching-up-ioctls.rst
> @@ -46,7 +46,7 @@ will need to add a 32-bit compat layer:
>     conversion or worse, fiddle the raw __u64 through your code since that
>     diminishes the checking tools like sparse can provide. The macro
>     u64_to_user_ptr can be used in the kernel to avoid warnings about integers
> -   and pointres of different sizes.
> +   and pointers of different sizes.

Applied, thanks.

jon
