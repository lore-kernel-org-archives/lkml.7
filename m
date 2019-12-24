Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B345C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB48206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XQ6sJups"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfLXMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:34:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39212 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfLXMev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Xf4ZjWR47/FaznsPBe3ZaxY7BCPMcl8JKCnAWmj4Kz0=; b=XQ6sJupsqGip/6MVI5GYvsPnd/
        iMJYNRaBEqW1xAEeiM4Eys3diBiP0HzhNzPWYJWUFSy6a5G5LHwnNJjbzfaROZnsDupUAifcSQE2e
        vHAQU/XKStSBkYzVH9XIx5CXUockaqjEzocGPU4lmModmwEfJtzk9mg2oJI266j7ufpo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ijjOX-0003E7-Bi; Tue, 24 Dec 2019 13:34:37 +0100
Date:   Tue, 24 Dec 2019 13:34:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, linux@rempel-privat.de, marek.behun@nic.cz,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: qca: ar9331: drop pointless static
 qualifier in ar9331_sw_mbus_init
Message-ID: <20191224123437.GF3395@lunn.ch>
References: <20191224112515.GE3395@lunn.ch>
 <20191224115812.166927-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224115812.166927-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 07:58:12PM +0800, Mao Wenan wrote:
> There is no need to set variable 'mbus' static
> since new value always be assigned before use it.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
