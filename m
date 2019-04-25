Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE1C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DAA2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556225706;
	bh=AlS0Qcs/PcQ/qPO4QHdoBwpsX+ttCm+673kx0Ce6bAw=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=12yPxeez18XWTzhuRtSqH//XeNPtRmRSAmCRFlqSpeoEZZ/uj2l2AqRwdFg+IV9bC
	 7GNAg4l9kk5m836Mglgr5SyV3hsgZz9zSDonOj17dkV+ev0v2X7RSgjR0cheuctkT0
	 lzg1mWXdhqJl7tWWmVmUUJJuljRk8uAMDvuE4swk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfDYUzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387630AbfDYUzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:55:01 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED38206BF;
        Thu, 25 Apr 2019 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556225700;
        bh=AlS0Qcs/PcQ/qPO4QHdoBwpsX+ttCm+673kx0Ce6bAw=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=T/BUWe7eRv8C5OTukEdyTK/uLafVud53nkxS6ZfbL+yohX9bQTmtI0TCyvBziVAZ0
         pPxUjnqvpnb/qPL1jdqjVO1bcTpLGHAtKO9kHGJbVwRfakZ9/r1M4KRgkVhzNVCZa8
         MQJADYByeh3o81xXvrZ5TojpmkQjOiPlot7QSUGQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190414192321.23294-3-digetx@gmail.com>
References: <20190414192321.23294-1-digetx@gmail.com> <20190414192321.23294-3-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/5] clk: tegra: emc: Support multiple RAM codes
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155622569977.15276.16514341758951287015@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 13:54:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-14 12:23:18)
> The timings parser doesn't append timings, but instead it parses only
> the first timing and hence doesn't store all of the timings when
> device-tree has timings for multiple RAM codes. In a result EMC scaling
> doesn't work if timings are missing.
>=20
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next

