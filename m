Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D2CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2C920851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfETT1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:27:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:35732 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfETT1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:27:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2172E6A2;
        Mon, 20 May 2019 19:27:50 +0000 (UTC)
Date:   Mon, 20 May 2019 13:27:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Cengiz Can <cengizc@gmail.com>
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kdump: fix minor typo
Message-ID: <20190520132749.093c3c78@lwn.net>
In-Reply-To: <20190514161724.16604-1-cengizc@gmail.com>
References: <20190514161724.16604-1-cengizc@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 19:17:25 +0300
Cengiz Can <cengizc@gmail.com> wrote:

> kdump.txt had a minor typo.
> 
> Signed-off-by: Cengiz Can <cengizc@gmail.com>
> ---
>  Documentation/kdump/kdump.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 51814450a7f8..3162eeb8c262 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -410,7 +410,7 @@ Notes on loading the dump-capture kernel:
>  * Boot parameter "1" boots the dump-capture kernel into single-user
>    mode without networking. If you want networking, use "3".
>  
> -* We generally don' have to bring up a SMP kernel just to capture the
> +* We generally don't have to bring up a SMP kernel just to capture the

Applied, thanks.

jon
