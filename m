Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A63A2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553086755;
	bh=OmK5esA8/N/U5kvPiryRjb6HgXd7Wa2gMH0GXJjLBqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S92ifGa9XHNr7MRuXxdtQ95hu1Qw5Fqjk2GijHBVDGPYNOkHXlizGfgyUTQXUOXEe
	 1OjT3Ek+S3Tufd6b/PlOJfRvswLpTqEZFaXo+DSBaXHI4BgltyNXjTSjIO4pEls4jO
	 O66kR86x3cCKHiwOMBL+u1h6HqtthPj1Wm3qchZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfCTM7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCTM7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:59:13 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766712146E;
        Wed, 20 Mar 2019 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553086753;
        bh=OmK5esA8/N/U5kvPiryRjb6HgXd7Wa2gMH0GXJjLBqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbnH1uAD46sBLU3ItYKcEQe411SEUMQSbD1tO3QJX1Im4Pv3qt/ap/FYarCAalj3w
         FgxmBNhsOHcSv3tXs7saurTVxQPWP/to5SoW/j3/+yOZE5FQHGzOY6c0zwxJ6YnlFa
         aoQe8W5i7n0Vd1tKg9+Y+A9+gtwfNwtyuLOKFkYQ=
Date:   Wed, 20 Mar 2019 20:58:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com
Subject: Re: [PATCH] arm64: dts: freescale: Enable PCI-E controller for
 Oxalis board
Message-ID: <20190320125852.GQ4980@dragon>
References: <20190309023209.6741-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309023209.6741-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 08:02:09AM +0530, Manivannan Sadhasivam wrote:
> Enable PCI-E controller for Oxalis board based on NXP/Freescale LS1012a
> SoC available as the Mini PCI-E connector on the bottom side.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied, thanks.
