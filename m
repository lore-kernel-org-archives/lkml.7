Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55874C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D80220882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LE0XE5FK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bKnw0WJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfDDIqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:46:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:46:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1CDAA6063F; Thu,  4 Apr 2019 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554367575;
        bh=UyR2wtc3+uhGjlU6bi4qgQOWKUQSIrSNpwTQYl18dgo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LE0XE5FKfokQpji1vSwfnVBL1WJfH4k4K+qEYmqNCjbV9XTjX3ei4X/RZD6Ek6Ihp
         HRnh3IdY4Iw2DenPVylKOgxACRlLrnjqbWeHJq9uXVQRWEkSOJdzW73c22TrM44Vau
         9HkjqwOo8M0UqtsrYgBpYfObnykGXV0IcH63gVZE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8A156063F;
        Thu,  4 Apr 2019 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554367573;
        bh=UyR2wtc3+uhGjlU6bi4qgQOWKUQSIrSNpwTQYl18dgo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bKnw0WJijI70PoeJ8KmdyFRXgPJRTeXTw6HsISYzWHnSKOMF9062gntIObTdX9heU
         kKiRMCICuQUycgE973Fpw1MUcLx/qumrI6sUrKmLJfucL0izOM7ziAc8ybvLmIZzJy
         EHJuQ7yYZqmi6fakWFKdLk38KZOcqeldXyyL6rkI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8A156063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/2] tty: fix up a few remaining files without SPDX
 identifiers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190402140708.519-1-gregkh@linuxfoundation.org>
 <20190402140708.519-2-gregkh@linuxfoundation.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <988b3a14-f5f6-44cb-3bda-eb7489bd2431@codeaurora.org>
Date:   Thu, 4 Apr 2019 14:16:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402140708.519-2-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/2019 7:37 PM, Greg Kroah-Hartman wrote:
> There were a few straggling files under drivers/tty/ that did not have
> any SPDX identifier either because they entered the tree recently, or
> they somehow missed the mass-tagging of commit b24413180f56 ("License
> cleanup: add SPDX GPL-2.0 license identifier to files with no license")
>
> This commit follows the same rule as b24413180f56 ("License cleanup: add
> SPDX GPL-2.0 license identifier to files with no license") where files
> without any specified license in them fall under GPL-2.0 as the correct
> license for the individual file.  Add that identifier to these remaining
> files so that we don't have to guess at the license of them in the
> future.
>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/tty/serial/8250/8250_men_mcb.c | 1 +
>   drivers/tty/serial/sn_console.c        | 1 +
>   drivers/tty/vcc.c                      | 1 +
>   drivers/tty/vt/.gitignore              | 1 +
>   drivers/tty/vt/cp437.uni               | 1 +
>   drivers/tty/vt/defkeymap.c_shipped     | 1 +
>   drivers/tty/vt/defkeymap.map           | 1 +
>   7 files changed, 7 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
> index 127017cc41d9..02c5aff58a74 100644
> --- a/drivers/tty/serial/8250/8250_men_mcb.c
> +++ b/drivers/tty/serial/8250/8250_men_mcb.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   #include <linux/device.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
> index fe9170731c16..283493358a62 100644
> --- a/drivers/tty/serial/sn_console.c
> +++ b/drivers/tty/serial/sn_console.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * C-Brick Serial Port (and console) driver for SGI Altix machines.
>    *
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index 58b454c34560..d2a1e1228c82 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /* vcc.c: sun4v virtual channel concentrator
>    *
>    * Copyright (C) 2017 Oracle. All rights reserved.
> diff --git a/drivers/tty/vt/.gitignore b/drivers/tty/vt/.gitignore
> index 83683a2d8e6a..9b38b85f9d9a 100644
> --- a/drivers/tty/vt/.gitignore
> +++ b/drivers/tty/vt/.gitignore

.gitignore ?
  
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
>   consolemap_deftbl.c
>   defkeymap.c
> diff --git a/drivers/tty/vt/cp437.uni b/drivers/tty/vt/cp437.uni
> index bc6163484f62..a1991904c559 100644
> --- a/drivers/tty/vt/cp437.uni
> +++ b/drivers/tty/vt/cp437.uni
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Unicode table for IBM Codepage 437.  Note that there are many more
>   # substitutions that could be conceived (for example, thick-line
> diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
> index d2208dfe3f67..c7095fb7d2d1 100644
> --- a/drivers/tty/vt/defkeymap.c_shipped
> +++ b/drivers/tty/vt/defkeymap.c_shipped
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /* Do not edit this file! It was automatically generated by   */
>   /*    loadkeys --mktable defkeymap.map > defkeymap.c          */
>   
> diff --git a/drivers/tty/vt/defkeymap.map b/drivers/tty/vt/defkeymap.map
> index 50b30cace261..37f1ac6ddfb9 100644
> --- a/drivers/tty/vt/defkeymap.map
> +++ b/drivers/tty/vt/defkeymap.map
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   # Default kernel keymap. This uses 7 modifier combinations.
>   keymaps 0-2,4-5,8,12
>   # Change the above line into
