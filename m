Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559F7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBA1222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576736673;
	bh=2My7XHOzyO+6is46gUo4mxdgo/e36X6AXdiIRPDg1lI=;
	h=In-Reply-To:References:Cc:Subject:From:To:Date:List-ID:From;
	b=HB6kFSaAhL1UeprlQE76Z4GrsqE4Lob9xRZrOvFxc0NizJE1caCZSFjkEo2ZamPGZ
	 aER4OoVtoypIaFkxThMhltgArS3pM4rNHCAp/01yE/xZqcS3NwUwjbxkxt2MuCRzkM
	 87GtgJkGl+yfkiYNDBLbN69yMTFbfg+HFhHUt6+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLSGYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfLSGYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:24:32 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6578A21582;
        Thu, 19 Dec 2019 06:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576736671;
        bh=2My7XHOzyO+6is46gUo4mxdgo/e36X6AXdiIRPDg1lI=;
        h=In-Reply-To:References:Cc:Subject:From:To:Date:From;
        b=F4lsnFdZJfb6EC7apOmq1aBzEZgLN091GwCmAKEpmdvSDX2fdIpU1GG/es+9ZhvSW
         9as6JDeiGSfomcaQSw+0VyfOyvW7iKExE968xsSsTL0LO8vkaQoryEzEYu7RLEKsX0
         ykm8s71kTEeM5lDY+W2egdRes6kk+Pve9CZcOMpU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191125135910.679310-3-niklas.cassel@linaro.org>
References: <20191125135910.679310-1-niklas.cassel@linaro.org> <20191125135910.679310-3-niklas.cassel@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
User-Agent: alot/0.8.1
Date:   Wed, 18 Dec 2019 22:24:30 -0800
Message-Id: <20191219062431.6578A21582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2019-11-25 05:59:04)
> From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>=20
> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> specifications.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

