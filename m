Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738E1C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4108620835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574791634;
	bh=xgHIkOlT0nceTODXgzK6pno0GYLHq/OcCO+fwm9Gnjw=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=conphrDekA36RjFY0Tpror0AbVoiTWWoAy4yBQlFv5KBGuMMVjQG0bLBdmMhnXD8k
	 tNQm4pM/+ufPPvnfT1bCQJBT1BRFXKtwsMGx94Hl6D2CdmBz7yN1zK/B5m3yP3pgFc
	 3mgHGoVxzeVHfhLt+3h9qVIDXsvIJY1AY2yqgs4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKZSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:07:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfKZSHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:07:12 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D93C20835;
        Tue, 26 Nov 2019 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574791631;
        bh=xgHIkOlT0nceTODXgzK6pno0GYLHq/OcCO+fwm9Gnjw=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=hmya4l35DUAuZ2/Dyd51BBTKqMcyFZaXKsC9UrV8nczOpspBY9KKNd08XPKMQkCyB
         J0Wi7fwNNrZ1BVahVLq3fOeYEDJr/+LB8D9K+AyZJpQXwyKHGeHcxTl96DSQFinWPE
         LLZpCHyWIdUmh0FbzY7Ps9U9qyXI3Jv0RJvDLKOg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191115162901.17456-8-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org> <20191115162901.17456-8-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 7/7] MAINTAINERS: Add entry for BM1880 SoC clock driver
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 26 Nov 2019 10:07:10 -0800
Message-Id: <20191126180711.6D93C20835@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-11-15 08:29:01)
> Add MAINTAINERS entry for Bitmain BM1880 SoC clock driver.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next

