Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD606C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188D2206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556218048;
	bh=h0IRdS0zhUHch+Mb2SVu8W6kNKIPNL4kiY/nrL3Ch+c=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=1g1B73/s5G2RWECa9Y4+o+SQZOZpbYNWvCtMb0CzDMkwE2yigTuj0Xz7lZwz89r0w
	 MUlXhD3bYJwTJaPqHHzKItkoYCklJrTwzXA5gTf04VX5eSWEBQsO5R++mkk/EdkTf/
	 HWTLfF6SccWTFT+g5bypVSzDPfBUL0oC9QADyCeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfDYSr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYSr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:47:26 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103CA20578;
        Thu, 25 Apr 2019 18:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556218046;
        bh=h0IRdS0zhUHch+Mb2SVu8W6kNKIPNL4kiY/nrL3Ch+c=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=ZrXuEZkEgN0F1w1XhoLf7aUEBeKml8v8KWlXzW6ZkIWi6AjJjI2ACKGYmjbOb/pOe
         Vz9yPBEgrjBM7WZk0Y+XQOlJoVHIYH9XWFfV0QUsyh8X7H3/IJB1azfCyry6pLxdzY
         tTYV+LUARV5TVg5zLmjvUw+4n5bGnB+a5JFOmki0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190405075332.28530-2-gabriel.fernandez@st.com>
References: <20190405075332.28530-1-gabriel.fernandez@st.com> <20190405075332.28530-2-gabriel.fernandez@st.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Gabriel Fernandez <gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: stm32: Introduce clocks of STM32F769 board
To:     Gabriel Fernandez <gabriel.fernandez@st.com>,
        alexandre torgue <alexandre.torgue@st.com>,
        mark rutland <mark.rutland@arm.com>,
        maxime coquelin <mcoquelin.stm32@gmail.com>,
        michael turquette <mturquette@baylibre.com>,
        rob herring <robh+dt@kernel.org>
Message-ID: <155621804467.15276.5950117999221628038@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:47:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gabriel Fernandez (2019-04-05 00:53:31)
> STM32F769 clocks are derived from STM32746 clocks.
> main differences are:
> - new source clock for SAI1 and SAI2 (HSI or HSE)
> - Add DFSDM & DSI clocks
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

