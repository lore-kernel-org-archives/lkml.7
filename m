Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BACA2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567143181;
	bh=NkDEyysOoEkY5x3koc3MeykF+ujhFS2LOE/j81tDytQ=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=cQUGEazwgEo5njQeYU2poRr2KFUMrqdem91OSVv6r2hzjsqyacT8P7uuURV0+POiU
	 TVFIXxSWlrquhsCKJwLeBDpqCx3dZlVd8AcjdbKEdE5oWKVKMWygtOMQ73nM84wz+w
	 H1zeZUXZaVk3jAQgD3CXApZZig+wnrW29McsE4qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfH3Fc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfH3Fcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:32:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EE62073F;
        Fri, 30 Aug 2019 05:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567142726;
        bh=NkDEyysOoEkY5x3koc3MeykF+ujhFS2LOE/j81tDytQ=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=dfWudf5x9Qm/heJhO5v8p6XUAyLNMaJMtFPKiDvNV1PHLNZ5wH8w5BWkUBPHtwpg7
         J38VkpizTIekwzpxu/v/djZGI2tHDX5d5Fvoc972QLgvpAz04xHYoSAGpcY07fumQs
         ny7ic9UGoDHFc7DINoa7Xh/O0CrxVBiUl/KYTHWU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829200340.15498-1-jorge.ramirez-ortiz@linaro.org>
References: <20190829200340.15498-1-jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcs404: add sleep clk fixed rate oscillator
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
        robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 22:25:25 -0700
Message-Id: <20190830052525.E7EE62073F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-08-29 13:03:39)
> This fixed rate clock is required for the operation of some devices
> (ie watchdog).
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

