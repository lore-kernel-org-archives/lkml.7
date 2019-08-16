Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D4C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC2205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565977028;
	bh=3211moOdEoax3Ux0E0nVz+1fI/L2wdR4tSaRDOLKgK8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=JVfKG5hqFM0qABzCtLi2ku7rnl5x+v/4HlyBeRi2SMjPNufb/T8o/hejHeLwK2Q7B
	 jr5l5D3YAHdNQg7AUUmapx+01m7dHJWnqmJpC54NEi1zM4IZh6olcCtK93DC4A7vEU
	 fUG32PKdCf/MnkMY3cCJflPoBBbrogGw/tve0UV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfHPRhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfHPRhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:37:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD2F205F4;
        Fri, 16 Aug 2019 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565977026;
        bh=3211moOdEoax3Ux0E0nVz+1fI/L2wdR4tSaRDOLKgK8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=txrPkUyxFz9MhSYZBaa7oJQZljvsq9h6O60vhot5n0OSovNZGtgpRQQWG4VL8lKY8
         esvIHKsxEMPadja4wUiFsbeQjFW5vFk5nvlykD1jDyPK73ETl9XYqzFFBt4fb1bfRm
         WyLTZV6BR/l3nilxsWFAMOJ2WwM8jFe36QpdzLt4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815042500.9519-1-sboyd@kernel.org>
References: <20190815042500.9519-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: composite: Drop unused clk.h include
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:37:05 -0700
Message-Id: <20190816173706.3DD2F205F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-14 21:25:00)
> This include isn't used. Drop it.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

