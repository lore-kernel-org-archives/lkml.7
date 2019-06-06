Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E0C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018A20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559846331;
	bh=JzQqaRmZwOMurAoy8+YC4u2pY20QAdiwZNKgQAQJ5qA=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=do8NT4/zZiK1QvIHv0zWG6nCVPyb4N2XjonxzBqKNsgrGEoOs7zdDqohL2NYYcOkB
	 BEQvDbUeyR6Zn5+mnr04HVlMN6SLUMREfmMgFvAOLJIHmM+InEMJ3TCjnlhOn6zzEf
	 FBMAwB9nLBog1F/NdmrQB+nJrSaH0yYVDOj27IAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfFFSiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfFFSiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:38:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E21820868;
        Thu,  6 Jun 2019 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559846329;
        bh=JzQqaRmZwOMurAoy8+YC4u2pY20QAdiwZNKgQAQJ5qA=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=ONAhlg/bWC/qFxfVmTMoY8G9PmitxBKXNxTwC93OxNUxSAp8fML2unVAMoptK4qCB
         nP+Vgmb+UO1v+7YgHgYjYBd22FzvGzEgDYzwoxcuFLE6aMsCWwalgECwn4/dC+h5O0
         UcDQsq4R81eiPA2wmaC5dmWIGqam6hMEFzC9/gm4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190525184253.3088-2-martin.blumenstingl@googlemail.com>
References: <20190525184253.3088-1-martin.blumenstingl@googlemail.com> <20190525184253.3088-2-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/1] clk: pwm: implement the .get_duty_cycle callback
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 11:38:48 -0700
Message-Id: <20190606183849.9E21820868@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-05-25 11:42:53)
> Commit 9fba738a53dda2 ("clk: add duty cycle support") added support for
> getting and setting the duty cycle of a clock. This implements the
> get_duty_cycle callback for PWM based clocks so the duty cycle is shown
> in the debugfs output (/sys/kernel/debug/clk/clk_summary).
>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Seems ok to me. I'm not sure how useful it will be if pwm has debugfs
that can be read too, but I'm not too worried about it.

Applied to clk-next

