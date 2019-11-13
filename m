Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D7C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5369A206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573686264;
	bh=hVxRaAKO0Uplv/Oc7yoFCmBYC10wOCMNRXTieFKdhrs=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=HdrSepQXHYSZh34GnwkMxHWemLbVRszGzfz9ceahiayP1Zdxj/RoHr6OZIHryyEoi
	 VA+w6OnUNEmIBb3GssmGv67sEoOHFQTGQ+pluNazXATri0HhYyS0zmUVHwNzbo5ffh
	 dkIelHOVbk3w95oH2++K1j3/1svAs1RoYgo3l8AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKMXEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfKMXEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:04:21 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A04206E3;
        Wed, 13 Nov 2019 23:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573686262;
        bh=hVxRaAKO0Uplv/Oc7yoFCmBYC10wOCMNRXTieFKdhrs=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=EqDjLfdAniDVLR4+36d5vVDB7xvMJ/Q3raqmT+k9PWjKTYmtb9RUheNBn9/YELbxZ
         Q9Ioc0G+laMtSa/ZCii9zf3BAQftZ4FVYvUDKBS0h2KG5s1ai8qgrtdUIdpAGGtzBL
         z7oS7+JtuNmx1d6pBQkpPLSbVC1ndJn4cVxxYNlU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191109034226.21044-1-yuehaibing@huawei.com>
References: <20191109034226.21044-1-yuehaibing@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, jonathanh@nvidia.com,
        mturquette@baylibre.com, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, thierry.reding@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH -next] clk: tegra: Use match_string() helper to simplify the code
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 15:04:20 -0800
Message-Id: <20191113230422.48A04206E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-11-08 19:42:26)
> match_string() returns the array index of a matching string.
> Use it instead of the open-coded implementation.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

