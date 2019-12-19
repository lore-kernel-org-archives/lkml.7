Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCADC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497A924672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLSQ0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:26:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:37082 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:26:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 44658382;
        Thu, 19 Dec 2019 16:26:00 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:25:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH] Documentation: x86: fix boot.rst warning and format
Message-ID: <20191219092559.5260d151@lwn.net>
In-Reply-To: <c6fbf592-0aca-69d9-e903-e869221a041a@infradead.org>
References: <c6fbf592-0aca-69d9-e903-e869221a041a@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2019 20:25:10 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix a Sphinx documentation format warning by breaking a long line
> into 2 lines.
> 
> Also drop the ':' usage after the Protocol version numbers since
> other Protocol versions don't use colons.
> 
> Documentation/x86/boot.rst:72: WARNING: Malformed table.
> Text in column margin in table line 57.
> 
> Fixes: 2c33c27fd603 ("x86/boot: Introduce kernel_info")
> Fixes: 00cd1c154d56 ("x86/boot: Introduce kernel_info.setup_type_max")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  Documentation/x86/boot.rst |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

jon
