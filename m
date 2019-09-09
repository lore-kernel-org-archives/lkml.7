Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F2C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ADD2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023195;
	bh=z18YdR9DjkfQCJRQMn6vKm/qgjme1hf1hZOqxE61B1E=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=H7MOLKzUCawpUVdzQ/8s6q8Mm6pFzCujx5juD8j/kgxKSYdQyLm+AVP5B9N7aHGL+
	 cvFics8YE+tkpd94pH8GhIB+zCQqaG+EMZGAyilF3EnoRWz2UtZsItKSY/1bfeedG7
	 /Rt8Y4QIbg1f+21NjtMpUj8Z1wkOr+81IPBaeovU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390204AbfIIJ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfIIJ7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:59:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599382086D;
        Mon,  9 Sep 2019 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568023193;
        bh=z18YdR9DjkfQCJRQMn6vKm/qgjme1hf1hZOqxE61B1E=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=doK3Rt+H3uLF1v+xCBrlyNi+vWF+rCBWTAYS3gvWYpv5mrCpkIQwGywSvh73XLqGt
         dZUC4qzxevTsJOUIjD13yt6+ud8nYHavXD8xR95IJdPyLXoeGTl+5Q3e5uHmaokrkW
         +/TKAQ5ZjJs9t5GLR8b67yVZwKVX24k7BtEcVNeU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826234729.145593-1-sboyd@kernel.org>
References: <20190826234729.145593-1-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Drop !clk checks in debugfs dumping
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 02:59:52 -0700
Message-Id: <20190909095953.599382086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-26 16:47:29)
> These recursive functions have checks for !clk being passed in, but the
> callers are always looping through lists and therefore the pointers
> can't be NULL. Drop the checks to simplify the code.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

