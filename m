Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C92FC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1263A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946625;
	bh=yFDW2/DmQjVShqMhsTtBPPIRt1BUL9UKemGdoBnpEu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oxK+9+EpJ+Vw5snawRfa8TB4XBA3BzTL5U+fVLKYIiWn2jYZoqfA+eR+e0QbGRGbp
	 GOyOMZFVYk841F23+Q6l42qIdlLauA9s+YczegH+HCmvhPJObXXz5A9qj4/5SEcVz6
	 P86DHxRqyVr4kRyv5pcUXFaQDuLgPlBoemjJWKAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfDKBhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDKBhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:37:02 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EBA62075B;
        Thu, 11 Apr 2019 01:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554946621;
        bh=yFDW2/DmQjVShqMhsTtBPPIRt1BUL9UKemGdoBnpEu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQP2w12ST/m2m22HuiNYftfd0qHkXq6ZHwnHMI1Sw7vhlD2ENbmGLLwXowiGN+l7u
         FLjKtDWpm+soy1YX2YneUYjPsBrzlB19kLKw2n+99LodllF84vUefdOiaRs/aCgNh0
         zEJnV3TN976sEHZbVFuGZfHgu8XK5ZHbqxVZ1W8M=
Date:   Thu, 11 Apr 2019 09:36:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, andy.tang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: ahci-fsl-qoriq: add ls1028a chip name
 to the list
Message-ID: <20190411013647.GE26817@dragon>
References: <20190311072014.36565-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311072014.36565-1-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:20:12PM +0800, Peng Ma wrote:
> Add ls1028a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

I assume that the bindings will be picked up by Axboe.  Otherwise,
please let me know.

Shawn
