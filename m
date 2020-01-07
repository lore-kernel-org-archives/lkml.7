Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64679C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A91207FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578380284;
	bh=K86VugSjTF50Rmyj5eoMI/O+FBhJomS0lqSgS1UytY8=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=R80loFofNmI7BUGXB55R/2tvFrVhRO3VNrMQmJcYoCeWK+RDkpBdmx+fsMlwibfBJ
	 GPq9fS33K+G3WQ2QdzWZWhcJsfRa0kHnenkl9vPOHj2n3U1/2SjqlKSLrB9qAgbN9a
	 b+DUtG/pWMNxTL4JXeysYfmyI3aFXo6PCRp4NeaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgAGG6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbgAGG6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:58:01 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C85E207E0;
        Tue,  7 Jan 2020 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380280;
        bh=K86VugSjTF50Rmyj5eoMI/O+FBhJomS0lqSgS1UytY8=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=a1cJOkMPqh/2pFOcMCQ4/S3xtWKQB028jBYmrimjP5KrY9vDvUvbvhVPlwHEMh5wM
         2nfxv7hk52m0xA5S4MnlvTkvfq+gj9sixQ6uSzASN7gM81Ffz/7DekuXOPlF60yPu6
         KB7MvReyF7PYZokXECc/SIiqOcTZI0s9h+Xiab94=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-11-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-11-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 10/12] clk: mux: Add support for specifying parents via DT/pointers
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:57:59 -0800
Message-Id: <20200107065800.6C85E207E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:21)
> After commit fc0c209c147f ("clk: Allow parents to be specified without
> string names") we can use DT or direct clk_hw pointers to specify
> parents. Create a generic function that shouldn't be used very often to
> encode the multitude of ways of registering a mux clk with different
> parent information. Then add a bunch of wrapper macros that only pass
> down what needs to be passed down to the generic function to support
> this with less arguments.
>=20
> Note: the msm drm driver passes an anonymous array through the macro
> which seems to confuse my compiler. Adding a parenthesis around the
> whole thing at the call site seems to fix it but it must be wrong. Maybe
> it's better to split this patch and pick out the array bits there?
>=20
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

