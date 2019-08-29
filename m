Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D64C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64292080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567090598;
	bh=87c/sZOK5Vf80gVMZfizb+tDjnyD83dUp+olyHqIqzE=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=juyR5/XYxPRBzs/QtcNMWYg/0v5HHYYsxkle4jMwwX4sb6hC1C1Nnb0YNyotjasBn
	 wMZTv0OTmfBUtr1HfGv8UYHnlXHhh4f75e0rTRhpc/l55NbwbYDEr0RKYjaUWk9ru4
	 bpdyNOUMSF2n/HZxMHvLQsnoZuDAwRj55dj3D6DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfH2O4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfH2O4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:56:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA91F20644;
        Thu, 29 Aug 2019 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567090597;
        bh=87c/sZOK5Vf80gVMZfizb+tDjnyD83dUp+olyHqIqzE=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=MpUt5vRzYPcn/zTCSf1DsAlrM/gEm9m95QA7WbzXS1nF58aFrVgtXERi4TnLjrMV3
         MJppYmsqN7cgICEisO1QNwhBUgnkYzMp61yA2P41zzOcVWtLCBQt0UeqEfjVat2hTv
         VLOWybUBIAUAMzQCHRgXgTdPxDOaG5Xri//13HRM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829082759.6256-2-jorge.ramirez-ortiz@linaro.org>
References: <20190829082759.6256-1-jorge.ramirez-ortiz@linaro.org> <20190829082759.6256-2-jorge.ramirez-ortiz@linaro.org>
Cc:     niklas.cassel@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mbox: qcom: add APCS child device for QCS404
To:     agross@kernel.org, jassisinghbrar@gmail.com,
        jorge.ramirez-ortiz@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 07:56:36 -0700
Message-Id: <20190829145636.EA91F20644@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-08-29 01:27:58)
> There is clock controller functionality in the APCS hardware block of
> qcs404 devices similar to msm8916.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

