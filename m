Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9793C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76272218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ys4nh+4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfDXNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:48:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42674 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfDXNs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WTG7g+Jt3yFxCSUC8zLxpm8mRBOIeofCyENLUH/LTQQ=; b=ys4nh+4k6f9GTyhTQaLgj32GCs
        Kop2OMre4V3jcn1hwHWgTEgPUmldhAR3P8HP8QZBvkgJ9DmtEWgqSYI0MU7BkXuMh437ARE2OHmmT
        wZ0cKOYWpLrhgs+YCf3nY9c93Ug6IOJVloHbBVcIjHOI6aSZNavT4G16Vek4/9VIuyYE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJIGc-00019Z-VB; Wed, 24 Apr 2019 15:48:54 +0200
Date:   Wed, 24 Apr 2019 15:48:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Weifeng Voon <weifeng.voon@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>
Subject: Re: [PATCH 0/7] net: stmmac: enable EHL SGMII
Message-ID: <20190424134854.GP28405@lunn.ch>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 01:17:14AM +0800, Weifeng Voon wrote:
> From: "Voon, Weifeng" <weifeng.voon@intel.com@intel.com>
> 
> This patch-set is to enable Ethernet controller (DW Ethernet QoS
> and DW Ethernet PCS) with SGMII interface in Elkhart Lake.

Can the hardware also do 1000BaseX?

    Andrew
