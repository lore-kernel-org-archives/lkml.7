Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FB7C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DDB2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566090836;
	bh=o4DQYKiqpQVO51Qn7Nv3Ak+aH2WKhzz5MFhjV6dhkkU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=O6cnw4cMm5gPFrUbGqMTWwOTIHEnFL/T+x5x5fN4KpDOPXBOAYSXOIvrdw8dqDsYP
	 K+Bk1kvs2fAikADccYyPvFYSGFyYhghqVeTD7VDZ7DVq6JUQ+reGFe/o3GxFWjxcDq
	 tGs8gAjAipEROWAxc5cVlSngBnwZc/ErCaAXMMMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfHRBNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 21:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfHRBNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 21:13:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20BC2173B;
        Sun, 18 Aug 2019 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566090834;
        bh=o4DQYKiqpQVO51Qn7Nv3Ak+aH2WKhzz5MFhjV6dhkkU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l5XBQm1tWUW9jt+uzjICpMdu3r2R0bE7rVnmgAhWDRaQi8PEiJD9rVLNrxsKIphAA
         kLnLNNuUUafTbA2damOaR12+UZHMmketl2EvdC9+y5+cOBaUcpijbAHcTVCxRERHHE
         knzS2w5m2pF4cmtELvKY+bI9YXAbqCoQMBz0kKqI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566023759-7880-1-git-send-email-gupt21@gmail.com>
References: <1566023759-7880-1-git-send-email-gupt21@gmail.com>
Subject: Re: [PATCH] clk: Remove extraneous 'for' word in comments
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
To:     Rishi Gupta <gupt21@gmail.com>
User-Agent: alot/0.8.1
Date:   Sat, 17 Aug 2019 18:13:53 -0700
Message-Id: <20190818011353.F20BC2173B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rishi Gupta (2019-08-16 23:35:59)
> An extra 'for' word is grammatically incorrect in the comment
> 'verifying ops for multi-parent clks'. This commit removes
> this extra for word.
>=20
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---

Applied to clk-next

