Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF799C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC48520656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfF1ETo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:19:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55958 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF1ETo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:19:44 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hgiMO-0004wu-AY; Fri, 28 Jun 2019 12:19:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hgiMN-00026A-6w; Fri, 28 Jun 2019 12:19:39 +0800
Date:   Fri, 28 Jun 2019 12:19:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Keerthy <j-keerthy@ti.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, t-kristo@ti.com, nm@ti.com
Subject: Re: [PATCH 00/10] crypto: k3: Add sa2ul driver
Message-ID: <20190628041939.7yduk77x62twath6@gondor.apana.org.au>
References: <20190618120843.18777-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618120843.18777-1-j-keerthy@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 05:38:33PM +0530, Keerthy wrote:
> The series adds Crypto hardware accelerator support for SA2UL.
> SA2UL stands for security accelerator ultra lite.

Please cc linux-crypto@vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
