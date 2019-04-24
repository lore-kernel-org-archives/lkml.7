Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9AAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6BB21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="souTxhFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfDXSgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:36:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:29491 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388083AbfDXSgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:36:37 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 14:36:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1556130996;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ztRZ8SZCmF9XNLy1UHtfoSMUUhjMciaT/ucfRjdlQGc=;
        b=souTxhFTGM/nRkA+3xbl+lV57YwlZe8ik5mwA1HjMveaSfSkh7jR4B1usNbAvL7sQ+
        mILnkHolPtjFEn+AXJzdU88iWeQ/U9caM5WlPgB86GNAtHfQBx7ur2e7kn3rEc0VrypH
        KJ3P2Lf0UY73OW1tUEkQpUwXD3WMx9o/kWdo00p6GfsCv3CQy/J4IR/xcC2m3ZHD491P
        tzMzGY8o1Lp2vz28NvONhzGu5K/hCRxF9GBSE+kUqlR9blpjyEq7Os+XdEHltvm2NwU5
        iiK3aat8KFdv/5iAeHzOumpN3OYvZoX7ZPtNRILdwZWhhxsiIVdpmDcNG8FR+dl9Yma8
        aQpQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9x2cdNU9qrVA3/I2bquZ6"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id R0373fv3OIUZ6mS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 24 Apr 2019 20:30:35 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Kalyani Akula <kalyania@xilinx.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Date:   Wed, 24 Apr 2019 20:30:35 +0200
Message-ID: <18759853.IUaQuE38eh@tauon.chronox.de>
In-Reply-To: <BN7PR02MB5124AC0C75B15E5FB66DF2B6AF220@BN7PR02MB5124.namprd02.prod.outlook.com>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com> <4735882.YQOrfzxm5S@tauon.chronox.de> <BN7PR02MB5124AC0C75B15E5FB66DF2B6AF220@BN7PR02MB5124.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 22. April 2019, 11:17:55 CEST schrieb Kalyani Akula:

Hi Kalyani,

> > Besides, seem to be more a key handling issue. Wouldn't it make sense to
> > rather have such issue solved with key rings than in the kernel crypto
> > API?
> 
> [kalyani] Can you please elaborate on this further ?

The kernel has a keyring support in security/keys which has a user space 
interface with keyutils. That interface is commonly used for any sort of key 
manipulation.

Ciao
Stephan


