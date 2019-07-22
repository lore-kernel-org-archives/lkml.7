Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE48AC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855D521951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563832557;
	bh=qQyINWOqS81byExZT4x709+WPZypFQcrGrNAnE1c5G4=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=RFbx/b4SoXEm08sSchKUQypC7t0za7ZUF2Hev4Kah3pJWPg9KROwohfRwTdOCObyx
	 EepTPQT/nNf2n3mHl7cljdUBq9rG1OvhVgyIRQ+9s/+eO+6bE6IYasHs7pFe/i+Qgh
	 v5VYFpLf/ndPdbjaBy+XxPWz5wri9dSZI2p4UuHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfGVVz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfGVVz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:55:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA23D21951;
        Mon, 22 Jul 2019 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563832555;
        bh=qQyINWOqS81byExZT4x709+WPZypFQcrGrNAnE1c5G4=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=qpHLwfP2DucMmTYdqdL6igwGeXMUQjSRhbGhMSWL+CkBV1k/Z9SAapc7JR8/6Rjkn
         T3wXZ1Yqdm6rSMEfwQGBgAS4k0SVJ7Ab0OTZ430wnfrR3Mv0tybdXlqFDqIf9sa6Pt
         mMjLGRdzlhLC5HgJb/PKGvBdzjZQOE+LEKsJNyio=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ca05abf7-1486-ceb7-91d6-266640eea69e@gmail.com>
References: <20190715173527.5719-1-digetx@gmail.com> <20190717200821.A77A120818@mail.kernel.org> <ca05abf7-1486-ceb7-91d6-266640eea69e@gmail.com>
Subject: Re: [PATCH v1 1/2] clk: tegra: divider: Fix missing check for enable-bit on rate's recalculation
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:55:54 -0700
Message-Id: <20190722215554.DA23D21951@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-07-17 14:33:36)
> 17.07.2019 23:08, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Quoting Dmitry Osipenko (2019-07-15 10:35:26)
> >> Unset "enable" bit means that divider is in bypass mode, hence it does=
n't
> >> have any effect in that case.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >=20
> > Any Fixes tags for these patches?
>=20
> I'm not aware of any actual bugs that this change fixes. Probably better
> to just s/Fix/Add/ in the commit's title?

Sounds fine to me.

