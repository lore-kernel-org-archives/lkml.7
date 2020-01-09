Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420A5C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143092067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578561733;
	bh=D5oJqGB3EncKK0zm585WP+XhVuvcw9UNSuzWlSgMLiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=19Hs7VU5gn/hYBN1+wEAoivPRqx5QFnr9/v+isN/pALcCZNQdZfvSnrzQvGV6v7ZE
	 7l/gfEV9UtuEOsqb9m2sVkXSXNsNROi1sjgSXjBs6j/YEJhEQANWfpLt94jsywTHOQ
	 v/y/0F/QcSxtklO3uIeR+BN+GhQVXh66avLpeCYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgAIJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbgAIJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:22:11 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD252073A;
        Thu,  9 Jan 2020 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578561730;
        bh=D5oJqGB3EncKK0zm585WP+XhVuvcw9UNSuzWlSgMLiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIdoq9/vqL8Km6jkYdJkB9QPYUt26txrO9XwhtIxC0/LSNj0aAeYlJaqUJvVZw9i6
         v4NIikuSGoDdTiyFleYyYLO5x9M8kuqtIDgrhOYmrmF9MDlyswObgkJ+wv8iii06vQ
         4dmOwfxT23JA+v/rssefMw5ntyhHWlWpuAsjSIZ0=
Date:   Thu, 9 Jan 2020 17:22:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [RESEND PATCH] firmware: imx: Allow IMX DSP to be selected as
 module
Message-ID: <20200109092202.GN4456@T480>
References: <20200104153940.10683-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104153940.10683-1-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 03:39:53PM +0000, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> IMX DSP is only needed by SOF or any other module that
> wants to communicate with the DSP. When SOF is build
> as a module IMX DSP is forced to be built inside the
> kernel image. This is not optimal, so allow IMX DSP
> to be built as a module.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
