Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC2DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EF5217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554966285;
	bh=VnHbqL8tBe1hnsKz1vf72+xzea7aa/6TEYo7W9k8HMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fd6BiNs56+NOsbi0RTu4F9f0vvTC7m3ItLTNYt8Inu92SUb51JhnhQdUyPMMp82G1
	 cneZ5VCPKOqbWmf/bEUcllVsauV+cFjWyf95iOWLo6c2I+GRQCVCOmzuxWUaq6xm1n
	 MYhCHUsdC2AzfO8rrq5eT7qcqpRJlu4nLBhJk+fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDKHEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKHEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:04:43 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CA42082E;
        Thu, 11 Apr 2019 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554966283;
        bh=VnHbqL8tBe1hnsKz1vf72+xzea7aa/6TEYo7W9k8HMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poMspEFeI+b4w/8AqKJc+CbtwMF+DpsfcbMjTw++dgETSXYw1ZaesPdt59IdhgtG3
         eNE/QU5qnFBxm5SDiMlaVqTnynZDPnTCrrElDpUYlxrqsqDjW3IgfFd2p1es/dLkSc
         4yi6PYn+4s/K6adip1OyCZQDnn4RQycdVy16Pcs4=
Date:   Thu, 11 Apr 2019 15:04:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Olof Johansson <olof@lixom.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] arm64: defconfig: Enable RTC_DRV_SNVS
Message-ID: <20190411070422.GE26817@dragon>
References: <1554749572-5090-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554749572-5090-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 06:53:03PM +0000, Abel Vesa wrote:
> i.MX8MQ needs it for RTC support.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
