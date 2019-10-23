Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50644CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C4D21929
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfJWRdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:33:23 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:37112 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfJWRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:33:22 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2019 13:33:21 EDT
Received: from darkstar.musicnaut.iki.fi (85-76-128-127-nat.elisa-mobile.fi [85.76.128.127])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 09E8E30184;
        Wed, 23 Oct 2019 20:26:10 +0300 (EEST)
Date:   Wed, 23 Oct 2019 20:26:10 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Remove typedef declaration
Message-ID: <20191023172610.GB18977@darkstar.musicnaut.iki.fi>
References: <20191008040943.9283-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008040943.9283-1-wambui.karugax@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 08, 2019 at 07:09:43AM +0300, Wambui Karuga wrote:
> Fixes checkpatch.pl warning: do not add new typedefs in
> drivers/staging/octeon/octeon-stubs.h:41
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index a4ac3bfb62a8..773591348ef4 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -38,7 +38,7 @@
>  #define CVMX_NPI_RSL_INT_BLOCKS		0
>  #define CVMX_POW_WQ_INT_PC		0
>  
> -typedef union {
> +union cvmx_pip_wqe_word2 {

The "real" definition is in arch/mips/include/asm/octeon/cvmx-wqe.h.

octeon-stubs.h is just a temporary hack to allow compile testing without
MIPS cross-compiler. Changing only the stubs file is not really an
improvement.

A.
