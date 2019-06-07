Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422C7C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17788208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559938821;
	bh=Rxhb7ZkzJ2tRc1b4IRrs2klGtUDxU25r/NeOspkgbtc=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=NWgNALRqyZOskoSQSzC34LbEm5LBTpaSZcpNRKRYXeiFIT3aesyhL5n9bNgKFzHmB
	 qZWCpksd2OUZG/siXR77HYYh2SI1N7KXkDF9PaQD08+VnPVHe0tn7VdcSniZHiOZrO
	 23AXyDVoO7NKmCOT+c+6noO3GbTI/NsQ7IUgd2us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfFGUUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbfFGUUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:20:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4AA208C0;
        Fri,  7 Jun 2019 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559938819;
        bh=Rxhb7ZkzJ2tRc1b4IRrs2klGtUDxU25r/NeOspkgbtc=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=1v4Re/Tix8dDpb3JI9KvK6DJEkGDz3AqFuwQpZfSjZhg17LTuN7/Igk7kc9Z19CXU
         I3GtkKobNB8NWA8V76Era1caltPubjms7Ip5c6cAfxWe9zd1Bx+Gf0pPi6dGc0laZk
         LnfX/xlco1c0tMrNm1HGP2VFQ20TIRU5E23LLmhI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190504001736.8598-1-bjorn.andersson@linaro.org>
References: <20190504001736.8598-1-bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: gdsc: WARN when failing to toggle
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 13:20:18 -0700
Message-Id: <20190607202019.8F4AA208C0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-05-03 17:17:36)
> Failing to toggle a GDSC as the driver core is attaching the
> power-domain to a device will cause a silent probe deferral. Provide an
> explicit warning to the developer, in order to reduce the amount of time
> it take to debug this.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

