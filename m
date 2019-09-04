Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1D9C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10E320882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5q7arHBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbfIDQqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:46:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54828 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731564AbfIDQqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=X1lVgDd+Kyczn3+9J0jI4kK8khC/plLZqB01rSuWgoM=; b=5q7arHBSkkDtxNu2cycz6N09DN
        0esoGimpmOQ5FluStqrIalHacCue+952F7efwjRu0GYY7MnpymjGCR84OebQv8bMMCxXcr3AswDEO
        KC7G+Sb95JyD9EhG03Gg+h9kEYloG3hVDRuHBNjouchcmd3b3a4XnkJNw4965d/wCV74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i5YQc-0004WY-Py; Wed, 04 Sep 2019 18:46:42 +0200
Date:   Wed, 4 Sep 2019 18:46:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v2 1/2] include: mdio: Add driver data helpers
Message-ID: <20190904164642.GA17114@lunn.ch>
References: <1567605621-6818-1-git-send-email-harini.katakam@xilinx.com>
 <1567605621-6818-2-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567605621-6818-2-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 07:30:20PM +0530, Harini Katakam wrote:
> Add set/get drv_data helpers for mdio device.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
