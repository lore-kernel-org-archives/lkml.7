Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E9C282DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9802821479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555624366;
	bh=gLXCV4FGL2jR1jOuXb6fdPCLEXWaqgPJN6RgusMWvzA=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=w4MIei77J064nr7QX20Q0TH9wva8+P3aqOfIs3jjvG5rK5WtvmW6kxrAIqv6yHyUy
	 00OZgvS4eArCats+T9/WJ+JOkI1kOz2o3z1dyMwfpsv/qTyjOCkfmJqBncq8T84rGf
	 B7Wc/N5oXf/S4QuH2iVr28zfVnO1FyRtpMFD57ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDRVwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfDRVwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:52:45 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18C720693;
        Thu, 18 Apr 2019 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555624364;
        bh=gLXCV4FGL2jR1jOuXb6fdPCLEXWaqgPJN6RgusMWvzA=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Qaer8UtsZgLsy2yfpTqlRxcfjzbsLcvI6aXHAQ7P/FQ6WRsXmeVS62y8b4oZJNjfV
         Cdkso94mKRf3q9NfjdXljJOanIjndR6DotFuJWmmgsL3ABACj43bSB+SCJioPWP8R7
         dD77Wb0ctj8xCkBG4Kd+E3ikIwuBImPECIkZw5z0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190418053339.GA4524@leoy-ThinkPad-X240s>
References: <20190320100508.6950-1-leo.yan@linaro.org> <20190418053339.GA4524@leoy-ThinkPad-X240s>
Cc:     stable@vger.kernel.org, Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: hi3660: Mark clk_gate_ufs_subsys as critical
To:     Leo Yan <leo.yan@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155562436407.15276.5265889537123283982@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 18 Apr 2019 14:52:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leo Yan (2019-04-17 22:33:39)
> Hi Michael, Stephen,
>=20
> On Wed, Mar 20, 2019 at 06:05:08PM +0800, Leo Yan wrote:
> > clk_gate_ufs_subsys is a system bus clock, turning off it will
> > introduce lockup issue during system suspend flow.  Let's mark
> > clk_gate_ufs_subsys as critical clock, thus keeps it on during
> > system suspend and resume.
>=20
> Could you pick up this patch?  Or should I resend it?
>=20

I can pick it up. Is it critical or can it wait for v5.2?

