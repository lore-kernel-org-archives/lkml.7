Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E537C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335DB207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578379461;
	bh=9No+cJZGOd6fLB+Swq3QAcczYfomt4hZ4rmn37/n5cU=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=ztTxhSYKJAn+Dm2uP0TVv5gk607ECJe/0k3tcyO1a7Bio8gan/f0lSrPcWhnGTS1h
	 iDZMyAHN0RaAmU8xnApGtN3YLPtHsJnLz4fk/yCA6k+rctj6H/Fs6RF23aGUmCrYQK
	 UPkn95hz9cZLg5GAT/eDGoM/35FgaDgwMbr4shII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgAGGoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGGoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:44:19 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F1ED207E0;
        Tue,  7 Jan 2020 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578379459;
        bh=9No+cJZGOd6fLB+Swq3QAcczYfomt4hZ4rmn37/n5cU=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=gI3Dg6oAyWJgi8W8uSOfJGpae2+1Bo1khMhwWrWhsA5O4LO39S8Dnn13oxl/u7TOH
         PGSpVo0yD2lxTo71W6lGMS1uhxAHjfqKsIaQSVvZAVu3Vyh8O4ANXKThVSlKDJEtdy
         nKV2S9cI0gnLD9WBDef41pvswbSH/ciRNiBz2qMY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-5-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-5-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 04/12] clk: fixed-rate: Move to_clk_fixed_rate() to C file
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:44:18 -0800
Message-Id: <20200107064419.3F1ED207E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:15)
> The only user of this macro is the fixed rate basic type. Move it there
> to avoid polluting provider drivers.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

