Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7FECE597
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E801B2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571334419;
	bh=7aappbT3eLzTAdvSKgNIdu0j+NqKkso+dGzLeyJjDX8=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=sYrmQfHoticVRlKt/v4imspDe/Qr+NeTNa3sFmBgiUtzenIBT3NX2NBAGVBBrew/v
	 63itc3GMOhAocvsTm9lAm79ydYTrwmLytBCYxrEZTAmKKngoE8JAnTNupHSqqwDwzS
	 /R8YxSRDvvV9QYFpfFQkI1/MygUMB/mpsyfauXTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441008AbfJQRq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440901AbfJQRqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:46:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5162089C;
        Thu, 17 Oct 2019 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571334405;
        bh=7aappbT3eLzTAdvSKgNIdu0j+NqKkso+dGzLeyJjDX8=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=Jez3uOmRLaF81wEIywT7Qe88qN1j4KCSjXOyf1TOCXeqBRkoazvT3dUKP5ZZtculK
         4PtdBuTJKQ4TglRyc2gX/0OVc05WKiO/ZiLaNX+5sUfmXDjo2IX1zs+/SttLWFVcL7
         q8i/rpFfTsN19vYO3e+QPEvi0SfZ+5BTZnhXNXKE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5f1ca3bfc45e268f7f9f6e091ba13b8103fb4304.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org> <5f1ca3bfc45e268f7f9f6e091ba13b8103fb4304.1571307382.git.amit.kucheria@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, daniel.lezcano@linaro.org,
        edubezval@gmail.com, ilina@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, tdas@codeaurora.org, viresh.kumar@linaro.org
Cc:     linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/5] clk: qcom: Initialise clock drivers earlier
User-Agent: alot/0.8.1
Date:   Thu, 17 Oct 2019 10:46:44 -0700
Message-Id: <20191017174645.5A5162089C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-10-17 03:30:53)
> Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
> can have earlier access to cpufreq during booting.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

Makes me sad though.

