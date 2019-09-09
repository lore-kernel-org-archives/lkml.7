Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364DBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C70021920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568024743;
	bh=/QuTF/zEDup0WFh7FpYwvfqXIv/EWMjcKBOyYW5JMqE=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=ZFE4gTOfswBKb7I9f1z6rsxykKlbSDZL8GuzdzmCousMv4qM1M+qI2kBGSq8P9s+X
	 m0/VL7Vf3fP1fS7VHP3FXeV3FtSIVVZ4mjKlVtJErnjRVfLn1WzqvsfEO61hoVUgpJ
	 i8e14VqcAWp9l9GsQVJkUXiwp9TUjNE5/1g6fPfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfIIKZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfIIKZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:25:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3EB2089F;
        Mon,  9 Sep 2019 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568024741;
        bh=/QuTF/zEDup0WFh7FpYwvfqXIv/EWMjcKBOyYW5JMqE=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=g37B5hNNWnR5UL8rj0TTz+qIC4kjg2eMcaOVCFqKAwHBN2SLSFkOmRLPRUlnYc7Do
         yWJZbv5OQ+ArpSB6SPwYjX3Fu5/Wio87Et45rUrtT79bztB/Cx00KJnmETKoqMvBGn
         MpZ/p8VUGmP+nxgcWdPaFrT4eWY+VUD7FAa81wPA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190906045659.20621-1-vkoul@kernel.org>
References: <20190906045659.20621-1-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: gcc-qcs404: Use floor ops for sdcc clks
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 03:25:40 -0700
Message-Id: <20190909102541.7B3EB2089F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-09-05 21:56:59)
> Update the gcc qcs404 clock driver to use floor ops for sdcc clocks. As
> disuccsed in [1] it is good idea to use floor ops for sdcc clocks as we
> dont want the clock rates to do round up.
>=20
> [1]: https://lore.kernel.org/linux-arm-msm/20190830195142.103564-1-swboyd=
@chromium.org/
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied to clk-next

