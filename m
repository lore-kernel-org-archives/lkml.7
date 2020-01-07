Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BC7C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F70206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578380280;
	bh=32PqRptxthO9lkMvoz9Xsf1jok2nwdvbik3oGhiUedY=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=ol1rDNJo3WfkkHExeARhPqVQzkfFNiGUpSjLiDEofvVK8w34UDbWQiBklLiLnP+A/
	 ietk+sxiZe1yC5WUJR4DWuPkSF4xMrT+/NwTegeyqDbO6wkw/22rlQ1McBrDjo+79L
	 bvt+D5K6dSj7Z15SKyHtg937bWvZUINuDPaRJ4II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgAGG57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGG55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:57:57 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A48207E0;
        Tue,  7 Jan 2020 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380277;
        bh=32PqRptxthO9lkMvoz9Xsf1jok2nwdvbik3oGhiUedY=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=1MwkRsvfio6ZuXfADDlonldZg9H/b2I5vaXeDgrGfkh7GCKqlm2Amxf+EUlA7qnbv
         dK8zzd1mB11mUDdn9h9Wot737Sulyyp3umF25Hr7ndIaq3kbr7IgJnWM7DPcopST37
         XvdX3KCaWiYMIKiy6vt/01m2p319n47ycLFC40ak=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-10-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-10-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 09/12] clk: asm9260: Use parent accuracy in fixed rate clk
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:57:55 -0800
Message-Id: <20200107065756.E5A48207E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:20)
> This fixed rate clk is registered with the accuracy of the parent. Use
> CLK_FIXED_RATE_PARENT_ACCURACY for that instead of getting the parent
> clk and finding out the accuracy that way.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

