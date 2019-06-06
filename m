Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDAC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4545E208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559853363;
	bh=jzmBb+CPxKYoIpOqOYW+9YL8iX62mvJWYHT6yTA/VXI=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=mo3pMD1N3jEzGegIHvybYPNvtCA2g10SxD8X5dAZXfXetf3CfTCg9w+i6Tgzu6w18
	 976rz6L+gKWsYWTuWjfK0APD7/pJn2G+Tv70vLn7fbDnuVSl4gRAswAgYwLgZBEnSH
	 WnEuHLrZGc7mMIcdEo0Ki+C4/wlB/AP7KmXQYtxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfFFUgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfFFUgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:36:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B133208C0;
        Thu,  6 Jun 2019 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559853361;
        bh=jzmBb+CPxKYoIpOqOYW+9YL8iX62mvJWYHT6yTA/VXI=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=ocSbNKa0g3JAc3T+Gmp5iicjxRVMKkA/1XCCElps/QttkP2+lR3G8MoweQ9ThVmpI
         xqtRD1gx0w6cA+uUkFkbcGWPbqHaktXhxdOqtoWouD/MSWE3jkhSso9k3mf4DDv5oS
         OrcL+48xwervdrxa+DmlMy2BVwRsewMM1D3rvAGk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190509202956.6320-3-f.fainelli@gmail.com>
References: <20190509202956.6320-1-f.fainelli@gmail.com> <20190509202956.6320-3-f.fainelli@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: bcm: Allow CLK_BCM2835 for ARCH_BRCMSTB
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        eric@anholt.net, stefan.wahren@i2se.com
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 13:36:00 -0700
Message-Id: <20190606203601.9B133208C0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Florian Fainelli (2019-05-09 13:29:56)
> ARCH_BRCMSTB needs to use the BCM2835 clock driver for chips like
> BCM7211 which adopted that clock controller, make that possible and the
> driver default to be enabled for ARCH_BRCMSTB.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to clk-next

