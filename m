Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A28C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3D521920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568029329;
	bh=OSd+26KN7KVITwbT1qAgzFrfa0uIHcqZKR5y9ZZZ24k=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=exqUd8lnfwTEOq7PZEkyd9mf2gDjE0902bHqgYy3cqN9ETYWx5M/9fs0lCl0BZMf+
	 O1n2IWUgtFVvXZ+hjXoSEkRkefnC+M7lAzcKURPEDmTP5ybPs3gMOd6R42g9z2QoHj
	 Pmr2CBR/1Qp3seLoHTs55aDGcED5/KG2/FEzFXTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404337AbfIILmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731079AbfIILmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:42:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1355218AF;
        Mon,  9 Sep 2019 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568029326;
        bh=OSd+26KN7KVITwbT1qAgzFrfa0uIHcqZKR5y9ZZZ24k=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=FyFLZxTPmdFfsPk3VBsgWPeU6OpDYZMEfTlKTsDIpGkkML2QplChBpGjE2/UIJZm0
         LQweZeN96uFQ3fVOgYBcHImmfV4gB12y/2cv7zPonGW4vGovhmKcXZDTUGzj9GDfk2
         ofm72bmdNQy7GARdA9+tYbwlNQogrrAU34fjFjTM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826173120.2971-3-vkoul@kernel.org>
References: <20190826173120.2971-1-vkoul@kernel.org> <20190826173120.2971-3-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 04:42:05 -0700
Message-Id: <20190909114206.B1355218AF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-26 10:31:18)
> Convert the rpmh clock driver to use the new parent data scheme by
> specifying the parent data for board clock.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied to clk-next

