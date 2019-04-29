Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E3C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF12215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556578591;
	bh=yXWHKubp7eGa3UoDVHyla+JGD8NiP4rV2Qe7y1ELTtQ=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=EIzJWxU+tddFYGhwApPrdR/qAuPoMw4/IlNX/V19brB//7KyTJUhj6AOOAx48mBjc
	 F6Oi4Zos61/z8ni8RoUBirjrxgjf0DGM0iEXlNILOG2tx9ddtY+u1LP4WG4/pkdCA/
	 R5XSQG3feq0EhwqgG4iprFBWYnqRYXRVUx2YKIYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfD2W4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbfD2W4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:56:30 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573572075E;
        Mon, 29 Apr 2019 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556578589;
        bh=yXWHKubp7eGa3UoDVHyla+JGD8NiP4rV2Qe7y1ELTtQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=KSmULu9Q7s2Li6tqMGI3QDi8P2Yb4j0jqhxUFeAeWv5fd1lzmlbm10LuPa9rYJFru
         CBkHSqzpA8UlNdzuLasLUPvGb5GS1GpSuqJYaYzD9YqcAGXkWtyKeLt/+gNRd8yjSG
         SwZ0gj7S0zwXJ/23fKD1uWD8IWFgYQUd2iez/SsM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190411082733.3736-3-paul.walmsley@sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <20190411082733.3736-3-paul.walmsley@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: clk: add documentation for the SiFive PRCI driver
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
Message-ID: <155657858858.168659.15376308496117600451@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 15:56:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-11 01:27:34)
> Add DT binding documentation for the Linux driver for the SiFive
> PRCI clock & reset control IP block, as found on the SiFive
> FU540 chip.
>=20
> This version includes changes requested by Stephen Boyd
> <sboyd@kernel.org> and Rob Herring <robh@kernel.org>, and
> fixes some errors in the initial version.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---

Applied to clk-next

