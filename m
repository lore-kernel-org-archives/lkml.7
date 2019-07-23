Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4E7C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308B72238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563850020;
	bh=B02LoeW7Qa1LMBUvgIbOHbzfXb4394XW0uY/PVbA/yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0P3mXS6YBjxJa+Y4WXDNEfHI/qJdP86a97gUXD8ZCdzbxdgX6p437Ot69QK7iIuf1
	 Dx8ujGSEboBQVdY1mZgYwP6FJFavc2j7OgvboJ9wT5A7/8+x1T/yo3B/G2+mVl8j8V
	 Ex17mtZlAqqLeGWNKBAk1jTe6GjRDTreTD6LVf6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfGWCq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfGWCq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:46:59 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EE022387;
        Tue, 23 Jul 2019 02:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563850018;
        bh=B02LoeW7Qa1LMBUvgIbOHbzfXb4394XW0uY/PVbA/yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TX18Xtdt61xVRBwQownmhcOuxApSYnUdt7ZcSDqkTYuo0sJqMUAQiw3+fm5lhFZJs
         pmpGgEXcpRRm/tZVHEjJWV7PCItD5X8QNZAO/9HD+4lNYo7H5hD1aJWKt+PnGlVoqU
         9IcRDcmA6MvbQqDFC/nFHjTzkb+V2I99rnkSaClQ=
Date:   Tue, 23 Jul 2019 10:46:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     fugang.duan@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, festevam@gmail.com,
        daniel.baluta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 1/1] dt-bindings: serial: lpuart: add the clock
 requirement for imx8qxp
Message-ID: <20190723024627.GH3738@dragon>
References: <20190704134355.2402-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704134355.2402-1-fugang.duan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 09:43:55PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> Add the baud clock requirement for imx8qxp.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Applied, thanks.
