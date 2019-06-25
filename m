Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3AC48BD8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F329208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561503638;
	bh=VJ8Run0Yyz5vZrKCBviF3RYogOOpfjngFxj1ycAUSwE=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=MigcSXAAXTa1k7fObm2ZIX4fZ3g5Tg1PpViwTxuXfqXmuK1lS2JsOPGmbHRG45ZLK
	 YURR+TG9pSGPYA6XthKxcxUnWvtTE8tMdy9qPp0M5+whdmq3NYXI2WL7LXwjVdVRMh
	 vCt3mK3bIlsTeHGIOcHpnTRUBXZp9uaTTQuQc1r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFYXAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:00:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394762086D;
        Tue, 25 Jun 2019 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503636;
        bh=VJ8Run0Yyz5vZrKCBviF3RYogOOpfjngFxj1ycAUSwE=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=P5wDgSz76b+zzsGkc7Dg3ULasI4YLjC5pHavNdKwo/l7eO1fD4s5RM7a4O22aEuRr
         3qRDDQgWG1kcl23wA7v/eFe9rAU2nlMgqhEeDWhLzRUwIB1eZn6hc6KSPmB1S7j5B9
         BlA4mvcwFrI9N3QELo3NEwfgAm8l5GJjX9vepgpg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611175839.28351-3-nsaenzjulienne@suse.de>
References: <20190611175839.28351-1-nsaenzjulienne@suse.de> <20190611175839.28351-3-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/7] clk: bcm283x: add driver interfacing with Raspberry Pi's firmware
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:00:35 -0700
Message-Id: <20190625230036.394762086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-11 10:58:36)
> Raspberry Pi's firmware offers an interface though which update it's
> clock's frequencies. This is specially useful in order to change the CPU
> clock (pllb_arm) which is 'owned' by the firmware and we're unable to
> scale using the register interface provided by clk-bcm2835.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

