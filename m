Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325D82087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WL9Hd2LL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfCNHBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:01:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56301 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfCNHBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:01:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c2df480a
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 06:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=1ntL2n5GEiCS0SNcUaaDGUqhM58=; b=WL9Hd2
        LLZX6fdFg2e8v99R7CdhXC7VHevY3VoKgpO412t/bLZJxTApq0j76BfqBI/RAqJ4
        NoQ9RDXTy1AahPZHwiYX/PvgiGai6pDPhWkdqJ5yEqkyXXLyIZkbBpQHz6VAO24h
        4FvJSFSwmRkPHGN0GP02ytlzmywVWvTYf8zoU9Zr+BsUGSrQddbjTYx/IF9AqleW
        BT5k1AbhJOrSNPd++Z4Ns8togn1YHdIiQqc+h+w0wZiKQIF/gyc7nWIrT12rDFsP
        KArjjRxx2DQLDnmYnJyEtudfRPULCuT/br7fkTNnaZREHSvnvCzp6gAftXEMjCHT
        JxTQZqjjLmsRHj/w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ea4fbd6a (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 06:40:37 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id c18so4137666otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:01:19 -0700 (PDT)
X-Gm-Message-State: APjAAAUGgBGgXzXSzQcz3nKPXbvdkWEj+V2FWwwOhEyeQi0taJeIo5uz
        v3kACq5yBhQS3tJLQyT5kN4EjsGQxSVHgjHRqLE=
X-Google-Smtp-Source: APXvYqxH6H+49MZXaY5VM7EOIdthQm8triTY5ARxkGAF7lHFHN1wy79oBQTWp5RCjZlnYsq8x4A21LV6t+cexyIXD/c=
X-Received: by 2002:a9d:7645:: with SMTP id o5mr31858423otl.225.1552546878335;
 Thu, 14 Mar 2019 00:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190114201911.13725-1-malat@debian.org> <20190313211230.17527-1-malat@debian.org>
In-Reply-To: <20190313211230.17527-1-malat@debian.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 14 Mar 2019 01:01:07 -0600
X-Gmail-Original-Message-ID: <CAHmME9rA+eM0PcsbZtFgBYObxaBOQvWt7EcGYE-yM+O2aHd6uQ@mail.gmail.com>
Message-ID: <CAHmME9rA+eM0PcsbZtFgBYObxaBOQvWt7EcGYE-yM+O2aHd6uQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/siphash.c: annotate implicit fall throughs
To:     Mathieu Malaterre <malat@debian.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for getting this v3 into shape.

On Wed, Mar 13, 2019 at 3:12 PM Mathieu Malaterre <malat@debian.org> wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
>
> This commit remove the following warnings:
>
>   lib/siphash.c:71:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:72:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:73:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:75:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:108:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:109:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:110:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:112:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:434:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   lib/siphash.c:462:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Move the break statement onto the next line to match the fall-through
> comment pattern. Also move the trailing statement onto the next line to
> pass checkpatch verification.
>
> Acked-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v3: move break statements onto next line and please checkpatch
> v2: some cases were missed in v1, update missing ones
>
>  lib/siphash.c | 76 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 20 deletions(-)
>
> diff --git a/lib/siphash.c b/lib/siphash.c
> index 3ae58b4edad6..f459e0f4a14e 100644
> --- a/lib/siphash.c
> +++ b/lib/siphash.c
> @@ -68,13 +68,26 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
>                                                   bytemask_from_count(left)));
>  #else
>         switch (left) {
> -       case 7: b |= ((u64)end[6]) << 48;
> -       case 6: b |= ((u64)end[5]) << 40;
> -       case 5: b |= ((u64)end[4]) << 32;
> -       case 4: b |= le32_to_cpup(data); break;
> -       case 3: b |= ((u64)end[2]) << 16;
> -       case 2: b |= le16_to_cpup(data); break;
> -       case 1: b |= end[0];
> +       case 7:
> +               b |= ((u64)end[6]) << 48;
> +               /* fall through */
> +       case 6:
> +               b |= ((u64)end[5]) << 40;
> +               /* fall through */
> +       case 5:
> +               b |= ((u64)end[4]) << 32;
> +               /* fall through */
> +       case 4:
> +               b |= le32_to_cpup(data);
> +               break;
> +       case 3:
> +               b |= ((u64)end[2]) << 16;
> +               /* fall through */
> +       case 2:
> +               b |= le16_to_cpup(data);
> +               break;
> +       case 1:
> +               b |= end[0];
>         }
>  #endif
>         POSTAMBLE
> @@ -101,13 +114,26 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
>                                                   bytemask_from_count(left)));
>  #else
>         switch (left) {
> -       case 7: b |= ((u64)end[6]) << 48;
> -       case 6: b |= ((u64)end[5]) << 40;
> -       case 5: b |= ((u64)end[4]) << 32;
> -       case 4: b |= get_unaligned_le32(end); break;
> -       case 3: b |= ((u64)end[2]) << 16;
> -       case 2: b |= get_unaligned_le16(end); break;
> -       case 1: b |= end[0];
> +       case 7:
> +               b |= ((u64)end[6]) << 48;
> +               /* fall through */
> +       case 6:
> +               b |= ((u64)end[5]) << 40;
> +               /* fall through */
> +       case 5:
> +               b |= ((u64)end[4]) << 32;
> +               /* fall through */
> +       case 4:
> +               b |= get_unaligned_le32(end);
> +               break;
> +       case 3:
> +               b |= ((u64)end[2]) << 16;
> +               /* fall through */
> +       case 2:
> +               b |= get_unaligned_le16(end);
> +               break;
> +       case 1:
> +               b |= end[0];
>         }
>  #endif
>         POSTAMBLE
> @@ -431,9 +457,14 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
>                 v0 ^= m;
>         }
>         switch (left) {
> -       case 3: b |= ((u32)end[2]) << 16;
> -       case 2: b |= le16_to_cpup(data); break;
> -       case 1: b |= end[0];
> +       case 3:
> +               b |= ((u32)end[2]) << 16;
> +               /* fall through */
> +       case 2:
> +               b |= le16_to_cpup(data);
> +               break;
> +       case 1:
> +               b |= end[0];
>         }
>         HPOSTAMBLE
>  }
> @@ -454,9 +485,14 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
>                 v0 ^= m;
>         }
>         switch (left) {
> -       case 3: b |= ((u32)end[2]) << 16;
> -       case 2: b |= get_unaligned_le16(end); break;
> -       case 1: b |= end[0];
> +       case 3:
> +               b |= ((u32)end[2]) << 16;
> +               /* fall through */
> +       case 2:
> +               b |= get_unaligned_le16(end);
> +               break;
> +       case 1:
> +               b |= end[0];
>         }
>         HPOSTAMBLE
>  }
> --
> 2.20.1

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Greg - would you take this through your tree?

Jason
