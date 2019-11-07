Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4608520869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573161113;
	bh=w8hI1PzkSNHtWNdduVEM6RBuCeTDzu/wS0AhMZ4KuE0=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=BcdIlycGiw2rsoCF8G/L8ZaGW5luLaQ6MQwQ96lduw4fc4skZkA76Q03eMAZkb6Ji
	 7YUCXmV8qm+55Ba9rPcWhVpQ79fSCeXsJvyp7HpkslAWs9MfjUNtq4cK1LOB4zaxuh
	 UtTLX9pq1xh73uO9CiAfIjMJ5V/PJZ9S3oRe61kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKGVLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfKGVLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:11:47 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814552077C;
        Thu,  7 Nov 2019 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573161106;
        bh=w8hI1PzkSNHtWNdduVEM6RBuCeTDzu/wS0AhMZ4KuE0=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=WMba3GGCqeCLAbGdjWaGfLwTczZWzksCxFsjFPzwSaiId/1ePM+iBls8rFK/4/1bl
         5YDYgOf5LyXN9RTqsQ6cB2C9hMkq4kbtCRsnTORzxXu2yj5ggDYA+Lva+srxNTkBbv
         OOdzLzYGbW+fh+pnS1emd1yqV6FIT6fDP7DfHEsY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191014102308.27441-5-tdas@codeaurora.org>
References: <20191014102308.27441-1-tdas@codeaurora.org> <20191014102308.27441-5-tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: clock: Introduce QCOM GCC clock bindings
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 13:11:45 -0800
Message-Id: <20191107211146.814552077C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-10-14 03:23:07)
> Add device tree bindings for Global clock subsystem clock
> controller for Qualcomm Technology Inc's SC7180 SoCs.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

