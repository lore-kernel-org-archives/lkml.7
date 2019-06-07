Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40CEC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61DB20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfFGRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:35:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:57864 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfFGRfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:35:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 48F0B737;
        Fri,  7 Jun 2019 17:35:51 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:35:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] scripts/sphinx-pre-install: fix "dependenties" typo
Message-ID: <20190607113550.5be99c05@lwn.net>
In-Reply-To: <20190530215914.67896-1-helgaas@kernel.org>
References: <20190530215914.67896-1-helgaas@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 16:59:14 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typo ("dependenties" for "dependencies").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  scripts/sphinx-pre-install | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index f6a5c0bae31e..78bcd29139b2 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -559,7 +559,7 @@ sub check_needs()
>  	}
>  	printf "\n";
>  
> -	print "All optional dependenties are met.\n" if (!$optional);
> +	print "All optional dependencies are met.\n" if (!$optional);

Applied, thanks.

jon
