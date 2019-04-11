Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E48C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472D52075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555014964;
	bh=N1TB/R4ImzyIF7AUvF959XYprkjXkVoTXpaz7F0btO4=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=iIYaFSXO9FcArJmqH+AXSLYiteB4PuGS3PzNv3Le91Mp0CSLOsKLidpS3WV0dMwou
	 yUH4ZkY0ets/jcTh/+os/Kvja8u7c0joyWzMThP/hcuNxhnhMZTtxdsQBwTCSBKUDa
	 wt9aUN9RNFVicHopq5IMfdxX8KVRwe5JSTdaUKvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDKUgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDKUgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:36:01 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CA22184B;
        Thu, 11 Apr 2019 20:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555014961;
        bh=N1TB/R4ImzyIF7AUvF959XYprkjXkVoTXpaz7F0btO4=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=q44wncZogMCxyMvZQafMayL9d3L085llkb0gvtyAf8r2xIWpquRLwdp3zFwcnra8d
         JL0IID/VsbctQ1A7j2i6H8ErbqU47t9Pd7Arj9AuuOBgBjy1cTrV30zHBbx959um+1
         gnYTUpeMRFGWTTbtdA8bVgIcrzy8IZVUCr6eAdOo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190306174758.22462-3-bjorn.andersson@linaro.org>
References: <20190306174758.22462-1-bjorn.andersson@linaro.org> <20190306174758.22462-3-bjorn.andersson@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/3] clk: qcom: branch: Add AON clock ops
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155501496005.20095.2471820248377711302@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:36:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-03-06 09:47:57)
> Some clocks can only be turned on by resetting the block containing
> them, provide a clock type that allow us to reference these clocks and
> have the client drivers enable and "disable" them.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

