Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6712C48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB04A208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561503355;
	bh=SYMcIFxgtO+dsktSi7jnPUjz1SSVD8CyNCsa+fKpnM0=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=lADF/3bNjQhn6yvzi5kGXjtFGFQM5//BKGYJ1c9o+moUzsRwmLkbUAmP9yKIiJJ2R
	 lOu//bUm4oRdmnoFEShW8R2AS+f2LYg8Po4KXh5zk4zg0VxQ/oqDdm0+OA0fGn2BtV
	 AGM4DsOetD71Pox9BiiIYszhAEoEe779wzTmoKUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFYWzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFYWzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:55:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DBC2086D;
        Tue, 25 Jun 2019 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503353;
        bh=SYMcIFxgtO+dsktSi7jnPUjz1SSVD8CyNCsa+fKpnM0=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=g41o+waZoBKq5DrPrSDLQQkj1KxdmRMY4drEZFcRcJDHvbKaxBgO3zuEuSXxQbXUU
         OzU4FbO3HDIHoeqCPECNFtnQdsGRtXpPmHR45HScKLU8c/Sy5dx1Clt8hv4RYUBzIe
         pAzGJ4rzOzyf8nmj94pY8kqCqfv1uLt4imf280J0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190608105619.593-2-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com> <20190608105619.593-2-wsa+renesas@sang-engineering.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 01/34] clk: clk-cdce706: simplify getting the adapter of a client
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:55:52 -0700
Message-Id: <20190625225553.10DBC2086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2019-06-08 03:55:40)
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied to clk-next

