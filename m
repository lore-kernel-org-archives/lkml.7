Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC38C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCCD2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556205462;
	bh=YkLb91M8d3SPGJOA8WtmE/vSLqnU7wIEtymcLOfLMnI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=jQ+zUYyHal3wpcTeQIYATQVC5JXjIKUe/w3MWHn7h9jUtG7WysL5Q4WTKSNWvQ02q
	 V1Dcr5PbhVpXmgbYb2PITlmSSukSg/T1DZf1yGSuY6/opTWl4iEpIlbD5t4kJ+5sLg
	 37bxYK4ZceVFmFrX8RPMXt8+onjT8SWDkXEv3f5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfDYPRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDYPRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:17:40 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2203D2067D;
        Thu, 25 Apr 2019 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556205460;
        bh=YkLb91M8d3SPGJOA8WtmE/vSLqnU7wIEtymcLOfLMnI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=GRLvkgyyKM1N2e+m986yhNCKZkMK90biOImKebgujCAkMVotQ/imrRMCKdZXRPUC8
         HRLP2u1T1tj5oWzUP6beWrgBTfcYGKs3uyv7f7t/J2IZ4yZb8LLnT2+lQcZ8V3MF1L
         CF3Pbm6NAfOpw1hNKMxyi6kM4yz5cbsWhvVeGumk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190411214835.19947-3-digetx@gmail.com>
References: <20190411214835.19947-1-digetx@gmail.com> <20190411214835.19947-3-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 2/2] clk: tegra124: Remove lock-enable bit from PLLM
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155620545907.15276.14629311287072608722@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 08:17:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-11 14:48:35)
> According to the Tegra124 TRM documentation, PLLM_MISC2 register doesn't
> have the lock-enable bit as well as any other PLLM-related register. Hence
> PLLM re-locking can't be initiated by software. The incorrect bit setting
> should have been harmless since that bit is undefined according to TRM.
>=20
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next

