Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B9C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81889206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577169467;
	bh=aBYtKXHcrTUI4HLdUJthX1une9TMYMbyNl3Sz6xLWVU=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=muelbbLQUfR7XoW9sOrKnoDsMs+fRZha2lQ/DI5G35xINQoUDFVjPSbe8spo7a5M4
	 FRJnwfTXbjW8MYQvWS8+/5rrYPceak9OgKZoXvTtsg/IDdM00ELvbw/jA/ug5xNEB1
	 GdNqpGDoMC7+YAE7rCmKBXv1JXK387kTSKMcvd4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfLXGhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 01:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfLXGhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 01:37:45 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C62206B7;
        Tue, 24 Dec 2019 06:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577169464;
        bh=aBYtKXHcrTUI4HLdUJthX1une9TMYMbyNl3Sz6xLWVU=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=kc9SC2Re0MDROGqcRJWyOfJ0t/40UOMlraA3Vsl/RP2K7TXVcuSSoz3+CVW5+JL0y
         rVak8uNA0N5PRr1fI6vcQeQUbZTUWMB6zU/Jfg1ESKjWE1GyuKTriq9rCFJF7Ax8i0
         u/uj8JIUlpGbS9qdhc6tRokqmrxELh5vvNHGfIu4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573812304-24074-3-git-send-email-tdas@codeaurora.org>
References: <1573812304-24074-1-git-send-email-tdas@codeaurora.org> <1573812304-24074-3-git-send-email-tdas@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2 2/8] clk: qcom: clk-alpha-pll: Add support for Fabia PLL calibration
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 22:37:44 -0800
Message-Id: <20191224063744.D4C62206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-11-15 02:04:58)
> In the cases where the PLL is not calibrated the PLL could fail to lock.
> Add support for prepare ops which would take care of the same.
>=20
> Fabia PLL user/test control registers might required to be configured, so
> add support for configuring them.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

