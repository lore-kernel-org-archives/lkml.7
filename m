Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA6C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BE3206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577156385;
	bh=Z4z6F/8kAVtJEUdjR7Ofsvw8xLI9AKntZE2rBDxc+XU=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=fRRhsl/wmOYrgfIiu94tde4QaxU2PDx17WVppWgcMQCt/JYA5cPNO9FNkPeI04j37
	 x58RrNPyxJpW38z85O1M2SNvYXRrZZPjskIIvxqdBEmuSEkQ6cJ9eO0N3356xKHpFI
	 rgwN7PjAhsUeApmlhI4bQO7jUSLBGeUq1661qWWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLXC7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfLXC7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:59:44 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510E8206B7;
        Tue, 24 Dec 2019 02:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577156383;
        bh=Z4z6F/8kAVtJEUdjR7Ofsvw8xLI9AKntZE2rBDxc+XU=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=o2DsGcZLJZi83Vs+HunUjbJVy9jBNgIvOXeJfvMgSGMY1vZSmxvPGVHV8exaIlFgQ
         JhKIPQaaX8q1/A7bdcgWSSxiFFMbiiR4vVy3VfQ/tH/0qv2/utXyBAq809v5f34cqf
         xS9FtFzQr7celYXKa9fFsjnLt0dT3dPZoc5Nud2M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190924123954.31561-2-jbrunet@baylibre.com>
References: <20190924123954.31561-1-jbrunet@baylibre.com> <20190924123954.31561-2-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/3] clk: actually call the clock init before any other callback of the clock
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 18:59:42 -0800
Message-Id: <20191224025943.510E8206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-09-24 05:39:52)
>  __clk_init_parent() will call the .get_parent() callback of the clock
>  so .init() must run before.
>=20
> Fixes: 541debae0adf ("clk: call the clock init() callback before any othe=
r ops callback")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next

