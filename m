Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044EAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5766212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556299042;
	bh=YOqdRP1NibCHtG7DRV7/U52ilDs1WxrKyoCTk50cxM0=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=JMSvyqvrRxaZIhiWtsJF9ETSYyv8Ty5XwuDYfxlyiD3Qxq6RfqQ5MujONM0+aOlKn
	 9QXhlSgjRLsYIaP5rmoogM2CvKH9wLldxuMigFYwrYV1ggsqyRUNAsTf0eCcyc6ic6
	 1H9h6MOsFmi14iEX4BJ9/hr5zILZEBqMINilNWVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDZRRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfDZRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:17:19 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A97E212F5;
        Fri, 26 Apr 2019 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556299038;
        bh=YOqdRP1NibCHtG7DRV7/U52ilDs1WxrKyoCTk50cxM0=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=qwe4qs3dYnolA64U11jZvfhn/j37Iv6ZCuKR4WL1MSHxIBouZbgjhY6LjtqOdEpQ3
         bbOxeujdj/rMuxTwmQ7mgz1gYTgH6qnQtOLY7nEeXkFqGOtBa2OVWi0YwvUfyj52PT
         IUvIjrhK2aF4EmZHRmjiqhk8H1ED4faU7k5pBiwY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alpine.DEB.2.21.9999.1904261000090.28496@viisi.sifive.com>
References: <20190411082618.3502-1-paul.walmsley@sifive.com> <155624271876.15276.8637203698438742304@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904261000090.28496@viisi.sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 0/3] clk: add driver for the SiFive FU540 PRCI and PLLs it controls
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <155629903755.15276.1866080713022430392@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 26 Apr 2019 10:17:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-26 10:01:23)
> On Thu, 25 Apr 2019, Stephen Boyd wrote:
> >=20
> > Can you please send the dt macro patch along with the rest of the
> > patches? I can't apply these patches and build them without it.
>=20
> It's upstream now as commit 6ec4bae178d8 ("dt-bindings: clock: sifive: ad=
d=20
> FU540-C000 PRCI clock constants")
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D6ec4bae178d8a1e9814eb3bfdd321b0475de0468
>=20

Hmm ok. Thanks for the pointer.

