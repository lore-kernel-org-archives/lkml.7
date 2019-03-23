Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03681C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89472148D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCWAyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:54:01 -0400
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:38746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727363AbfCWAyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 20:54:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 99F69182CED28;
        Sat, 23 Mar 2019 00:53:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rest38_3fa6f6c5d115d
X-Filterd-Recvd-Size: 1774
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Mar 2019 00:53:57 +0000 (UTC)
Message-ID: <0ac4779574441c51c2a7074b4c003290b1876623.camel@perches.com>
Subject: Re: [PATCH v3] staging: ralink-gdma: Use u32 over uint32_t
From:   Joe Perches <joe@perches.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>,
        gregkh@linuxfoundation.org, christian@lkamp.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Mar 2019 17:53:55 -0700
In-Reply-To: <20190322171330.GA13658@bharath12345-Inspiron-5559>
References: <20190322171330.GA13658@bharath12345-Inspiron-5559>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 22:43 +0530, Bharath Vedartham wrote:
> This fixes the checkpatch.pl warning: "Prefer u32 over uint32_t"

Please run your proposed patches through checkpatch before
submitting them.

> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> Changes since v2
> 	- Improved changelog
> 	- Thanks for the good feedback. I am a beginner. I will learn
> 	  and grow. :)

More feedback for you.

> diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
[]
> @@ -157,14 +157,14 @@ static struct gdma_dma_desc *to_gdma_dma_desc(struct virt_dma_desc *vdesc)
>  	return container_of(vdesc, struct gdma_dma_desc, vdesc);
>  }
>  
> -static inline uint32_t gdma_dma_read(struct gdma_dma_dev *dma_dev,
> +static inline u32 gdma_dma_read(struct gdma_dma_dev *dma_dev,
>  				     unsigned int reg)

Please realign the line following your change.


