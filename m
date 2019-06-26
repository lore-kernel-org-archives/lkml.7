Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B92C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71E321743
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561573006;
	bh=62pta54jgKBC/byQ+hJjMuf4fVRHcNApQjBD5ZLwRaw=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=mP0zuAtcZo09M0Z/bTLQKim/oiSQGSzkRQZo7FLglXLEHRJ0NiUmNzWmgTjh5PLZQ
	 sbJHPrmzbNap2CS2RqVk1Ax2e5kClqBPywgJ2xf/07+tZJeMX4ZTEW70qk4vV2U8zx
	 UCjPicFJQhExW57HGcHAHVL99VLr+aQsOBs1p/js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFZSQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZSQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:16:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E91621726;
        Wed, 26 Jun 2019 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561573003;
        bh=62pta54jgKBC/byQ+hJjMuf4fVRHcNApQjBD5ZLwRaw=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=pBfwLfPHzXUe7YBdqT+i22XMgyfx/WmwoX3Lm694P6QkO31tPn2I7er1rxtozW7Md
         iOkSQCTemVOTbjPZ9XxfWvDaoRPi6EgJYSa3+rY501dSAaAPSWfqdSA5dlI5XJ4jhg
         3oHoymhpxXDQjCjKht95yc5V09n/MggvvQmAbERQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190522011504.19342-3-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org> <20190522011504.19342-3-zhang.chunyan@linaro.org>
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/3] clk: sprd: Check error only for devm_regmap_init_mmio()
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:16:42 -0700
Message-Id: <20190626181643.8E91621726@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-05-21 18:15:02)
> The function devm_regmap_init_mmio() wouldn't return NULL pointer for
> now, so only need to ensure the return value is not an error code.
>=20
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---

Applied to clk-next

