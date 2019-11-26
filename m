Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA38C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551602080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574791621;
	bh=IAHo9iyd6JRdEh9K50krnPwE4tP8VZEaFFTzNm1N/Cg=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=aHQMCo8bN553DIyWK5SEVRWBbNchyrvapNj2n7sNNMvrwddZI6SjYR4fm3I5LuFTk
	 84njifxPbqWtQ+vU5rPPJWoOQsAn4Dkf6sD30JNBUqnqvOHb3JIKsfOydoCd/C3/qb
	 7Qf/rkPAJLLAW/mgi8f4ITQqch+YQdXRjYj0F7w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfKZSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfKZSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:06:59 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 058E32080F;
        Tue, 26 Nov 2019 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574791619;
        bh=IAHo9iyd6JRdEh9K50krnPwE4tP8VZEaFFTzNm1N/Cg=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=mlLVWbccFRjg2eF3HiygMX2C1xtVfgUgnoLb9dFj7SWsNx71yNZ5kZGdSIQd0PiT7
         OBeedoP9SmWJmh2eCUv8cVKXA1b3ZoZvGXfmrEOB0SMGySH8DSdiZYYy0il0c0bZ47
         pN2f4y+SrAfY5t4w+E0IR2My8MvftNghp7eM3eRU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191115162901.17456-3-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org> <20191115162901.17456-3-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 2/7] clk: Add clk_hw_unregister_composite helper function definition
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 26 Nov 2019 10:06:58 -0800
Message-Id: <20191126180659.058E32080F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-11-15 08:28:56)
> This function has been delcared but not defined anywhere. Hence, this
> commit adds definition for it.
>=20
> Fixes: 49cb392d3639 ("clk: composite: Add hw based registration APIs")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next

