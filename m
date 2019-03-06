Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FDEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311B120663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551914389;
	bh=riS6+SfEG7jkHYQiRqGPo1a3f9Xc+2FEMoV++oOCSO0=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=tUUIS1+9jgQwKtlz1HBkpEX/GiGTGdOuRE532hf4sVAGkE9SySpKE5wR7WNvnOUeq
	 KrKLRjtraAQMCC8hz/GD3K0eGkFdmnSiQs9OWSQArkYKO+PthDalJDogN/VwpLA9b5
	 418LeVoxO1OEduuCFXauKtetUorYdOKR8kv46EeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCFXTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFXTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:19:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E7820663;
        Wed,  6 Mar 2019 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551914386;
        bh=riS6+SfEG7jkHYQiRqGPo1a3f9Xc+2FEMoV++oOCSO0=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=BJOOdb+3tBAcGJHacYATWOway0s/5N9bQoxNb85aRTfDcRGGzcwGt5F5O7tvKpY14
         vfnRSa/Pf7Qv2xGvd3J7ar0Q9dgcTJVbuNnO69Cc7zkVGzemfhT2Kq0mv0M3z/Y/z0
         CwqykIzuH+ExOWWsEwRpcnRBSvTIId1vGRd14kTo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <873279a6-0755-2094-ec99-d9e5f6c963dd@codeaurora.org>
References: <1549911467-2465-1-git-send-email-jhugo@codeaurora.org> <873279a6-0755-2094-ec99-d9e5f6c963dd@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1] clk: Probe defer clk_get() on orphans
Cc:     bjorn.andersson@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jeffrey Hugo <jhugo@codeaurora.org>, mturquette@baylibre.com
Message-ID: <155191438574.20095.6161802248500300707@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 06 Mar 2019 15:19:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-03-06 13:48:13)
> Ping?
>=20
> Stephen, I know as this depends on your clock parent handling series=20
> (happens to apply just fine to v2), its not going to be accepted until=20
> that gets sorted out, but do you have any thoughts on if this seems like =

> an appropriate thing to do, or if you'd like to see a different solution?

Please don't ping during the merge window. I'll probably look at this
patch next week.

