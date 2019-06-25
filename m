Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA20C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02391208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561502927;
	bh=UbgKtH9JPi+VcX5lG7l/BUoaN1XBUhmU3D9CtflJUxA=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=dlTSutLZvsc1sB8qLhre3eBAeU35lsQThpeKEiY/b9xvx6R8ErwT7EtNjdqhvRVdn
	 kUxG58izi08EdhzljgK+YcBT7wnuVeFhvG/Kugh895gC7NazrwQmJnD/osWRnNaXUY
	 1+gS8SyXMGN0u1/spqL0228u3d97s5UmS6zNMAbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfFYWsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFYWso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:48:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B67372086D;
        Tue, 25 Jun 2019 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502923;
        bh=UbgKtH9JPi+VcX5lG7l/BUoaN1XBUhmU3D9CtflJUxA=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=vVuMziO9dwx6S78iwvgisewURKt3glH06Xoe4kgqeqpPjbaM3pVNv3N5Vwdt6Fh/j
         gEV5ocTS3df46ms+SWvmsrPAvX0/3BNSNR3kKOkpksjDAFJAzPh7cHQ6ImV21lWp4K
         ZHTQssYoNidVZ2rAb/jAjk+5u5MXIxtvYOG9QmAA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611180757.32299-5-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net> <20190611180757.32299-5-paul@crapouillou.net>
To:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 5/5] MIPS: Remove dead code
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:48:42 -0700
Message-Id: <20190625224843.B67372086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-06-11 11:07:57)
> Remove the unused <asm/mach-jz4740/clock.h> include.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

