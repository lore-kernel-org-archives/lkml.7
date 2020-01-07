Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670F7C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBDB2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAGGsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:48:00 -0500
Received: from smtp.eckelmann.de ([217.19.183.80]:14592 "EHLO
        smtp.eckelmann.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:48:00 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 01:47:59 EST
Received: from ws067.eckelmann.group (2a00:1f08:4007:5c00:1a60:24ff:fe97:84c9)
 by EX-SRV2.eckelmann.group (2a00:1f08:4007:e035:172:18:35:5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 7 Jan 2020 07:32:55 +0100
Date:   Tue, 7 Jan 2020 07:32:50 +0100
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
CC:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] siox: Use the correct style for SPDX License
 Identifier
Message-ID: <20200107063250.GA30387@ws067.eckelmann.group>
References: <20200101131418.GA3110@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200101131418.GA3110@nishad>
X-Originating-IP: [2a00:1f08:4007:5c00:1a60:24ff:fe97:84c9]
X-ClientProxiedBy: EX-SRV2.eckelmann.group (2a00:1f08:4007:e035:172:18:35:5)
 To EX-SRV2.eckelmann.group (2a00:1f08:4007:e035:172:18:35:5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 06:44:23PM +0530, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style in
> header file related to Eckelmann SIOX driver.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Thorsten Scherer <thorsten.scherer@eckelmann.de>

> ---
> Changes in v2:
>   - Correct the spelling of the word Eckelmann.
> ---
>  drivers/siox/siox.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/siox/siox.h b/drivers/siox/siox.h
> index c674bf6fb119..f08b43b713c5 100644
> --- a/drivers/siox/siox.h
> +++ b/drivers/siox/siox.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2015-2017 Pengutronix, Uwe Kleine-König <kernel@pengutronix.de>
>   */
> -- 
> 2.17.1
> 

Kind regards
Thorsten

--
Thorsten Scherer | Eckelmann AG | www.eckelmann.de |
