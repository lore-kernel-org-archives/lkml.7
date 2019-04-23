Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB699C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE1A21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XfaBAMF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfDWSx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:53:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41817 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfDWSx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CnViQ3pzEzkWqDMWm+SyFKTLebDbvxQpQmxmU/b7Fp0=; b=XfaBAMF08/NlaGBo1EzBjyyOBm
        MJgHchRZluWMVGbAyrNr6a3p/kZxzJidGMtsAp6cAK2TgyGW+ZAZLhAKvAWmlxIc5woyQio4jf0MF
        LwrMiP5mNW5VA+SsLCpTZDk6uw2FRCrB4qfDRoTf0y3w3rmTEqIDu4RxPIWOYeuAH3J8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJ0Xi-0001gI-Hz; Tue, 23 Apr 2019 20:53:22 +0200
Date:   Tue, 23 Apr 2019 20:53:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 16/19] net: ethernet: ti: cpsw: move common hw
 init code in separate func
Message-ID: <20190423185322.GI28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:09:07PM +0300, Grygorii Strashko wrote:
> +	ret = cpsw_init_common(cpsw, ss_regs, ale_ageout,
> +			       (u32 __force)ss_res->start + CPSW2_BD_OFFSET,
> +			       descs_pool_size);

Hi Grygorii

Could you put it onto your TODO list to remove this nasty casting.

Thanks

      Andrew
