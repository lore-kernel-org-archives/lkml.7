Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A04CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467FA20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438346AbfJXIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:48:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbfJXIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:47:59 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iNYmk-0003b1-Qz; Thu, 24 Oct 2019 10:47:58 +0200
Message-ID: <1971768470f06ad1a051b44ed0041de6550964b8.camel@pengutronix.de>
Subject: Re: [PATCH] reset: fix kernel-doc warnings
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Date:   Thu, 24 Oct 2019 10:47:58 +0200
In-Reply-To: <6e166445-2a3d-dd4d-22ea-3ab77d3d3b11@infradead.org>
References: <6e166445-2a3d-dd4d-22ea-3ab77d3d3b11@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

thank you for the fixes.

On Tue, 2019-10-22 at 20:57 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings discovered in the reset controller API chapter.
> Fixes these warnings:
> 
> ./drivers/reset/core.c:86: warning: Excess function parameter 'flags' description in 'of_reset_simple_xlate'
> ./drivers/reset/core.c:830: warning: Incorrect use of kernel-doc format:  * of_reset_control_get_count - Count number of resets available with a device
> ./drivers/reset/core.c:838: warning: Function parameter or member 'node' not described in 'of_reset_control_get_count'
> ./include/linux/reset-controller.h:45: warning: Function parameter or member 'con_id' not described in 'reset_control_lookup'
> ./drivers/reset/core.c:86: warning: Excess function parameter 'flags' description in 'of_reset_simple_xlate'
> ./drivers/reset/core.c:830: warning: Incorrect use of kernel-doc format:  * of_reset_control_get_count - Count number of resets available with a device
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/core.c             |    4 ++--
>  include/linux/reset-controller.h |    4 ++--
[...]
> @@ -7,7 +7,7 @@
>  struct reset_controller_dev;
>  
>  /**
> - * struct reset_control_ops
> + * struct reset_control_ops - reset controller driver callbacks
>   *
>   * @reset: for self-deasserting resets, does all necessary
>   *         things to reset the device

This is all that remains when I rebase onto reset/fixes. Ok to apply
this and change the commit message to:

  reset: fix reset_control_ops kerneldoc comment

  Add a missing short description to the reset_control_ops
  documentation.

?

regards
Philipp

