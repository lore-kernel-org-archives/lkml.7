Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C641C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2346A24679
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575989695;
	bh=a5BHMVgtPZwxKGzK9Kll2jVkr61mgNawIAex25lud2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HaoNEaZQ6ZpBFVQnyOUklAfJIH99xEmwengp5KKm7VCyQ0LostixWgcYk7L2AJ0Iw
	 0C90EDKeLR8jLOhTy1jtDLwhaVRLORvR5FjQmXR/jo4iT16Cptuq/IlmEszGCmGfAj
	 XxAWG+8MUaQOfef6PUD1xBpwcZ13qrT4gsjZLNHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLJOyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfLJOyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECC32077B;
        Tue, 10 Dec 2019 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575989643;
        bh=a5BHMVgtPZwxKGzK9Kll2jVkr61mgNawIAex25lud2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4TFMfvd0F/X1H5S/tJzVb+P1hLYpiTHlMSKDRBBCcXBeVOGGqNLgg+mV3tvtag5l
         N8ueB474Z+e04eueZAbwwsInGwdoaAW9Yur5XdhWYcT1M6azCT97/yEpsEp+uNF1ew
         Gx6y0ozwRqOc9p4OH7WnrTiprj+0O5cEjdC1Bhxs=
Date:   Tue, 10 Dec 2019 15:54:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] tty: serial: samsung: allow driver to be built by
 anyone
Message-ID: <20191210145400.GA4012141@kroah.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210144656.GA11222@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210144656.GA11222@pi3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:46:56PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 10, 2019 at 03:36:57PM +0100, Greg Kroah-Hartman wrote:
> > There is no need to tie this driver to only the OMAP platform,
> 
> s/OMAP/Exynos/

Oops, sorry, was thinking of another driver :)

> Beside that:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the review, will fix up the text in here when I apply this.

greg k-h
