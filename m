Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95F7C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B513620862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfEOGKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:10:54 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49700 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfEOGKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:10:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,471,1549926000"; 
   d="scan'208";a="383210622"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 08:10:52 +0200
Date:   Wed, 15 May 2019 08:10:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [1/3] Coccinelle: pci_free_consistent: Use formatted strings
 directly in SmPL rules
In-Reply-To: <94e36a1e-0550-2782-aefc-4ac0b858c843@web.de>
Message-ID: <alpine.DEB.2.21.1905150810300.2591@hadrien>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de> <a91f9a9b-57be-59a8-1755-37936512ff20@web.de> <alpine.DEB.2.21.1905142148460.2612@hadrien> <94e36a1e-0550-2782-aefc-4ac0b858c843@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 May 2019, Markus Elfring wrote:

> > NACK.  If the code is going to change, I would rather it come closer to
> > staying within 80 characters.
>
> Do you really prefer then to deviate from the Linux coding style
> at such source code places?
>
> Would you like to split affected string literals over multiple lines?

No, I want msg = ... so that the string starts earlier and ends earlier.

julia
