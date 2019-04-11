Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42CCC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1142075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946536;
	bh=c4K8njIMFdnvbVZyGm+0SUf0XrmcLsRoTWxaADKng9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FfYCdk0WqAHCsZNGu/LcTXDo9QDf0/65+zVbKZTreN728wnG3NJJ8iyYA3SJ6pdSR
	 GQGCWFpIrACkYTcU9cA7w0Kx4lmccjLyBXbQhqy5KJUmrNIxBZOrKu2hxui73OcD5p
	 Nm7sKJpiq4oANoulOQAT8fKnx1k9jFBiVk02amYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKBfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKBfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:35:34 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905F720674;
        Thu, 11 Apr 2019 01:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554946533;
        bh=c4K8njIMFdnvbVZyGm+0SUf0XrmcLsRoTWxaADKng9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dkhon4vIh8wN4h63Y9trwAs90MxyORGU7DHvJklF9zvLXRxsJp9o6LyjDjyo2VN7H
         stGpWOMeTZuNWjyMyImlHDzeAUPYio3RG3LXqz+oiANgLcT+YUc8YnGkG4VDZrFu9v
         8B2ltg91dbkk6fKBqoRarTFMt3POV2SZeR9qaW5A=
Date:   Thu, 11 Apr 2019 09:35:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, andy.tang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arm64: dts: ls1028a: Corrected the SATA ecc address.
Message-ID: <20190411013519.GD26817@dragon>
References: <20190311072014.36565-1-peng.ma@nxp.com>
 <20190311072014.36565-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311072014.36565-2-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:20:13PM +0800, Peng Ma wrote:
> Ls1028a SATA ecc address with more than 32 bit, so we should corrrect the
> address.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
