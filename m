Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF0C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D51206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578380277;
	bh=1XwgbMHjV/QfVJb8ecYglpGF1+QGhi5JI/MMf0wZwSs=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=NsMAD6HucsDTyKSJRekrrds3kGl5C39as/un3dfD/97/mv8vWZtBZFjFoXm+m0xIW
	 OlvzXdtEC9FiN91ntLAnRzw0K2bfdy7LJUsAIOmcRUhWgrR56zhvPaLuidFdfVS7Ta
	 i35MQ+TkvrwHswzU/RIW6KJPTgNqGjb4fe0DFytM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgAGG54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGG5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:57:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D12206DB;
        Tue,  7 Jan 2020 06:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380273;
        bh=1XwgbMHjV/QfVJb8ecYglpGF1+QGhi5JI/MMf0wZwSs=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=dvj2U7KbyAtF3mG4QDSBghOEO60+NABhN6qujbWjBKivEJ1fd5vQ6dLFHdno2adGF
         xkzI+GR1TVr3DnsiYsfAjM6kbFPzxrZnN45WanRvTAPhyqJOgz35gLM3r+QRpJzB/7
         8/q7Eai9kfD2T9vXjqYdjIL8LMoLwBfCfr9RRWAU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-9-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-9-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 08/12] clk: fixed-rate: Document that accuracy isn't a rate
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:57:52 -0800
Message-Id: <20200107065753.41D12206DB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:19)
> This kernel-doc talks about a rate for the accuracy. That's wrong.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

