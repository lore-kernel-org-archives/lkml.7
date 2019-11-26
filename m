Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9200C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6482080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574791617;
	bh=BIHjdWNy2FSclmtpzSgtK2Gx2rJcf2TAWNwE4x0yk8w=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=wC8pWBAVeIRfmndvJXo/Y1g/KKEA2FpEZ5yBY/HkDro34HmcKkp87X8yxyy7SPOYb
	 KJSL57LI5PG/YgPt0tXN9dOWhX5nnXE3GGJaZD4kalWnx1DtAOD9k4fDc+4t0naWSv
	 nuGCGw9dBKI9GArfis877u/7Qf1NJwnzfcSfiSok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKZSG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfKZSG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:06:56 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA8020727;
        Tue, 26 Nov 2019 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574791615;
        bh=BIHjdWNy2FSclmtpzSgtK2Gx2rJcf2TAWNwE4x0yk8w=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=HXThmMmiUsomN57YsdQGyLVL/eAWt6fSU/WCNRn3LQjZSdxbn4Ca7alQPd1CT4lSc
         jqKPEIRjzQK532yHw/7+Snp7bPu1SuBllhGZAkWpZA685aspwcfMW20qNNADtb4s6c
         8UqhDfVP96BVLIEJehQCS8O5HLnkMoROHm8QfA4Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191115162901.17456-2-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org> <20191115162901.17456-2-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 1/7] clk: Zero init clk_init_data in helpers
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 26 Nov 2019 10:06:54 -0800
Message-Id: <20191126180655.CAA8020727@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-11-15 08:28:55)
> The clk_init_data struct needs to be initialized to zero for the new
> parent_map implementation to work correctly. Otherwise, the member which
> is available first will get processed.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next

