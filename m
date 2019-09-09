Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ABCC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697F21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568029318;
	bh=DdcqA05sb3eqKRvdBNUo2gdcyimo6S9TMK/aUMCKo0E=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=NQ8SyDeOqAt3qVk+5oYJqqKp5gAUYMcr8AndPQVBPUdKmYcH1meWpZQ5gRka1U0ch
	 ugQSUJ5GknjhuPCuxKskC0sKY0VfYWEiiMUJTACGbAqlkzh15IS46AoVsZ0QfxkzHK
	 PhDJS3y3BjFcTSNTiMGFyerjsuz7lkOEhXr8fhjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbfIILl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbfIILlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:41:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E40218AF;
        Mon,  9 Sep 2019 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568029315;
        bh=DdcqA05sb3eqKRvdBNUo2gdcyimo6S9TMK/aUMCKo0E=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=WyQ8jiQ7tTY/AWeYJrgqnYiNYDRPVjz+k7THIhOyu61JYUpM2+8Rx3RWmbjVBV3/1
         GGhaB0jSMEJrVhlT/OmhoskizQGkY4d5IjPs/6tvaI50nszmGyjjnPTv3DrJBL5XAj
         OZRCLTD/wKOXMEA/8F5QvY4X4VkDfLFqmHMpJYgQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826173120.2971-2-vkoul@kernel.org>
References: <20190826173120.2971-1-vkoul@kernel.org> <20190826173120.2971-2-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: clock: Document the parent clocks
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 04:41:54 -0700
Message-Id: <20190909114155.32E40218AF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-26 10:31:17)
> With clock parent data scheme we must specify the parent clocks for the
> rpmhcc nodes. So describe the parent clock for rpmhcc in the bindings.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

