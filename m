Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D752064A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCRRuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:50:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:51010 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfCRRue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:50:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DAB3560C;
        Mon, 18 Mar 2019 17:50:33 +0000 (UTC)
Date:   Mon, 18 Mar 2019 11:50:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, konrad.wilk@oracle.com, mfleming@suse.com,
        ross.philipson@oracle.com, daniel.kiper@oracle.com
Subject: Re: [PATCH] doc: add boot protocol 2.13 description to
 Documentation/x86/boot.txt
Message-ID: <20190318115032.349d92c2@lwn.net>
In-Reply-To: <20190308114310.25041-1-jgross@suse.com>
References: <20190308114310.25041-1-jgross@suse.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 12:43:10 +0100
Juergen Gross <jgross@suse.com> wrote:

> Documentation/x86/boot.txt is missing protocol 2.13 description.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  Documentation/x86/boot.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
> index f4c2a97bfdbd..223e484a1304 100644
> --- a/Documentation/x86/boot.txt
> +++ b/Documentation/x86/boot.txt
> @@ -61,6 +61,10 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
>  		to struct boot_params for loading bzImage and ramdisk
>  		above 4G in 64bit.
>  
> +Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set in
> +		xloadflags to support booting a 64-bit kernel from 32-bit
> +		EFI
> +
>  **** MEMORY LAYOUT

Applied (with vast numbers of Reviewed-by tags), thanks.

jon
