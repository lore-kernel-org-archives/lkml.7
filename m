Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5451C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D50B217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946699;
	bh=vl9AHUPrlEezbpc7ABS0EORbp4Ljc+bVvQy+IfKb4tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nXA7ST8Ba2rmXo7uAWFcAM4PiRS6DdvZNPxqjjYKrnFvSXL9lbvS/kOEe0Lf6damU
	 nMOfDLmwXaOmIGVsFTQ/4hDQhLUudVwKS+Cs1HB87sFDr2k4BCAuW86+71giezckw7
	 ZfyUeiG2Tfzusqt/8V+mCXTTB9JbM4J+R8Fz7w+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDKBiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfDKBiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:38:17 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C504C2075B;
        Thu, 11 Apr 2019 01:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554946697;
        bh=vl9AHUPrlEezbpc7ABS0EORbp4Ljc+bVvQy+IfKb4tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b05UL9x9w9P8fv+gUNiGtU52cjc6ZSRZ5er85hg+W/7oSkZHfmAHjLVlSMHFylRcA
         IQv7y5TXtXWP2bp5+M1+qc5H8k0sTwWzcqbXKgTN6vTLDILCQIzvQL1XwrJp+nDZrc
         xJwt5P6JcN9o14EpYpbVjKwjVB4vnrsHPhd/n/1s=
Date:   Thu, 11 Apr 2019 09:38:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v7 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Message-ID: <20190411013802.GF26817@dragon>
References: <20190312015019.30628-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312015019.30628-1-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:50:17AM +0800, Peng Ma wrote:
> Add lx2160a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I assume that the bindings will go via AHCI tree.  Otherwise, please let
me know.

Shawn
