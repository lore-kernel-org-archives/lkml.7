Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157BFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86D21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571971711;
	bh=YjIrWYi+vq47WqR5MSAO03FVUzkLa1Xz/MTdPOUAoMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YuMkga8eFqXT/cZwnmkhXmR7gL4xZ1wR7CKIcFY3Qw4Q0tsWOV23CpDSt1CKPLMHj
	 TDb8hTFhGjl1SHttFzpM93a3qErqyMPtDhdeMm9twBJmYqmzhRt7Y15tZS87JHZqqL
	 bTRWmyVCqrbxJqOBoTPbqGgnWRgb1bid4fuGxj8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbfJYCsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfJYCsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:48:30 -0400
Received: from localhost (unknown [38.98.37.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FF521D71;
        Fri, 25 Oct 2019 02:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571971709;
        bh=YjIrWYi+vq47WqR5MSAO03FVUzkLa1Xz/MTdPOUAoMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDzhOoB0Qe5Ftev/sS98DxeVb7fInMY1jJghpagE8EWRAVSaRFhU74QDCu7wnn66+
         M2Wut3on9i4CjvY6rEFQ4+F0xdXE+FxPKpAuHOD9miNQfXFMbMgsI9j1h+CvgwY2mE
         xxrpQ6ZvN3zg1cNmlE2oJdugoCTkIYYRCdh+Riqg=
Date:   Thu, 24 Oct 2019 22:42:05 -0400
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Subject: Re: [PATCH] staging: vc04_services: add space to fix check warning
Message-ID: <20191025024205.GA331827@kroah.com>
References: <20191015230922.11261-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015230922.11261-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 12:09:22AM +0100, Jules Irenge wrote:
> Add space betwen operator to fix check warning.
> Issue detected by checkpatch tool.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi_cfg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
> index dbb6a5f07a79..192c287503a5 100644
> --- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
> +++ b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
> @@ -163,9 +163,9 @@
>   * by suspending parsing as the comment above says, but we don't.
>   * This sweeps the issue under the carpet.
>   */
> -#if VCHI_RX_MSG_QUEUE_SIZE < (VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS
> +#if VCHI_RX_MSG_QUEUE_SIZE < (VCHI_MAX_MSG_SIZE / 16 + 1) * VCHI_NUM_READ_SLOTS
>  #  undef VCHI_RX_MSG_QUEUE_SIZE
> -#  define VCHI_RX_MSG_QUEUE_SIZE ((VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS)
> +#  define VCHI_RX_MSG_QUEUE_SIZE ((VCHI_MAX_MSG_SIZE / 16 + 1) * VCHI_NUM_READ_SLOTS)
>  #endif
>  
>  /* How many bulk transmits can we have pending. Once exhausted,
> -- 
> 2.21.0

Path does not apply to my tree at all :(
