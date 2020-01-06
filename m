Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53AC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA6C20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578329747;
	bh=r/gL3xL0bP+hz0aZoUX/RJVh/m700l8OJ/DXqxnkKQw=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=GTV9rlHGqHmK7qUlwu0B5e5ZLMEYCtVdOjMqlMT9j3nrG11DzbICM2drKLffUDdD5
	 oAFsiFB0xuvr1AN8JuqRsZMxIvpVKjKtlZh8blNg77P6vqrbaZRMgvFnGs28sCLGef
	 8mCrxRbI48jC4qPs3YskiNAFgdDrAz7p0tR1dcmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFQzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFQzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:55:46 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484402072E;
        Mon,  6 Jan 2020 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578329745;
        bh=r/gL3xL0bP+hz0aZoUX/RJVh/m700l8OJ/DXqxnkKQw=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=rxoHZA8XR4MjGJthBCiv4gJ7EmKp7bqDTzao7EHDqrTQDNu5ZusIbXyAZ8Kg2+cgu
         0D9wOTBK6CeX4Rlmcp2PsxFtb53a4NfdrVxT8T1Qfi3vnubz67wUXE9iCNhABYTK8v
         pEiCKvDI+eivtZJ/3zJMFMau40LNQXSaMv7DmkFc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200106080546.3192125-2-bjorn.andersson@linaro.org>
References: <20200106080546.3192125-1-bjorn.andersson@linaro.org> <20200106080546.3192125-2-bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc-msm8996: Fix parent for CLKREF clocks
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 08:55:44 -0800
Message-Id: <20200106165545.484402072E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-01-06 00:05:45)
> The CLKREF clocks are all fed by the clock signal on the CXO2 pad on the
> SoC. Update the definition of these clocks to allow this to be wired up
> to the appropriate clock source.
>=20
> Retain "xo" as the global named parent to make the change a nop in the
> event that DT doesn't carry the necessary clocks definition.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

