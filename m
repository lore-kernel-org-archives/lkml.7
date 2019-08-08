Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D672173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565295802;
	bh=/yMO/gaxak8tQYEak/Foyv+IzSbgCRbycYQcUCMnGds=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=SRBs+cWOIO74cRU5RllgDXaYjLn9MC2E3cGFo334LpsSm+AZiRh/XnHb2tjhc3bEq
	 FI0apu7+lvRxRzoWty/DyMayGyeePQ7HMyIeWX1+MhPYe8DIlG2dKftv8QDz58XBwO
	 JSOwlI7l+YgsveArwlYYc1nXqgcqBVjWnVJGWcH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404928AbfHHUXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404588AbfHHUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:23:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E469D2173C;
        Thu,  8 Aug 2019 20:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565295801;
        bh=/yMO/gaxak8tQYEak/Foyv+IzSbgCRbycYQcUCMnGds=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gOx1FbxFsQhWWWhAuzof8IsPeqjaXYUi698rgD9EhqpoWsxsE81oYbt6vvBpax3zJ
         sS0dNVo+EoCuXK4KJdoy+7czUjZAJNMHBiWhzsybI5hmiR4ZQ8f+6INIpzKad6iz17
         tXYmY+GDTPl320gWNPvqUB5nky/19YjAKAvgBzys=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190808144929.18685-1-s.nawrocki@samsung.com>
References: <CGME20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438@eucas1p2.samsung.com> <20190808144929.18685-1-s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 1/2] clk: samsung: Change signature of exynos5_subcmus_init() function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        mturquette@baylibre.com
User-Agent: alot/0.8.1
Date:   Thu, 08 Aug 2019 13:23:20 -0700
Message-Id: <20190808202320.E469D2173C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sylwester Nawrocki (2019-08-08 07:49:28)
> In order to make it easier in subsequent patch to create different subcmu
> lists for exynos5420 and exynos5800 SoCs the code is rewritten so we pass
> an array of pointers to the subcmus initialization function.
>=20
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Tested-by: Jaafar Ali <jaafarkhalaf@gmail.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---

Applied to clk-fixes

