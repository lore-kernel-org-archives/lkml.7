Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05460C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D224C21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568029343;
	bh=jaHK9yclqmqZeEXreS6ccq5kgb9QKtTXctRHWseJIK4=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=snrUQ5HjhHpfp9BnBTzwb8WXTmov7/IP2T3SmzyUUoSl1GiXjP9RcQrYB+heNyiCe
	 STHPgXprANGpQdjyQ5fgPlb8IgRoy4RbRFjK3VoQC+yXUQ2JbAB3zCVCUuZheyi1up
	 QdR8tDx5vy8gNU+0BZtvMb4HICIrlIivJkkVMQJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404385AbfIILmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404360AbfIILmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:42:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70EE218AF;
        Mon,  9 Sep 2019 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568029342;
        bh=jaHK9yclqmqZeEXreS6ccq5kgb9QKtTXctRHWseJIK4=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=qseQPcOA7QL4i1WWu3zBKrnMjXesIHPiVDApKxdF0rR1+NpltE/2mRIsTbZXgbWkV
         Dsswo59aux8BLUuJ50SGdno77IFhuQQDiwxlP+MOCk7KJtMLvJK8l72eqSO8YikP21
         mtQ6ZwtRJUTrxDxFwb3V2+RFV77pjYC1r3QjnR/I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826173120.2971-5-vkoul@kernel.org>
References: <20190826173120.2971-1-vkoul@kernel.org> <20190826173120.2971-5-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 4/4] clk: qcom: clk-rpmh: Add support for SM8150
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 04:42:21 -0700
Message-Id: <20190909114221.E70EE218AF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-26 10:31:20)
> Add support for rpmh clocks found in SM8150
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

