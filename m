Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45562C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C402146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576735064;
	bh=ZKz0NEyGeTC7rA8T8xZF8Cvc7Ruym+COPcr24723S+Y=;
	h=In-Reply-To:References:Cc:Subject:From:To:Date:List-ID:From;
	b=vKWUOJsPVHUm6fcE1aIY4X2wX7tWNITAg4VZ6U9c6EfMtvKZi/Nb00W3aI12Cfxcj
	 LZoREJ8hFYwlNNrDO4kmGi6eiVLkt9l80lCwCKYSV9Pd2m7gzPNJsGQASSV1xmUKVI
	 u2+Xo/XljffEs9o6DxXZmKCCIusuRsEIpwY7/GHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLSF5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLSF5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:57:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6282E227BF;
        Thu, 19 Dec 2019 05:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576735058;
        bh=ZKz0NEyGeTC7rA8T8xZF8Cvc7Ruym+COPcr24723S+Y=;
        h=In-Reply-To:References:Cc:Subject:From:To:Date:From;
        b=SlLILgypfuN7LDFWzArPqRx9e+s7oOLhURbTJngtFrLF4El6lubIY2fJtE7BhEFkI
         LKW87eGcjyef5WYYukvDC3Smpx7CzGZwZueEMbAhAJCE35zWtdesaOzDDdI7rJ+jZz
         4Xqh4o0i8Y3JJLaMWFOahaXvlvXipS8kyNwyOwEU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1576596033-10189-1-git-send-email-jhugo@codeaurora.org>
References: <1576595954-9991-1-git-send-email-jhugo@codeaurora.org> <1576596033-10189-1-git-send-email-jhugo@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v11 4/4] clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Wed, 18 Dec 2019 21:57:37 -0800
Message-Id: <20191219055738.6282E227BF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-12-17 07:20:33)
> Add a driver for the multimedia clock controller found on MSM8998
> based devices. This should allow most multimedia device drivers
> to probe and control their clocks.
>=20
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

