Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB871ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B087B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570784537;
	bh=FvTRvAG+rf7yebIY8LceMF0kGTjjLrQsCByAbMcG7ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1qp8q44VOaNfnhWTOd3IOGFDvbvjoZ68GYuksRwgGS9PJ7t7I9LEBe6r1f6JIFuvE
	 elsT5o6Zoc6S3C1+QR9ZcmNo7SJvZnaD4EVBoSgg8U9vmRFH6W/c2fRCXcD2OJYn+Z
	 IkMXRDmIj4A6WxRyRSFUI/aeKacGpBSJjPFHp/xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfJKJCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfJKJCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:02:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F6321D6C;
        Fri, 11 Oct 2019 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570784535;
        bh=FvTRvAG+rf7yebIY8LceMF0kGTjjLrQsCByAbMcG7ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/Z3zLqCx7YOJoJckdKqYeaP6ky3TvNHlCoFKSVLmBM7DTomsg/kAAe3XlsiMK5Tl
         Pz1MaeZ3dBEwdjTTY8qVT0cePbxx7OdrYIazkw1fQsM0n83kHl2KqaYcRF4eMce1g/
         JuGUw6LadSfnZYDOi6aCkxF/Gk5mwnXjN8Mzukao=
Date:   Fri, 11 Oct 2019 11:02:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] staging: octeon: remove typedef declaration for
 cvmx_helper_link_info_t
Message-ID: <20191011090213.GB1076760@kroah.com>
References: <cover.1570773209.git.wambui.karugax@gmail.com>
 <78e2c3a4089261e416e9b890cdf81ef029966b75.1570773209.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e2c3a4089261e416e9b890cdf81ef029966b75.1570773209.git.wambui.karugax@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:02:39AM +0300, Wambui Karuga wrote:
> -typedef union {
> +union cvmx_helper_link_info_t {

I agree with Julia, all of the "_t" needs to be dropped as that is
pointless.  It's a holdover from the original name where "_t" was trying
to say that this is a typedef.  Gotta love abuse of hungarian notation
:(

Please redo this patch series and resend.

thanks,

greg k-h
