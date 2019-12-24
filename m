Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC82CC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FBD206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577169463;
	bh=ON0QdqQ+wjgFyA7W2CtWIRLA64ZOjDQt5hzeb32O6V4=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=pPWlZmfNT/nVBMsnC7olCVMi7cdesL5siEj/taM5nr3tbL/xxSrfqgmVGf84O5ckT
	 bNSeScyDsK4/Tlxo924ywBkPSMt27FP621/cRgFY0uS8nAi+6bY45fqH7vc394beP0
	 Wy3+F2UdZ3i48SmSq6XyI8ECJEyDTyzzYjpmOBIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfLXGhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 01:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfLXGhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 01:37:41 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2BB206B7;
        Tue, 24 Dec 2019 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577169461;
        bh=ON0QdqQ+wjgFyA7W2CtWIRLA64ZOjDQt5hzeb32O6V4=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=lWZx/U9u+vy7OwSIikON6FT0bCHntn0XiTdyqYN+5ZYdYlUUy6p+Y6zv6iwwVa7Wz
         yJ3c67UcgeooKtp0JlSla/v0fyBckAivXtj/f1BYfW71YwUGd/Hzq2HMmRJDDVIDAt
         p3vBi1o3AfwGwRf0klfEuGIErKNjAV38b5GgyI74=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573812304-24074-2-git-send-email-tdas@codeaurora.org>
References: <1573812304-24074-1-git-send-email-tdas@codeaurora.org> <1573812304-24074-2-git-send-email-tdas@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/8] clk: qcom: alpha-pll: Remove useless read from set rate
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 22:37:40 -0800
Message-Id: <20191224063741.1A2BB206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-11-15 02:04:57)
> PLL_MODE read in fabia set rate is not required, thus remove the same.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

