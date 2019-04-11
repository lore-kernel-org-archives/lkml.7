Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE756C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B722217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946506;
	bh=pP0adzQJYEmmbL9Fik7yUg0fBVMfa0GZ/DCt5crizMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gkx5uj5K6LuGzWZTC344yywr+qh5MVvN1zzImN31CEeO1XizRMiWf9wBRkfK19cFo
	 NNUlU6z5yGIko2K7pa4FlxltvHrqqqBQN9BiD6RZTczK0s5WdqyQubY5NgpIvZeq51
	 xUMne7ult+YnucmJHX6UknpYV+ysrQrhUlIsKUO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDKBfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKBfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:35:05 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E7120674;
        Thu, 11 Apr 2019 01:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554946504;
        bh=pP0adzQJYEmmbL9Fik7yUg0fBVMfa0GZ/DCt5crizMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMMkQid+lF4E6U1nqhSIOy7gXeSX2NVsfqUkh+tWjRd33u6AiX2c9L44LGsfwVFcZ
         800cPiZpYLQRv7Cq62PKMnq2MYp/D/FYN515oXuG80hT6GyD3lFPQ8Ki7zpPqZQwoh
         qxpPHqJ8ve6i7ho9BvxZ32CaswVB+DA3tFrRlVO0=
Date:   Thu, 11 Apr 2019 09:34:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v7 2/3] arm64: dts: lx2160a: add sata node support
Message-ID: <20190411013448.GC26817@dragon>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312015019.30628-2-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:50:18AM +0800, Peng Ma wrote:
> Add SATA device nodes for fsl-lx2160a and enable support
> for QDS and RDB boards.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
