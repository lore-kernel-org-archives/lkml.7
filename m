Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F4DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DB520878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556223861;
	bh=8XA1nfoqYhO0u7ye1dZW2W5xpDUxjMHSAKRZ3xVyd04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0BMARJoGOM6PMXOsp2h7CvAh2hMeWMTZYulZg7HBQrpwaBgbl/FVVNYkRpe6Wtl1/
	 wy9369yVLbubFB7ggppJKvLkXvBhl+oveOQgM+Z6ohC5Bn22m82jBXfuT4GImvaQnr
	 KpCUTL77/5XLHwu5UohCvwulOhhSYq8dQ4UTdd8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfDYUYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfDYUYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:24:19 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11923206A3;
        Thu, 25 Apr 2019 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556223859;
        bh=8XA1nfoqYhO0u7ye1dZW2W5xpDUxjMHSAKRZ3xVyd04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2FzPdSjGaudC7mZzHVH3kcapvQLa8L/AZHz8gjAmJW9pWyfBBhgr/37/L2rmtR8Or
         Qy1+Udd1uXDQoQzOcd6DddueOqZnq/a5RJXYNP4KWuR5bM/5ZSV0+vEE6poUH5dSo0
         9cJc3PVf2URtCyZ/LlclQXHIjleUzG+EjHIbMsjc=
Date:   Thu, 25 Apr 2019 22:24:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V2 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Message-ID: <20190425202417.GA22307@kroah.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
 <1554804414-206099-2-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554804414-206099-2-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:06:43AM +0100, Dragan Cvetic wrote:
> Add the Soft Decision Forward Error Correction (SDFEC) Engine
> bindings which is available for the Zynq UltraScale+ RFSoC
> FPGA's.
> 
> Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> ---
>  .../devicetree/bindings/misc/xlnx,sd-fec.txt       | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt

Don't you have to send new bindings to the DT maintainers?

thanks,

greg k-h
