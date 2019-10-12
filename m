Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FCBC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF362089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfJLFll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:41:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:43267 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbfJLFll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:41:41 -0400
X-IronPort-AV: E=Sophos;i="5.67,286,1566856800"; 
   d="scan'208";a="405849016"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2019 07:41:38 +0200
Date:   Sat, 12 Oct 2019 07:41:37 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
cc:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: sm750fb: align arguments
 with open parenthesis
In-Reply-To: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
Message-ID: <alpine.DEB.2.21.1910120738540.2637@hadrien>
References: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Oct 2019, Gabriela Bittencourt wrote:

> Cleans up checks of "Alignment should match open parenthesis" in tree sm750fb
>
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_display.c |  2 +-
>  drivers/staging/sm750fb/sm750_accel.c    |  2 +-
>  drivers/staging/sm750fb/sm750_accel.h    |  8 ++++----
>  drivers/staging/sm750fb/sm750_cursor.h   | 10 +++++-----
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
> index 887ea8aef43f..8be98a1058d6 100644
> --- a/drivers/staging/sm750fb/ddk750_display.c
> +++ b/drivers/staging/sm750fb/ddk750_display.c
> @@ -148,7 +148,7 @@ void ddk750_set_logical_disp_out(enum disp_output output)
>  	if (output & PNL_SEQ_USAGE) {
>  		/* set  panel sequence */
>  		sw_panel_power_sequence((output & PNL_SEQ_MASK) >> PNL_SEQ_OFFSET,
> -		4);
> +					4);
>  	}
>
>  	if (output & DAC_USAGE)
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index dbcbbd1055da..1a9555bb9edd 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -289,7 +289,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
>  }
>
>  int sm750_hw_imageblit(struct lynx_accel *accel,
> -		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
> +		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
>  		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
>  		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
>  		 u32 dBase,    /* Address of destination: offset in frame buffer */

It is strange that the change is only does for the firsr parameter, and
not for all of them.

The kernel also uses a doc format for describing function patameters in a
single comment before the function.  Look around in other files to see the
format.  That would look much nicer than these comments going over 80
columns.


> diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
> index c4f42002a50f..8fb79b09fdd0 100644
> --- a/drivers/staging/sm750fb/sm750_accel.h
> +++ b/drivers/staging/sm750fb/sm750_accel.h
> @@ -190,9 +190,9 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
>  void sm750_hw_de_init(struct lynx_accel *accel);
>
>  int sm750_hw_fillrect(struct lynx_accel *accel,
> -				u32 base, u32 pitch, u32 Bpp,
> -				u32 x, u32 y, u32 width, u32 height,
> -				u32 color, u32 rop);
> +		      u32 base, u32 pitch, u32 Bpp,
> +		      u32 x, u32 y, u32 width, u32 height,
> +		      u32 color, u32 rop);
>
>  int sm750_hw_copyarea(
>  struct lynx_accel *accel,
> @@ -210,7 +210,7 @@ unsigned int height, /* width and height of rectangle in pixel value */
>  unsigned int rop2);
>
>  int sm750_hw_imageblit(struct lynx_accel *accel,
> -		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
> +		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
>  		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
>  		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
>  		 u32 dBase,    /* Address of destination: offset in frame buffer */

Same here.

> diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
> index 16ac07eb58d6..039ebfdf0bd9 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.h
> +++ b/drivers/staging/sm750fb/sm750_cursor.h
> @@ -6,13 +6,13 @@
>  void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
>  void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
>  void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
> -						int w, int h);
> +			     int w, int h);
>  void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
> -						int x, int y);
> +			    int x, int y);

Perhaps these could just be all on one line?

julia

>  void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
> -						u32 fg, u32 bg);
> +			      u32 fg, u32 bg);
>  void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
> -			u16 rop, const u8 *data, const u8 *mask);
> +			     u16 rop, const u8 *data, const u8 *mask);
>  void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
> -			u16 rop, const u8 *data, const u8 *mask);
> +			      u16 rop, const u8 *data, const u8 *mask);
>  #endif
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191012011956.9452-1-gabrielabittencourt00%40gmail.com.
>
