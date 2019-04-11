Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF62C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FDE2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555014960;
	bh=6MttOoUpqbMkei6qo7YbETh2gVizBK7KbrQpf39kbU0=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=E6dc0c7p55mZkRQsKCrt7K7s85MgmjUzIxk35t0rKbJT39XbiJ3mzVfPe6n4Z78rm
	 xQ3GzV5D9M0waNHYoaWW7S1yTMcmCmWmt3Exzb+i3fV/9S7ABHjd8tyCDcQtmgX3TG
	 V9tfn10EdkZkmmI++mR5E++3zVFUfLRVaoyEE9MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDKUf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDKUf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:35:58 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605882075B;
        Thu, 11 Apr 2019 20:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555014957;
        bh=6MttOoUpqbMkei6qo7YbETh2gVizBK7KbrQpf39kbU0=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=ZVx6MNlZ/jrBjZnI5cj4VGE34ruqVz+kiLskpOVyIN2NFeOjcnZAaJ7Bh9Oei8mmv
         sKI4QhIhEgusE/B0+wRMoqd3M+Exj6FCNJLjpm5wYkpvtBQ9+DWdS6NJFJq72c3LRw
         mQw5rJB2ZCcEDd8Ai3A6Kqz9+fEx1PZwHeSeNc8w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190306174758.22462-2-bjorn.andersson@linaro.org>
References: <20190306174758.22462-1-bjorn.andersson@linaro.org> <20190306174758.22462-2-bjorn.andersson@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: Introduce Qualcomm Turing Clock controller
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <155501495659.20095.9261313353596729372@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:35:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-03-06 09:47:56)
> Add devicetree binding for the turing clock controller found in QCS404.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

