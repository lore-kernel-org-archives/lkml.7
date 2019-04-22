Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00220859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555965604;
	bh=JpiPp5mGeKnp5za9JQLvYUrCfkc++jVH6nujgcoY3SU=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=mNh7U7o+bjudzYzKoTs6qWdSHN9L51ZowbDAp0Ca2aitse7UY8DH48jl89EHWLc7d
	 j/JHuLPdgd+TwV4ZGEEOsexp2sMrZYSMmm7iJ7mXZHVW7QVuEeMeE4EiFnVzorIpqH
	 vZoOzvYT122IxBiJ0eifPNpU4Y3R5u8tH24mTIgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfDVUkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbfDVUkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:40:02 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33A920B1F;
        Mon, 22 Apr 2019 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555965602;
        bh=JpiPp5mGeKnp5za9JQLvYUrCfkc++jVH6nujgcoY3SU=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=jonBitbTb1pnV5NhgoT5t8fzkuXdFrS6tQaWkBV0tyXrWbdW2DQg9CX0LYIQhAVMr
         cBPVwlNeY2G+e9AI9FszWKJSzpje7hMozZhkerj806X22tuAcywl0QCsMrfRHq5S89
         dvhky+5KL6un+huuMr0mQKo8LLbGid8y65dKNPsA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1555921081.git.leonard.crestez@nxp.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 0/3] scripts/gdb: Initial clk support
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Message-ID: <155596560113.15276.14734609686750348768@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 22 Apr 2019 13:40:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-04-22 01:26:56)
> Tested with openocd on imx but should be useful everywhere. It is common
> for clk issues to lockup the system and make /sys inaccesible.

Thanks for working on this. I had this on my backlogged todo list. One
minor comment on the clk summary patch but otherwise it looks OK to me
and I'm happy to have Andrew shepherd the patches through.

>=20
> Not sure where to send this; there doesn't appear to be any list more
> specific than LKML.

Please Cc linux-clk on clk related patches.

